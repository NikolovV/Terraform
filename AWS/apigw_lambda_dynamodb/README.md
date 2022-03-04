## Simple CRUD (Create, read, update, delete) API.
---
HTTP REST API with API Gateway v2, Lambda, DynamoDB.</br>
Separate Lambda function for read and write request.

**Resources:**</br>
[Serverless Application](https://levelup.gitconnected.com/serverless-application-with-api-gateway-aws-lambda-and-dynamodb-using-terraform-79ecdedc6103)</br>
[AWS Documentation](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-dynamo-db.html)</br>
##### Used modules:
---
> [AWS API Gateway v2](https://registry.terraform.io/modules/terraform-aws-modules/apigateway-v2/aws/latest) - Terraform module to create an AWS API Gateway v2 (HTTP/WebSocket)</br>
> [AWS Lambda](https://registry.terraform.io/modules/terraform-aws-modules/lambda/aws/latest) - Terraform module, which takes  care of a lot of AWS Lambda/serverless tasks (build dependencies, packages, updates, deployments) in countless combinations</br>
> [AWS DynamoDB table](https://registry.terraform.io/modules/terraform-aws-modules/dynamodb-table/aws/latest) - Terraform module which creates DynamoDB table on AWS</br>

## Requirements
| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 3.27.0 |

## Providers
| Name | Version |
|------|---------|
| aws | >= 3.27.0 |

##### Varialbles
---
| Name | Description | Type | Required |
| ------ | ------ | ------ | ------ | 
| aws_region | AWS region | String | No |
| resource_tags | Tags to set for resources | map(string) | No |
| db_config | DynamoDB configurations - table name and key | map(string) | No |
| db_atributes | DynamoDB table attributes | list(map(string)) | No |
| lambda_read_file_name | Source file name of read lambda | string | No |
| lambda_write_file_name | Source file name of write lambda | string | No |
| read_triggers | Configuration for read lambda allowed_triggers | map(any) | No |
| write_triggers | Configuration for write lambda allowed_triggers | map(any) | No |
| lambda_config | Configuration parameters map for both read / write lambda | map(any) | No |
| api_gw_config | API Gateway configuration | map(string) | No |
| api_gw_integrations | API Gateway lambda integration map | map(any) | No |

#### Output
---
| Name | Description |
| ------ | ------ |
| apigw_endpoind | API Gateway endpoint URL |
| table_name | DynamoDB table name |

#### License
---
Apache 2 Licensed. See LICENSE for full details.
