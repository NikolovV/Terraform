variable "aws_region" {
  description = "Default AWS region"
  type        = string
  default     = "us-east-2"
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    Terraform = "True"
    Project   = "s3-lambda-ddb"
  }
}

variable "bucket_config" {
  description = "Default S3 bucket configuration"
  type        = map(string)
  default = {
    bucket        = "s3-to-lambda-dynamodb-customer-info"
    acl           = "private"
    force_destroy = true
  }
}

variable "s3_notofication_events" {
  description = "Default S3 notification events list"
  type        = list(string)
  default = [
    "s3:ObjectCreated:*"
  ]
}

variable "s3_notofication_filter_prefix" {
  description = "Default S3 bucket folder for notification."
  type        = string
  default     = "daily/"
}

variable "db_config" {
  description = "DynamoDB configurations"
  type        = map(string)
  default = {
    name     = "customer_info"
    hash_key = "customer_id"
  }
}

variable "db_atributes" {
  description = "DynamoDB attributes"
  type        = list(map(string))
  default = [{
    name = "customer_id"
    type = "S"
    }
  ]
}

variable "lambda_s3_file_name" {
  description = "Source file name of lambda"
  type        = string
  default     = "lambda_s3"
}

variable "s3_triggers" {
  description = "Configuration for s3 lambda allowed_triggers"
  type        = map(any)
  default = {
    AllowS3Invoke = {
      action    = "lambda:InvokeFunction"
      principal = "s3.amazonaws.com"
    }
  }
}

variable "lambda_config" {
  description = "Configuration map for both lambda s3"
  type        = map(any)
  default = {
    function_name          = "s3-lambda-dynamodb"
    description            = "Lambda function triggered from s3 createObject and put data in DynamoDB"
    handler                = "lambda_s3.lambda_s3_handler"
    runtime                = "python3.8"
    create_package         = false
    local_existing_package = "src/lambda_s3.zip"
    attach_policy          = true
    policy                 = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    attach_policy_json     = true
    policy_json            = "./policy/write_policy.json"

    attach_cloudwatch_logs_policy           = false
    create_current_version_allowed_triggers = false
  }
}