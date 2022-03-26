## Simple Retail REST API.
---
**API Gateway, Lambda, Step Function, DynamoDB**</br>
**Resources:**</br>
>[AWS Step Functions workshop](https://step-functions-workshop.go-aws.com/) - Intro to service coordination using AWS Step Functions</br>
>[API Gateway trigger](https://docs.aws.amazon.com/step-functions/latest/dg/tutorial-api-gateway.html) - Creating a Step Functions API Using API Gateway</br>
>[Boto3 Docs](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/dynamodb.html#table) - A resource representing an Amazon DynamoDB Table</br>
>[Flatten paralell array output](https://stackoverflow.com/questions/54105792/parallel-states-merge-the-output-in-step-function) - Parallel States Merge the output in Step Function</br>
>[Step Functions SNS Example](https://docs.aws.amazon.com/step-functions/latest/dg/sample-project-codebuild.html) - Build an AWS CodeBuild Project (CodeBuild, Amazon SNS)</br>
>[Handling Error](https://docs.aws.amazon.com/step-functions/latest/dg/tutorial-handling-error-conditions.html) - Handling Error Conditions Using a Step Functions State Machine</br>

##### Terraform modules:
---
>[AWS API Gatewayv2](https://registry.terraform.io/modules/terraform-aws-modules/apigateway-v2/aws/latest) - AWS API Gateway v2 (HTTP/Websocket) Terraform module</br>
>[AWS Lambda](https://registry.terraform.io/modules/terraform-aws-modules/lambda/aws/latest) - Terraform module, which takes  care of a lot of AWS Lambda/serverless tasks (build dependencies, packages, updates, deployments) in countless combinations</br>
> [AWS DynamoDB table](https://registry.terraform.io/modules/terraform-aws-modules/dynamodb-table/aws/latest) - Terraform module which creates DynamoDB table on AWS</br>
> [Step Functions](https://registry.terraform.io/modules/terraform-aws-modules/step-functions/aws/latest?tab=inputs) - Terraform module which creates Step Functions on AWS</br>
> [SNS Topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) - Provides an SNS topic resource</br>
> [SNS Topic subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) - subscription</br>

## Features
---
- POST request with order at API Gateway endpoint call Lambda which trigger the State Machine workflow.
- Parallel state check for account and stock availability.

## Step to provision
---
1. Set SNS email recipient in variable sns_subscr_config.email_endpoint.
2. Deploy resource with terraform.
3. Put the state machine arn in lambda_invoke_stfn.py
4. Open email and confirm subscription.
5. Load test data in test folder.
6. Make tests.

## Requirements
| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0.0 |
| apigateway-v2 | >= 1.5.1 |
| lambda | >= 2.34.0 |
| dynamodb-table | >= 1.2.2 |

## Providers
| Name | Version |
|------|---------|
| aws | >= 4.0.0 |

##### Variables
---
| Name | Description | Type | Required |
| ------ | ------ | ------ | ------ | 
| aws_region | AWS region | String | No |
| resource_tags | Tags to set for resources | map(string) | No |
| api_gw_config | API Gateway configuration | map(string) | No |
| api_gw_integrations | API Gateway lambda functions integration map | map(any) | No |
| state_machine_config | State Machine configurations | map(any) | No |
| db_bank_config | DynamoDB configurations | map(string) | No |
| db_bank_atributes | DynamoDB attributes | list(map(string)) | No |
| db_shop_config | DynamoDB configurations | map(string) | No |
| db_shop_atributes | DynamoDB attributes | list(map(string)) | No |
| lambda_check_account_fname | Source file name of lambda check account availability | string | No |
| lambda_check_account_config | Configuration map for lambda check account availability | map(any) | No |
| lambda_check_stock_fname | Source file name of lambda check stock availability | string | No |
| lambda_check_stock_config | Configuration map for lambda check stock availability | map(any) | No | 
| lambda_invoke_stfn | Source file name of lambda that invoke Step Function. | string | No |
| stfn_triggers | Configuration for API Gateway lambda allowed_triggers | map(any) | No |
| lambda_invoke_stfn_config | Configuration map for lambda trigger Step Function | map(any) | No |

##### Output
---
| Name | Description |
| ------ | ------ |
| table_name_bank | DynamoDB table name |
| table_name_shop | DynamoDB table name |
| state_machine_name | State Machine name |
| api_gw_endpoint | API gateway endpoint |

#### License
---
Apache 2 Licensed. See LICENSE for full details.
