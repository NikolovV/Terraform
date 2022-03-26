# Attach triggers to lambda
locals {
  lambda_s3_create_obj_triggers = {
    for k, v in var.s3_triggers :
    k => {
      action        = v["action"]
      function_name = module.lambda_s3.lambda_function_name
      principal     = v["principal"]
      source_arn    = "arn:aws:s3:::${aws_s3_bucket.bucket.id}"
    }
  }
}

module "lambda_s3" {
  source  = "terraform-aws-modules/lambda/aws"
  version = ">= 2.34.0"

  function_name      = var.lambda_config["function_name"]
  description        = var.lambda_config["description"]
  handler            = var.lambda_config["handler"]
  runtime            = var.lambda_config["runtime"]
  policy             = var.lambda_config["policy"]
  attach_policy      = var.lambda_config["attach_policy"]
  policy_json        = file(var.lambda_config["policy_json"])
  attach_policy_json = var.lambda_config["attach_policy_json"]

  create_package                          = var.lambda_config["create_package"]
  local_existing_package                  = var.lambda_config["local_existing_package"]
  create_current_version_allowed_triggers = var.lambda_config["create_current_version_allowed_triggers"]

  allowed_triggers = local.lambda_s3_create_obj_triggers

  attach_cloudwatch_logs_policy = var.lambda_config["attach_cloudwatch_logs_policy"]

  environment_variables = {
    TABLE_NAME = "customer_info"
  }

  depends_on = [
    data.archive_file.filie_zip
  ]
}