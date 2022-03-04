import json
import boto3
from botocore.exceptions import ClientError
from boto3.dynamodb.conditions import Key, Attr
from decimal import *


def get_table_name(request):
    return json.loads(request.get("body"))["table_name"]


def get_table_data(request):
    return json.loads(request.get("body")).get("table_data")


def get_table_key(request):
    return json.loads(request["body"])["key"]


def operation(func):
    def wrapper(event, context):
        response = []
        table = boto3.resource('dynamodb').Table(get_table_name(event))
        data = get_table_data(event)
        key = get_table_key(event)
        for item in data:
            try:
                response.append(func(table, item, key))
            except ClientError as e:
                response.append(e.response)
        return response
    return wrapper


@operation
def put_item(table, item, key):
    return table.put_item(Item=item, ConditionExpression=Attr(key).not_exists())


@operation
def delete_item(table, item, key):
    return table.delete_item(Key=item, ConditionExpression=Attr(key).exists())


@operation
def update_item(table, item, key):
    return table.put_item(Item=item, ConditionExpression=Attr(key).exists())


def response_status(request, response):
    _response = {'headers': {'Content-Type': 'application/json'}, 'body': []}

    if not response:
        _response["statusCode"] = 400
        _response["body"].append(f"Bad request.")

    for resp in response:
        if resp.get("ResponseMetadata") or resp.get("Error"):
            _response["body"].append(dict(**resp))
        else:
            _response["statusCode"] = 404
            _response["body"].append(
                f"Not found key {get_table_data(request).get('customer_id')}.")

    return _response


def write_lambda_handler(event, context):
    response = {}

    rk = event.get('routeKey')
    if rk and rk == "POST /customer":
        response = put_item(event, context)
    elif rk and rk == "PUT /customer":
        response = update_item(event, context)
    elif rk and rk == "DELETE /customer":
        response = delete_item(event, context)

    # return response_status(event, response)
    return json.dumps(response_status(event, response))
