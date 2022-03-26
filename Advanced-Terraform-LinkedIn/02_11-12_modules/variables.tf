variable "aws_region" {
  description = "AWS region."
  type        = string
  default     = "us-west-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "avlz" {
  description = "List of avalaibility zones"
  type        = list(string)
  default     = ["us-west-1a", "us-west-1b"]
}

variable "public_subnet_cidr" {
  description = "List of public subnet CIDR"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}
variable "private_subnet_cidr" {
  description = "List of private subnet CIDR"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "whitelist" {
  description = "Allowed list of IP for access."
  type        = list(string)
  default     = ["0.0.0.0/0"]
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

variable "environment_instance_settings" {
  type = map(object({ instance_type = string, monitoring = bool }))
  default = {
    "DEV" = {
      instance_type = "t2.nano",
      monitoring    = false
    },
    "QA" = {
      instance_type = "t2.micro",
      monitoring    = false
    },
    "STAGE" = {
      instance_type = "t2.micro",
      monitoring    = false
    },
    "PROD" = {
      instance_type = "t2.micro",
      monitoring    = true
    }
  }
}