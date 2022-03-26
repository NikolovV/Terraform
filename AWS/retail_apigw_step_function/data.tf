data "archive_file" "lambda_stock" {
  type        = "zip"
  source_file = "src/${var.lambda_check_account_fname}.py"
  output_path = "src/${var.lambda_check_account_fname}.zip"
}

data "archive_file" "lambda_bank" {
  type        = "zip"
  source_file = "src/${var.lambda_check_stock_fname}.py"
  output_path = "src/${var.lambda_check_stock_fname}.zip"
}

data "archive_file" "lambda_invoke_stfn" {
  type        = "zip"
  source_file = "src/${var.lambda_invoke_stfn}.py"
  output_path = "src/${var.lambda_invoke_stfn}.zip"
}
