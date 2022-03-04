import json
import os

import boto3
from boto3.dynamodb.conditions import Attr, Key
from botocore.exceptions import ClientError


def get_table(request):
    #return boto3.resource('dynamodb', endpoint_url="http://localhost:8000").Table("shop-service")
    return boto3.resource('dynamodb').Table(os.environ['TABLE_NAME'])


def check_stock_availability(request, table_db):
    available = True

    for order in request.get("orders"):
        qty = table_db.get_item(Key={"item_id": order.get("item_id")}, 
                                ProjectionExpression="qty").get("Item")

        if qty and int(qty.get("qty")) < int(order.get("qty")) or not qty:
            available = False
            break

    return available


def check_stock_handler(event, context):
    response = {"availability": True, "Error": ""}

    try:
        table = get_table(event)
        response["availability"] = check_stock_availability(event, table)

    except ClientError as e:
        response["availability"] = False
        response["Error"] = e.response

    return response
