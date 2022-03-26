# Attach triggers to lambda
locals {
  lambda_read_triggers = {
    for k, v in var.read_triggers :
    k => {
      service    = lookup(v, "service", "apigateway")
      source_arn = "${module.api_gateway.apigatewayv2_api_execution_arn}/*/${lookup(v, "method", "*/*")}"
    }
  }
  lambda_write_triggers = {
    for k, v in var.write_triggers :
    k => {
      service    = lookup(v, "service", "apigateway")
      source_arn = "${module.api_gateway.apigatewayv2_api_execution_arn}/*/${lookup(v, "method", "*/*")}"
    }
  }
}

module "lambda_read" {
  source  = "terraform-aws-modules/lambda/aws"
  version = ">= 2.34.0"

  function_name = var.lambda_config.read["function_name"]
  description   = var.lambda_config.read["description"]
  handler       = var.lambda_config.read["handler"]
  runtime       = var.lambda_config.read["runtime"]

  create_package         = var.lambda_config.read["create_package"]
  local_existing_package = var.lambda_config.read["local_existing_package"]

  create_current_version_allowed_triggers = var.lambda_config.read["create_current_version_allowed_triggers"]

  # The /*/*/* part allows invocation from any stage, method and resource path
  allowed_triggers = local.lambda_read_triggers

  attach_policy = var.lambda_config.read["attach_policy"]
  policy        = var.lambda_config.read["policy"]

  attach_policy_json = var.lambda_config.read["attach_policy_json"]
  policy_json        = file(var.lambda_config.read["policy_json"])

  attach_cloudwatch_logs_policy = var.lambda_config.read["attach_cloudwatch_logs_policy"]
  depends_on = [
    data.archive_file.read_filie_zip
  ]
}

module "lambda_write" {
  source  = "terraform-aws-modules/lambda/aws"
  version = ">= 2.34.0"

  function_name = var.lambda_config.write["function_name"]
  description   = var.lambda_config.write["description"]
  handler       = var.lambda_config.write["handler"]
  runtime       = var.lambda_config.write["runtime"]

  create_package         = var.lambda_config.write["create_package"]
  local_existing_package = var.lambda_config.write["local_existing_package"]

  create_current_version_allowed_triggers = var.lambda_config.write["create_current_version_allowed_triggers"]

  # The /*/*/* part allows invocation from any stage, method and resource path
  allowed_triggers = local.lambda_write_triggers

  attach_policy = var.lambda_config.write["attach_policy"]
  policy        = var.lambda_config.write["policy"]

  attach_policy_json = var.lambda_config.write["attach_policy_json"]
  policy_json        = file(var.lambda_config.write["policy_json"])

  attach_cloudwatch_logs_policy = var.lambda_config.write["attach_cloudwatch_logs_policy"]
  depends_on = [
    data.archive_file.write_filie_zip
  ]
}
