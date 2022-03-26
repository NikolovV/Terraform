variable "aws_region" {
  description = "Default AWS region"
  type        = string
  default     = "us-west-1"
}

variable "res_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    Project = "API Gateway Lambda"
  }
}

variable "lambda_file_name" {
  description = "Lambda file name. (Required)"
  type        = string
  default     = "aws_lambda"
}

variable "lambda_handler" {
  description = "Lambda handler. (Required)"
  type        = string
  default     = "apigw_lambda_handler"
}

variable "lambda_runtime" {
  description = "Lambda default runtime."
  type        = string
  default     = "python3.8"
}

### API Gateway
variable "api_gw_name" {
  description = "API Gateway name"
  type        = string
  default     = "api-gw-lambda"
}

variable "api_gw_protocol" {
  description = "API Gateway protocol"
  type        = string
  default     = "HTTP"
}

variable "api_gw_stage_name" {
  description = "API Gateway stage name"
  type        = string
  default     = "serverless_lambda_stage"
}

variable "integration_type" {
  description = "API GW integration type"
  type        = string
  default     = "AWS_PROXY"
}

variable "integration_method" {
  description = "API GW integration method"
  type        = string
  default     = "POST"
}
