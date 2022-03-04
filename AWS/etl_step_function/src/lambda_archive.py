import boto3
import os
import json

def lambda_archive_handler(event, context):
    s3 = boto3.client('s3')
    bucket = event.get("s3").get("bucket")
    old_key = event.get("s3").get("key")
    
    new_key = os.path.join("archive", os.path.basename(old_key))
    s3.put_object(Bucket=bucket, Key=new_key)
    s3.delete_object(Bucket=bucket, Key=old_key)