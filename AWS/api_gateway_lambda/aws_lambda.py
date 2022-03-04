import json

def apigw_lambda_handler(event, context):
    http_status_code = 200
    
    body = f"event: {type(event)}\n"

    for k, v in event.items():
        print(k, v)

    #if "name" in event.keys():
    if event.get('queryStringParameters') and event.get('queryStringParameters')['name']:
        body += json.dumps(f"Hello {event.get('queryStringParameters')['name']} from Lambda {context.function_name}!")
    else:
        http_status_code = 400
        body += json.dumps("Key \"name\" is not provided.")

    return {
        'statusCode' : http_status_code,
        'headers' : {'Content-Type': 'application/json'},
        'body' : body
    }