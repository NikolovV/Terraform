output "apigw_endpoind" {
  description = "API Gateway endpoint URL"
  value       = module.api_gateway.apigatewayv2_api_api_endpoint
}

output "table_name" {
  description = "DynamoDB table name"
  value       = module.dynamodb_table.dynamodb_table_id
}

