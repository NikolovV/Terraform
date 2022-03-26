variable "aws_region" {
  description = "AWS region."
  type        = string
  default     = "us-west-1"
}

variable "iam_user_name" {
  description = "IAM user name"
  type        = string
  default     = "sample-user"
}

variable "iam_group_name" {
  description = "IAM group name"
  type        = string
  default     = "ec2-container-registry"
}

variable "iam_policy_arn" {
  description = "IAM policy arn"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}
