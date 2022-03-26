variable "cidr-block" {
  description = "Default CIDR"
  type        = string
  default     = "10.1.0.0/16"
}

variable "aws-region" {
  description = "Default AWS region"
  type        = string
  default     = "us-west-1"
}

variable "alz" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-west-1a", "us-west-1b"]
}

