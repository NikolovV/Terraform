output "table_name_bank" {
  description = "DynamoDB table name"
  value       = module.bank.dynamodb_table_id
}

output "table_name_shop" {
  description = "DynamoDB table name"
  value       = module.shop.dynamodb_table_id
}

output "state_machine_name" {
  description = "State Machine name"
  value       = module.step_function.state_machine_arn
}

output "api_gw_endpoint" {
  description = "API gateway endpoint"
  value       = "${module.api_gateway.apigatewayv2_api_api_endpoint}/order"
}
