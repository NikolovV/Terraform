variable "api_gw_name" {
  description = "API Gateway name"
  type        = string
}

variable "api_gw_stage_name" {
  description = "API Gateway stage name"
  type        = string
}

variable "api_gw_protocol" {
  description = "API Gateway protocol"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "Lambda invoke arn"
  type        = string
}

variable "lambda_function_name" {
  description = "Lambda invoke arn"
  type        = string
}

variable "integration_type" {
  description = "API GW integration type"
  type        = string
}

variable "integration_method" {
  description = "API GW integration method"
  type        = string
}

