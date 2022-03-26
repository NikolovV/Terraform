variable "aws_region" {
  description = "Default AWS region"
  type        = string
  default     = "us-west-1"
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

variable "pub_sub_cidr_block" {
  description = "Default CIDR for public subnet"
  type        = string
  default     = "10.1.1.0/24"
}

variable "nic_ip" {
  description = "Default IP for nic"
  type        = string
  default     = "10.1.1.10"
}

variable "rt_cidr_block" {
  description = "Default CIDR for route table"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ec2_key_file" {
  description = "Path to public key file"
  type        = string
  default     = "mykey.pub"
}

variable "private_key" {
  description = "Path to private key file"
  type        = string
  default     = "mykey"
}

variable "instance_user" {
  description = "Path to private key file"
  type        = string
  default     = "ec2-user"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
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

variable "res_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    Terraform = "True"
    Project     = "EC2-S3"
  }
}

