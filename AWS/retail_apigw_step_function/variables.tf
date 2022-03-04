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
    Project   = "retail-step-func"
  }
}

variable "api_gw_config" {
  description = "API Gateway configuration"
  type        = map(string)
  default = {
    name                   = "lambda-execution"
    protocol_type          = "HTTP"
    create_api_domain_name = false
  }
}

variable "api_gw_integrations" {
  description = "API Gateway lambda functions integration map"
  type        = map(any)
  default = {
    "POST /order" = {
      payload_format_version = "2.0"
      integration_method     = "POST"
    }
  }
}

variable "state_machine_config" {
  description = "State Machine configurations"
  type        = map(any)
  default = {
    name                          = "check-availability"
    type                          = "STANDARD"
    attach_cloudwatch_logs_policy = false
    policy                        = "arn:aws:iam::aws:policy/service-role/AWSLambdaRole"
    attach_policy                 = true
  }
}

variable "db_bank_config" {
  description = "DynamoDB configurations"
  type        = map(string)
  default = {
    name     = "bank-service"
    hash_key = "customer_id"
  }
}

variable "db_bank_atributes" {
  description = "DynamoDB attributes"
  type        = list(map(string))
  default = [{
    name = "customer_id"
    type = "S"
    }
  ]
}

variable "db_shop_config" {
  description = "DynamoDB configurations"
  type        = map(string)
  default = {
    name     = "shop-service"
    hash_key = "item_id"
  }
}

variable "db_shop_atributes" {
  description = "DynamoDB attributes"
  type        = list(map(string))
  default = [{
    name = "item_id"
    type = "S"
    }
  ]
}

variable "lambda_check_account_fname" {
  description = "Source file name of lambda check account availability"
  type        = string
  default     = "check_account_availability"
}

variable "lambda_check_account_config" {
  description = "Configuration map for lambda check account availability"
  type        = map(any)
  default = {
    function_name          = "check-account-availability"
    description            = "Lambda function that check customer account availability. Called in parallel by State Machine"
    handler                = "check_account_availability.check_availability_handler"
    runtime                = "python3.8"
    create_package         = false
    local_existing_package = "src/check_account_availability.zip"
    attach_policy          = true
    policy                 = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    attach_policy_json     = true
    policy_json            = "./policy/dynamodb_read_policy.json"

    attach_cloudwatch_logs_policy           = false
    create_current_version_allowed_triggers = false
  }
}

variable "lambda_check_stock_fname" {
  description = "Source file name of lambda check stock availability"
  type        = string
  default     = "check_stock_availability"
}

variable "lambda_check_stock_config" {
  description = "Configuration map for lambda check stock availability"
  type        = map(any)
  default = {
    function_name          = "check-stock-availability"
    description            = "Lambda function that check shop stock availability. Called in parallel by State Machine"
    handler                = "check_stock_availability.check_stock_handler"
    runtime                = "python3.8"
    create_package         = false
    local_existing_package = "src/check_stock_availability.zip"
    attach_policy          = true
    policy                 = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    attach_policy_json     = true
    policy_json            = "./policy/dynamodb_read_policy.json"

    attach_cloudwatch_logs_policy           = false
    create_current_version_allowed_triggers = false
  }
}

variable "lambda_invoke_stfn" {
  description = "Source file name of lambda that invoke Step Functions."
  type        = string
  default     = "lambda_invoke_stfn"
}

variable "stfn_triggers" {
  description = "Configuration for API Gateway lambda allowed_triggers"
  type        = map(any)
  default = {
    APIGatewayPostOrder = {
      service = "apigateway"
      method  = "POST/order"
    }
  }
}

variable "lambda_invoke_stfn_config" {
  description = "Configuration map for lambda trigger Step Functions"
  type        = map(any)
  default = {
    function_name          = "api-gw-lambda-stfn"
    description            = "Lambda function triggered from API Gateway and call Step Functions"
    handler                = "lambda_invoke_stfn.lambda_invoke_stfn_handler"
    runtime                = "python3.8"
    create_package         = false
    local_existing_package = "src/lambda_invoke_stfn.zip"
    attach_policy          = true
    policy                 = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    attach_policy_json     = true
    policy_json            = "./policy/step_fn_policy.json"

    attach_cloudwatch_logs_policy           = false
    create_current_version_allowed_triggers = false
  }
}
