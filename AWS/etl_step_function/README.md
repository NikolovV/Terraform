## Simple ETL.
---
**S3, Lambda, Step Function, DynamoDB**</br>
**Resources:**</br>
>[Invoke AWS Lambda from AWS Step Functions with Terraform](https://nahidsaikat.com/blog/invoke-aws-lambda-from-aws-step-functions-with-terraform/)</br>
>[StartExecution](https://docs.aws.amazon.com/step-functions/latest/apireference/API_StartExecution.html)</br>
>[Start an AWS Step Function Workflow From Lambda](https://www.youtube.com/watch?v=kpuqc_7DQZA)</br>
>[Input and Output Processing in Step Functions](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-input-output-filtering.html)</br>
>[Boto3 documentation](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3.html)</br>
>[Amazon States Language](https://states-language.net/)</br>

##### Terraform modules:
---
> [AWS Lambda](https://registry.terraform.io/modules/terraform-aws-modules/lambda/aws/latest) - Terraform module, which takes  care of a lot of AWS Lambda/serverless tasks (build dependencies, packages, updates, deployments) in countless combinations</br>
> [AWS DynamoDB table](https://registry.terraform.io/modules/terraform-aws-modules/dynamodb-table/aws/latest) - Terraform module which creates DynamoDB table on AWS</br>
> [Step Functions](https://registry.terraform.io/modules/terraform-aws-modules/step-functions/aws/latest?tab=inputs) - erraform module which creates Step Functions on AWS</br>
##### Terraform resources:
---
> [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) - Provides a S3 bucket resource.
> [aws_s3_bucket_notification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) - Manages a S3 Bucket Notification Configuration

## Features
---
- On object create in S3 bucket (must be valid json object), S3 notification trigger lambda.
- Lambda load json file in DynamoDB and return json response.
- Inherit BatchWriter class in boto3 to add batch operation response

## Requirements
| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | ~> 3.60 |

## Providers
| Name | Version |
|------|---------|
| aws | ~> 3.60 |

##### Variables
---
| Name | Description | Type | Required |
| ------ | ------ | ------ | ------ | 
| aws_region | AWS region | String | No |
| resource_tags | Tags to set for resources | map(string) | No |
| bucket_config | Default S3 bucket configuration | map(string) | No
| s3_notofication_events | Default S3 notification events list | list(string) | No
| s3_notofication_filter_prefix | Default S3 bucket folder for notification. | string | No
| db_config | DynamoDB configurations | map(string) | No
| db_atributes | DynamoDB attributes | list(map(string)) | No
| lambda_s3_file_name | Source file name of lambda | string | No
| lambda_load | Source file name of lambda load | string | No
| lambda_archive | Source file name of lambda archive | string | No
| s3_triggers | Configuration for s3 lambda allowed_triggers | map(any) | No
| lambda_s3_stfn_config | Configuration map for both lambda s3 | map(any) | No
| lambda_load_dynamodb_config | Configuration map for lambda load DynamoDB | map(any) | No
| state_machine_config | State Machine configurations | map(any) | No
| lambda_archive_config | Configuration map for lambda that move s3 object to archive | map(any) | No

##### Output
---
| Name | Description |
| ------ | ------ |
| table_name | DynamoDB table name |
| bucket_name | S3 bucket name |

#### License
---
Apache 2 Licensed. See LICENSE for full details.
