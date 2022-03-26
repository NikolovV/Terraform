data "archive_file" "lambda_s3" {
  type        = "zip"
  source_file = "src/${var.lambda_s3_file_name}.py"
  output_path = "src/${var.lambda_s3_file_name}.zip"
}

data "archive_file" "lambda_load" {
  type        = "zip"
  source_file = "src/${var.lambda_load}.py"
  output_path = "src/${var.lambda_load}.zip"
}

data "archive_file" "lambda_archive" {
  type        = "zip"
  source_file = "src/${var.lambda_archive}.py"
  output_path = "src/${var.lambda_archive}.zip"
}