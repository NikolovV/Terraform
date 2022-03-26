variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    Terraform = "True"
  }
}

variable "lambda_file_name" {
  description = "Lambda file name. (Required)"
  type        = string
}

variable "lambda_handler" {
  description = "Lambda handler. (Required)"
  type        = string
}

variable "lambda_runtime" {
  description = "Lambda default runtime."
  type        = string
}
