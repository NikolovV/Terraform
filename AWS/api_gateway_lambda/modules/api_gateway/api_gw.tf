resource "aws_apigatewayv2_api" "lambda" {
  name          = var.api_gw_name
  protocol_type = var.api_gw_protocol
}

resource "aws_apigatewayv2_stage" "lambda" {
  api_id = aws_apigatewayv2_api.lambda.id

  name        = var.api_gw_stage_name
  auto_deploy = true

#   access_log_settings {
#     destination_arn = aws_cloudwatch_log_group.api_gw.arn

#     format = jsonencode({
#       requestId               = "$context.requestId"
#       sourceIp                = "$context.identity.sourceIp"
#       requestTime             = "$context.requestTime"
#       protocol                = "$context.protocol"
#       httpMethod              = "$context.httpMethod"
#       resourcePath            = "$context.resourcePath"
#       routeKey                = "$context.routeKey"
#       status                  = "$context.status"
#       responseLength          = "$context.responseLength"
#       integrationErrorMessage = "$context.integrationErrorMessage"
#       }
#     )
#   }
}

resource "aws_apigatewayv2_integration" "intergation" {
  api_id = aws_apigatewayv2_api.lambda.id

  integration_uri    = var.lambda_invoke_arn
  integration_type   = var.integration_type
  integration_method = var.integration_method
}

resource "aws_apigatewayv2_route" "route" {
  api_id = aws_apigatewayv2_api.lambda.id

  route_key = "GET /name"
  target    = "integrations/${aws_apigatewayv2_integration.intergation.id}"
}

# resource "aws_cloudwatch_log_group" "api_gw" {
#   name = "/aws/api_gw/${aws_apigatewayv2_api.lambda.name}"

#   retention_in_days = 30
# }

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.lambda.execution_arn}/*/*"
}
