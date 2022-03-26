# Variables
variable "aws_region" {
  description = "AWS region."
  type        = string
  default     = "us-west-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "whitelist" {
  description = "Allowed list of IP for access."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "vpc_cidr_block" {
  description = "Default CIDR"
  type        = string
  default     = "10.1.0.0/16"
}

variable "pub_subnet_cidr" {
  description = "Public subnet CIDR list"
  type        = list(string)
  default     = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "prv_subnet_cidr" {
  description = "Private subnet CIDR list"
  type        = list(string)
  default     = ["10.1.10.0/24", "10.1.20.0/24"]
}

variable "security_group_ingress" {
  description = "List of maps of ingress rules to set on the security group"
  type        = list(map(string))
  default = [
    {
      description = "HTTP ingress rule"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
    },
    {
      description = "HTTPS ingress rule"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
    },
    {
      description = "SSH ingress rule"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
    }
  ]
}