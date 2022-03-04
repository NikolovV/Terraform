# Attach triggers to lambda
locals {
  lambda_s3_create_obj_triggers = {
    for k, v in var.s3_triggers :
    k => {
      action        = v["action"]
      function_name = module.lambda_s3_stfn.lambda_function_name
      principal     = v["principal"]
      source_arn    = "arn:aws:s3:::${aws_s3_bucket.bucket.id}"
    }
  }
}

module "lambda_s3_stfn" {
  source  = "terraform-aws-modules/lambda/aws"
  version = ">= 2.34.0"

  function_name       = var.lambda_s3_stfn_config["function_name"]
  description         = var.lambda_s3_stfn_config["description"]
  handler             = var.lambda_s3_stfn_config["handler"]
  runtime             = var.lambda_s3_stfn_config["runtime"]
  policy              = var.lambda_s3_stfn_config["policy"]
  attach_policy       = var.lambda_s3_stfn_config["attach_policy"]
  policy_jsons        = [file(var.lambda_s3_stfn_config["policy_jsons_s3"]), file(var.lambda_s3_stfn_config["policy_jsons_stfn"])]
  attach_policy_jsons = var.lambda_s3_stfn_config["attach_policy_jsons"]

  number_of_policy_jsons                  = var.lambda_s3_stfn_config["number_of_policy_jsons"]
  create_package                          = var.lambda_s3_stfn_config["create_package"]
  local_existing_package                  = var.lambda_s3_stfn_config["local_existing_package"]
  create_current_version_allowed_triggers = var.lambda_s3_stfn_config["create_current_version_allowed_triggers"]

  allowed_triggers = local.lambda_s3_create_obj_triggers

  attach_cloudwatch_logs_policy = var.lambda_s3_stfn_config["attach_cloudwatch_logs_policy"]

  depends_on = [
    data.archive_file.lambda_s3
  ]
}