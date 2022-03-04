## Lightweight ETL.
---
S3, Lambda, DynamoDB</br>
**Resources:**</br>
>[Bulk data ingestion from S3 into DynamoDB via AWS Lambda](https://medium.com/analytics-vidhya/bulk-data-ingestion-from-s3-into-dynamodb-via-aws-lambda-b5bdc30bd5cd)</br>
>[AWS Documentation](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-dynamo-db.html)</br>
##### Terraform modules:
---
> [AWS Lambda](https://registry.terraform.io/modules/terraform-aws-modules/lambda/aws/latest) - Terraform module, which takes  care of a lot of AWS Lambda/serverless tasks (build dependencies, packages, updates, deployments) in countless combinations</br>
> [AWS DynamoDB table](https://registry.terraform.io/modules/terraform-aws-modules/dynamodb-table/aws/latest) - Terraform module which creates DynamoDB table on AWS</br>

##### Terraform resources:
---
> [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) - Provides a S3 bucket resource.</br>
> [aws_s3_bucket_notification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) - Manages a S3 Bucket Notification Configuration</br>

## Features
---
- On object create in S3 bucket, S3 notification trigger lambda.
- Lambda load json file in DynamoDB and return json response.
- Inherit BatchWriter class in boto3 to add batch operation response

## Requirements
| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 3.27.0 |

## Providers
| Name | Version |
|------|---------|
| aws | >= 3.27.0 |

##### Variables
---
| Name | Description | Type | Required |
| ------ | ------ | ------ | ------ | 
| aws_region | AWS region | String | No |
| resource_tags | Tags to set for resources | map(string) | No |
| db_config | DynamoDB configurations - table name and key | map(string) | No |
| db_atributes | DynamoDB table attributes | list(map(string)) | No |
| lambda_config | Configuration parameters map for both read / write lambda | map(any) | No |
| bucket_config | Default S3 bucket configuration |  map(string) | No |
| s3_notofication_events | Default S3 notification events list | list(string) | No |
| s3_notofication_filter_prefix | Default S3 bucket folder for notification. | String | No |
| lambda_s3_file_name | Source file name of lambda | String | No |
| s3_triggers | Configuration for s3 lambda allowed_triggers |  map(any) | No |

##### Output
---
| Name | Description |
| ------ | ------ |
| bucket_name | S3 bucket name |
| table_name | DynamoDB table name |

#### License
---
Apache 2 Licensed. See LICENSE for full details.
