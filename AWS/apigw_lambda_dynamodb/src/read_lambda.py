import json
import boto3
from botocore.exceptions import ClientError
# from decimal import *


# class DecimalEncoder(json.JSONEncoder):
#     def default(self, o):
#         if isinstance(o, Decimal):
#             return str(o)
#         return super(DecimalEncoder, self).default(o)

def get_key(request):
    return request.get('pathParameters')


def response_status(request, response):
    _response = {'headers': {'Content-Type': 'application/json'}}

    if response.get("Item") or response.get("Error"):
        _response["body"] = dict(**response)
    elif not response:
        _response["statusCode"] = 400
        _response["body"] = f"Bad request."
    else:
        _response["statusCode"] = 404
        _response["body"] = f"Not found key {get_key(request)}."

    return _response


def get_parameter_id(request, context):
    try:
        table = boto3.resource("dynamodb").Table("customer_info")
        customer = get_key(request)
        response = table.get_item(Key=customer)
    except ClientError as e:
        response = e.response

    return response


def read_lambda_handler(event, context):
    response = {}
    rk = event.get("routeKey")
    if rk and rk == "GET /customer/{customer_id}":
        response = get_parameter_id(event, context)

    # return response_status(event, response)
    return json.dumps(response_status(event, response))
