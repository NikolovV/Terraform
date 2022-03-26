import json

def lambda_handler(event, context):
    status_code = 200
    
    for k, v in event.items():
        print(k, v)
    
    if "name" in event.keys():
        body = json.dumps(f"Hello {event.get('name')} from Lambda {context.function_name}!")
    else:
        status_code = 400
        body = json.dumps("Key \"name\" is not provided.")
    
    return {
        'statusCode' : status_code,
        'body' : body
    }
