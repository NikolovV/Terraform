output "lambda_invoke_arn" {
  description = "Lambda invoke arn"
  value       = aws_lambda_function.lambda.invoke_arn
}

output "lambda_func_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.lambda.function_name
}
