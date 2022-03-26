output "lambda_invoke_arn" {
  description = "Lambda invoke arn"
  value       = module.lambda.lambda_invoke_arn
}

output "base_url" {
  description = "API GW URL"
  value       = module.api_gw.base_url
}

output "function_name" {
  description = "Lambda function name"
  value       = module.lambda.lambda_func_name
}