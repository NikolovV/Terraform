variable "aws_region" {
  description = "Default AWS region"
  type        = string
  default     = "us-west-1"
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    Terraform = "True"
    Project   = "CRUD-API"
  }
}

variable "db_config" {
  description = "Dynamodb configurations"
  type        = map(string)
  default = {
    name     = "customer_info"
    hash_key = "customer_id"
  }
}

variable "db_atributes" {
  description = "Dynamodb attributes"
  type        = list(map(string))
  default = [{
    name = "customer_id"
    type = "S"
    }
  ]
}

variable "lambda_read_file_name" {
  description = "Source file name of read lambda"
  type        = string
  default     = "src/read_lambda"
}

variable "lambda_write_file_name" {
  description = "Source file name of write lambda"
  type        = string
  default     = "src/write_lambda"
}

variable "read_triggers" {
  description = "Configuration for read lambda allowed_triggers"
  type        = map(any)
  default = {
    APIGatewayGetCustomer = {
      service = "apigateway"
      method  = "GET/customer/{customer_id}"
    }
  }
}

variable "write_triggers" {
  description = "Configuration for write lambda allowed_triggers"
  type        = map(any)
  default = {
    APIGatewayPostCustomer = {
      service = "apigateway"
      method  = "POST/customer"
    },
    APIGatewayDeleteCustomer = {
      service = "apigateway"
      method  = "DELETE/customer"
    },
    APIGatewayPutCustomer = {
      service    = "apigateway"
      method = "PUT/customer"
    }
  }
}

variable "lambda_config" {
  description = "Configuration map for both read / write lambda"
  type        = map(any)
  default = {
    read = {
      function_name                           = "lambda-read"
      description                             = "Lambda function that fetch data from Dynamodb"
      handler                                 = "read_lambda.read_lambda_handler"
      runtime                                 = "python3.8"
      create_package                          = false
      local_existing_package                  = "src/read_lambda.zip"
      create_current_version_allowed_triggers = false
      attach_policy                           = true
      policy                                  = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
      attach_policy_json                      = true
      policy_json                             = "./policy/read_policy.json"
      attach_cloudwatch_logs_policy           = false
    },
    write = {
      function_name                           = "lambda-write"
      description                             = "Lambda function that write data from Dynamodb"
      handler                                 = "write_lambda.write_lambda_handler"
      runtime                                 = "python3.8"
      create_package                          = false
      local_existing_package                  = "src/write_lambda.zip"
      create_current_version_allowed_triggers = false
      attach_policy                           = true
      policy                                  = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
      attach_policy_json                      = true
      policy_json                             = "./policy/write_policy.json"
      attach_cloudwatch_logs_policy           = false
    }
  }
}

variable "api_gw_config" {
  description = "API Gateway configuration"
  type        = map(string)
  default = {
    name                   = "customer_apigw-http"
    protocol_type          = "HTTP"
    create_api_domain_name = false
  }
}

variable "api_gw_integrations" {
  description = "API Gateway lambda integration map"
  type        = map(any)
  default = {
    "GET /customer/{customer_id}" = {
      payload_format_version = "2.0"
      integration_method     = "GET"
    },

    "POST /customer" = {
      payload_format_version = "2.0"
      integration_method     = "POST"
    },

    "PUT /customer" = {
      payload_format_version = "2.0"
      integration_method     = "PUT"
    },

    "DELETE /customer" = {
      payload_format_version = "2.0"
      integration_method     = "DELETE"
    }
  }
}