module "lambda" {
  source           = "./modules/lambda"
  lambda_file_name = var.lambda_file_name
  lambda_handler   = var.lambda_handler
  lambda_runtime   = var.lambda_runtime
}

module "api_gw" {
  source               = "./modules/api_gateway"
  api_gw_name          = var.api_gw_name
  api_gw_protocol      = var.api_gw_protocol
  api_gw_stage_name    = var.api_gw_stage_name
  lambda_invoke_arn    = module.lambda.lambda_invoke_arn
  lambda_function_name = module.lambda.lambda_func_name
  integration_type     = var.integration_type
  integration_method   = var.integration_method
}