variable "aws_region" {
  description = "AWS region."
  type        = string
  default     = "us-west-1"
}

variable "bucket_name" {
  description = "Bucket name"
  type        = string
  default     = "red30-tfstate-20220105"
}