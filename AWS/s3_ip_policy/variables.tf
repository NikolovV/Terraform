variable "aws_region" {
  description = "Default AWS region"
  type        = string
  default     = "us-west-1"
}

variable "bucket_prefix" {
  description = "Prefix for bucket name."
  type        = string
  default     = "hashilearn-"
}
