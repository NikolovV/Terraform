data "archive_file" "filie_zip" {
  type        = "zip"
  source_file = "src/${var.lambda_s3_file_name}.py"
  output_path = "src/${var.lambda_s3_file_name}.zip"
}
