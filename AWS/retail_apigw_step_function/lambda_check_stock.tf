module "lambda_check_stock" {
  source  = "terraform-aws-modules/lambda/aws"
  version = ">= 2.34.0"

  function_name      = var.lambda_check_stock_config["function_name"]
  description        = var.lambda_check_stock_config["description"]
  handler            = var.lambda_check_stock_config["handler"]
  runtime            = var.lambda_check_stock_config["runtime"]
  policy             = var.lambda_check_stock_config["policy"]
  attach_policy      = var.lambda_check_stock_config["attach_policy"]
  policy_json        = file(var.lambda_check_stock_config["policy_json"])
  attach_policy_json = var.lambda_check_stock_config["attach_policy_json"]

  create_package                          = var.lambda_check_stock_config["create_package"]
  local_existing_package                  = var.lambda_check_stock_config["local_existing_package"]
  create_current_version_allowed_triggers = var.lambda_check_stock_config["create_current_version_allowed_triggers"]

  attach_cloudwatch_logs_policy = var.lambda_check_stock_config["attach_cloudwatch_logs_policy"]

  environment_variables = {
    TABLE_NAME = var.db_shop_config.name
  }

  depends_on = [
    data.archive_file.lambda_stock
  ]
}