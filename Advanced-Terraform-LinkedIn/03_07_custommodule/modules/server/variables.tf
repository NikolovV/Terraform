variable "ami_id" {
  description = "The ID of the NodeJS AMI to deploy"
  default     = "ami-6685a403"
}

variable "instance_count" {
  type    = number
  default = 1
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

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "subnet_cidr" {
  default = "172.16.0.0/24"
}

variable "environment_tags" {
  type = map(string)
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