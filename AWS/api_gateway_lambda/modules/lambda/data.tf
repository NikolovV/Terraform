data "archive_file" "filie-zip" {
  type        = "zip"
  source_file = "${var.lambda_file_name}.py"
  output_path = "${var.lambda_file_name}.zip"
}