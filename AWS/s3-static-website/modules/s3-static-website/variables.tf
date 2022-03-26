variable "bucket_name" {
  description = "Name of the s3 bucket. Must be unique."
  type        = string
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
}

