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
    Project   = "s3-step-func"
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
  default     = "s3_lambda_stfn"
}

variable "lambda_load" {
  description = "Source file name of lambda load"
  type        = string
  default     = "lambda_load_ddb"
}

variable "lambda_archive" {
  description = "Source file name of lambda archvie"
  type        = string
  default     = "lambda_archive"
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

variable "lambda_s3_stfn_config" {
  description = "Configuration map for both lambda s3"
  type        = map(any)
  default = {
    function_name          = "s3-lambda-stfn"
    description            = "Lambda function triggered from s3 createobject call start step function"
    handler                = "s3_lambda_stfn.s3_lambda_stfn_handler"
    runtime                = "python3.8"
    create_package         = false
    local_existing_package = "src/s3_lambda_stfn.zip"
    attach_policy          = true
    policy                 = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    attach_policy_jsons    = true
    policy_jsons_s3        = "./policy/s3_read_policy.json"
    policy_jsons_stfn      = "./policy/step_fn_policy.json"
    number_of_policy_jsons = 2

    attach_cloudwatch_logs_policy           = false
    create_current_version_allowed_triggers = false
  }
}

variable "lambda_load_dynamodb_config" {
  description = "Configuration map for lambda load DynamoDB"
  type        = map(any)
  default = {
    function_name          = "lambda-load-dynamodb"
    description            = "Lambda function load data in DynamoDB. Called by State Machine"
    handler                = "lambda_load_ddb.lambda_load_handler"
    runtime                = "python3.8"
    create_package         = false
    local_existing_package = "src/lambda_load_ddb.zip"
    attach_policy          = true
    policy                 = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    attach_policy_json     = true
    policy_json            = "./policy/dynamodb_load_policy.json"

    attach_cloudwatch_logs_policy           = false
    create_current_version_allowed_triggers = false
  }
}

variable "state_machine_config" {
  description = "State Machine configurations"
  type        = map(any)
  default = {
    name                          = "step-function-etl"
    type                          = "STANDARD"
    attach_cloudwatch_logs_policy = false
    policy                        = "arn:aws:iam::aws:policy/service-role/AWSLambdaRole"
    attach_policy                 = true
  }
}


variable "lambda_archive_config" {
  description = "Configuration map for lambda that move s3 object to archive"
  type        = map(any)
  default = {
    function_name          = "lambda-archive"
    description            = "Lambda function that move s3 loaded object to archive. Called by State Machine"
    handler                = "lambda_archive.lambda_archive_handler"
    runtime                = "python3.8"
    create_package         = false
    local_existing_package = "src/lambda_archive.zip"
    attach_policy          = true
    policy                 = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    attach_policy_json     = true
    policy_json            = "./policy/lambda.archive.json"

    attach_cloudwatch_logs_policy           = false
    create_current_version_allowed_triggers = false
  }
}