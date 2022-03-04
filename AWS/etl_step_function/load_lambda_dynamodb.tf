module "lambda_load_dynamodb" {
  source  = "terraform-aws-modules/lambda/aws"
  version = ">= 2.34.0"

  function_name      = var.lambda_load_dynamodb_config["function_name"]
  description        = var.lambda_load_dynamodb_config["description"]
  handler            = var.lambda_load_dynamodb_config["handler"]
  runtime            = var.lambda_load_dynamodb_config["runtime"]
  policy             = var.lambda_load_dynamodb_config["policy"]
  attach_policy      = var.lambda_load_dynamodb_config["attach_policy"]
  policy_json        = file(var.lambda_load_dynamodb_config["policy_json"])
  attach_policy_json = var.lambda_load_dynamodb_config["attach_policy_json"]

  create_package                          = var.lambda_load_dynamodb_config["create_package"]
  local_existing_package                  = var.lambda_load_dynamodb_config["local_existing_package"]
  create_current_version_allowed_triggers = var.lambda_load_dynamodb_config["create_current_version_allowed_triggers"]

  attach_cloudwatch_logs_policy = var.lambda_load_dynamodb_config["attach_cloudwatch_logs_policy"]

  depends_on = [
    data.archive_file.lambda_load
  ]
}