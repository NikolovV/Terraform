# Define API routes and integration
locals {
  integration = {
    for k, v in var.api_gw_integrations :
    k => {
      lambda_arn             = split(" ", k)[0] == "GET" ? module.lambda_read.lambda_function_arn : module.lambda_write.lambda_function_arn
      payload_format_version = lookup(v, "payload_format_version", "2.0")
      integration_method     = lookup(v, "integration_method", "POST")
    }
  }
}

module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = ">= 1.5.1"

  name                   = var.api_gw_config["name"]
  protocol_type          = var.api_gw_config["protocol_type"]
  create_api_domain_name = var.api_gw_config["create_api_domain_name"]
  integrations           = local.integration

  tags = var.resource_tags
}
