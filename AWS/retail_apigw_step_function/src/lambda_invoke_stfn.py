import json
import boto3
import uuid
from botocore.exceptions import ClientError


def lambda_invoke_stfn_handler(event, context):
    try:
        transaction_id = str(uuid.uuid1())
        input = event.get("body")

        step_fn_cl = boto3.client('stepfunctions')
        response = step_fn_cl.start_execution(
            input=input,
            stateMachineArn="<STATE_MACHINES_ARN>",
            name=transaction_id
        )

    except ClientError as e:
        print(e.response)
        print(f'Error parsing request.')
        raise e

    return json.dumps(response.get("ResponseMetadata"))
