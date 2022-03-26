variable "vpc_name" {
  description = "Default VPC name"
  type        = string
}

variable "vpc_cidr" {
  description = "Default VPC CIDR"
  type        = string
}

variable "public_subnets" {
  description = "Default public subnets"
  type        = list(string)
}

variable "security_group_name" {
  description = "Default security group name"
  type        = string
}

variable "whitelist" {
  description = "Allowed list of IP for access."
  type        = list(string)
}

variable "sg_ingress" {
  description = "Default security group ingress"
  type        = map(string)
}

variable "sg_egress" {
  description = "Default security group egress"
  type        = map(string)
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    Terraform = "True"
    Project   = "RDS"
  }
}