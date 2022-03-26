import json
import boto3
import urllib.parse
import os
from boto3.dynamodb.table import BatchWriter


class DynamodbBatchWriter(BatchWriter):
    """
    Inherit BatchWriter to add batch operation response.
    """

    def __init__(self, table_name, client, flush_amount=25, overwrite_by_pkeys=None):
        super().__init__(table_name, client, flush_amount, overwrite_by_pkeys)
        self._response = []

    def get_responce(self):
        return self._response

    def _flush(self):
        items_to_send = self._items_buffer[:self._flush_amount]
        self._items_buffer = self._items_buffer[self._flush_amount:]
        response = self._client.batch_write_item(
            RequestItems={self._table_name: items_to_send})
        unprocessed_items = response['UnprocessedItems']
        self._response.append(response)

        if unprocessed_items and unprocessed_items[self._table_name]:
            # Any unprocessed_items are immediately added to the
            # next batch we send.
            self._items_buffer.extend(unprocessed_items[self._table_name])
        else:
            self._items_buffer = []


def get_bucket(event):
    return event['Records'][0]['s3']['bucket']['name']


def get_key(event):
    return urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')


def get_s3_data(response):
    return json.loads(response.get("Body").read())


def batch_write_dynamodb(data):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(os.environ['TABLE_NAME'])

    response = []
    with DynamodbBatchWriter(table_name=table.name, client=dynamodb) as bw:
        for item in data:
            try:
                bw.put_item(Item=item)
            except ClientError as e:
                response.append(e.response)

    return bw.get_responce() if not response else response


def response_status(request, response):
    _response = {'headers': {'Content-Type': 'application/json'}, 'body': []}

    for resp in response:
        if resp.get("ResponseMetadata") or resp.get("Error"):
            _response["body"].append(dict(**resp))
        else:
            _response["statusCode"] = 404
            _response["body"].append(f"Not found.")

    return _response


def lambda_s3_handler(event, context):
    s3 = boto3.client('s3')
    bucket = get_bucket(event)
    key = get_key(event)

    try:
        s3_response = s3.get_object(Bucket=bucket, Key=key)
        file_data_content = get_s3_data(s3_response)
        ddb_response = batch_write_dynamodb(file_data_content)

    except Exception as e:
        print(e)
        print(F'Error getting object {key} from bucket {bucket}. Make sure they exist and your bucket is in the same region as this function.')
        raise e

    return json.dumps(response_status(event, ddb_response))
