# Uploud file to S3 specific folder
aws s3 cp test/simple_put_rqs.json "s3://$(terraform output -raw bucket_name)/daily/simple_put_rqs.json"
aws s3 cp test/simple_put_rqs_update.json "s3://$(terraform output -raw bucket_name)/daily/simple_put_rqs_update.json"