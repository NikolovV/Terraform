# Attach triggers to lambda
locals {
  lambda_stfn_triggers = {
    for k, v in var.stfn_triggers :
    k => {
      service    = v["service"]
      source_arn = "${module.api_gateway.apigatewayv2_api_execution_arn}/*/${lookup(v, "method", "*/*")}"
    }
  }
}

module "lambda_invoke_stfn" {
  source  = "terraform-aws-modules/lambda/aws"
  version = ">= 2.34.0"

  function_name = var.lambda_invoke_stfn_config["function_name"]
  description   = var.lambda_invoke_stfn_config["description"]
  handler       = var.lambda_invoke_stfn_config["handler"]
  runtime       = var.lambda_invoke_stfn_config["runtime"]

  create_package         = var.lambda_invoke_stfn_config["create_package"]
  local_existing_package = var.lambda_invoke_stfn_config["local_existing_package"]

  create_current_version_allowed_triggers = var.lambda_invoke_stfn_config["create_current_version_allowed_triggers"]

  # The /*/*/* part allows invocation from any stage, method and resource path
  allowed_triggers = local.lambda_stfn_triggers

  attach_policy = var.lambda_invoke_stfn_config["attach_policy"]
  policy        = var.lambda_invoke_stfn_config["policy"]

  attach_policy_json = var.lambda_invoke_stfn_config["attach_policy_json"]
  policy_json        = file(var.lambda_invoke_stfn_config["policy_json"])

  attach_cloudwatch_logs_policy = var.lambda_invoke_stfn_config["attach_cloudwatch_logs_policy"]

  depends_on = [
    data.archive_file.lambda_invoke_stfn
  ]
}
