variable "aws_region" {
  description = "AWS region."
  type        = string
  default     = "us-west-1"
}

variable "vpc_cidr" {
  type    = string
  default = "172.16.0.0/16"
}

variable "subnet1_cidr" {
  type    = string
  default = "172.16.0.0/24"
}

variable "whitelist" {
  description = "Allowed list of IP for access."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "instance_type" {
  description = "Type of instance."
  type        = string
  default     = "t2.micro"
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