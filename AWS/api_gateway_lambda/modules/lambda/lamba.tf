resource "aws_lambda_function" "lambda" {
  filename      = "${var.lambda_file_name}.zip"
  function_name = "${lower(terraform.workspace)}-${replace(var.lambda_file_name, "_", "-")}"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "${var.lambda_file_name}.${var.lambda_handler}"

  # source_code_hash = "data.archive_file.filie-zip.filebase64sha256"
  source_code_hash = filebase64sha256("${var.lambda_file_name}.zip")

  runtime = var.lambda_runtime

  tags = merge({ Name = "${lower(terraform.workspace)}_lambda" }, var.resource_tags)
}

# resource "aws_cloudwatch_log_group" "hello_world" {
#   name = "/aws/lambda/${aws_lambda_function.hello_world.function_name}"

#   retention_in_days = 30
# }