import json
import boto3
import urllib.parse
import uuid
from botocore.exceptions import ClientError


def get_bucket(event):
    return event['Records'][0]['s3']['bucket']['name']


def get_key(event):
    return urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')


def get_s3_data(response):
    return json.loads(response.get("Body").read())


def s3_lambda_stfn_handler(event, context):
    s3 = boto3.client('s3')
    bucket = get_bucket(event)
    key = get_key(event)
    print(event)
    try:
        s3_response = s3.get_object(Bucket=bucket, Key=key)
        file_data_content = get_s3_data(s3_response)

        transaction_id = str(uuid.uuid1())

        """ According AWS Step Functions Developer Guide
        Alternatively, if the Lambda function data you are passing between states might grow to more than 262,144 bytes, 
        we recommend using Amazon S3 to store the data, 
        and parse the Amazon Resource Name (ARN) of the bucket in the Payload parameter to get the bucket name and key value. """
        input = json.dumps({"s3" : {"bucket" : bucket, "key" : key}, "data": file_data_content})

        step_fn_cl = boto3.client('stepfunctions')
        response = step_fn_cl.start_execution(
            stateMachineArn="<STATE-MACHINE-ARN>",
            name=transaction_id,
            input=input
        )

    except ClientError as e:
        print(e.response)
        print(
            F'Error getting object {key} from bucket {bucket}. Make sure they exist and your bucket is in the same region as this function.')
        raise e
