variable "aws-region" {
  description = "Dfault AWS region"
  type        = string
  default     = "us-west-1"
}

variable "tags-descr" {
  description = "Dfault tags description."
  type        = map(string)
  default = {
    Terraform = "True"
    Project     = "LAMBDA"
  }
}

variable "lambda_runtime" {
  description = "Lambda default runtime."
  type        = string
  default     = "python3.8"
}

variable "lambda_file_name" {
  description = "Lambda file name. (Required)"
  type        = string
}

variable "lambda_handler" {
  description = "Lambda handler. (Required)"
  type        = string
}