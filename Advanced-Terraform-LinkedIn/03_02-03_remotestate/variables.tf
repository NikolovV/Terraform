variable "aws_region" {
  description = "AWS region."
  type        = string
  default     = "us-west-1"
}

variable "vpc_cidr" {
  description = "VPC CIRD"
  type        = string
  default     = "172.16.0.0/16"
}

variable "pub_subnet_cidr" {
  description = "Public subnet CIDR list"
  type        = list(string)
  default     = ["172.16.1.0/24", "172.16.2.0/24"]
}

variable "prv_subnet_cidr" {
  description = "Private subnet CIDR list"
  type        = list(string)
  default     = ["172.16.10.0/24", "172.16.20.0/24"]
}

