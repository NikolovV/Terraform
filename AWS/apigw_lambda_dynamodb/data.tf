data "archive_file" "read_filie_zip" {
  type        = "zip"
  source_file = "${var.lambda_read_file_name}.py"
  output_path = "${var.lambda_read_file_name}.zip"
}

data "archive_file" "write_filie_zip" {
  type        = "zip"
  source_file = "${var.lambda_write_file_name}.py"
  output_path = "${var.lambda_write_file_name}.zip"
}
