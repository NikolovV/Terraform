import boto3
import os
import json
from botocore.exceptions import ClientError
from boto3.dynamodb.conditions import Key, Attr


def get_table(request):
    #return boto3.resource('dynamodb', endpoint_url="http://localhost:8000").Table("bank-service")
    return boto3.resource('dynamodb').Table(os.environ['TABLE_NAME'])


def get_account(request, table_db):
    account = table_db.query(ProjectionExpression="account",
                             KeyConditionExpression=Key('customer_id').eq(request.get("customer_id")))

    if not account.get("Items"):
        raise Exception("Wrong parameter for account.")

    return account.get("Items")[0]


def check_availability(request, account):
    total_price = sum([int(x.get("qty")) * float(x.get("unit_price"))
                      for x in request.get("orders")])
    balance = float([acc.get("balance") for acc in account.get("account") 
                        if request.get("card_id") == acc.get("card_id")][0])
    return total_price <= balance


def check_availability_handler(event, context):
    response = {"availability": True, "Error": ""}

    try:
        table = get_table(event)
        account = get_account(event, table)
        check_availability(event, account)

    except ClientError as e:
        response["availability"] = False
        response["Error"] = e.response

    return response
