variable "aws_region" {
  description = "Default AWS region"
  type        = string
  default     = "us-west-1"
}

variable "bucket_name" {
  description = "Default S3 bucket name"
  type        = string
  default     = "s3-bucket-sample-website"
}

variable "res_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    Terraform = "True"
    Project   = "S3-Website"
  }
}

