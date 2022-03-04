output "lambda_invoke_arn" {
  description = "Lambda invoke arn"
  value       = aws_lambda_function.lambda.invoke_arn
}
