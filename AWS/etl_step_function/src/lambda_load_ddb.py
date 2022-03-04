import json
import boto3
from boto3.dynamodb.table import BatchWriter
import os

table_name = "customer_info"


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


def batch_write_dynamodb(data):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(table_name)

    response = []
    with DynamodbBatchWriter(table_name=table.name, client=dynamodb) as bw:
        for item in data:
            try:
                bw.put_item(Item=item)
            except ClientError as e:
                response.append(e.response)

    return bw.get_responce() if not response else response


def response_status(response):
    _response = {"loadResult" : False, "Error" : ""}

    for resp in response:
        if resp.get("ResponseMetadata"):
            _response["loadResult"]= True
        elif resp.get("Error"):
            _response["loadResult"] = False
            _response["Error"] = resp.get("Error")
            break
        else:
            _response["loadResult"] = False
            _response["Error"] = "Something went wrong."

    return _response


def lambda_load_handler(event, context):
    print(event)
    try:
        ddb_response = batch_write_dynamodb(event.get("data"))
    except Exception as e:
        print(e)
        raise e

    return response_status(ddb_response)
