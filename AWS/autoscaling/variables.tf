variable "whitelist" {
  description = "Allowed list of IP for access."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "web_image_id" {
  description = "AWS AMI image."
  type        = string
  default     = "ami-03af6a70ccd8cb578" // Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
}

variable "web_instance_type" {
  description = "Type of instance."
  type        = string
  default     = "t2.micro"
}

variable "res_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    Terraform = "True"
    Project     = "Autoscaling-EC2"
  }
}

variable "web_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  type        = number
  default     = 2
}
variable "web_max_size" {
  description = "The maximum size of the Auto Scaling Group"
  type        = number
  default     = 4
}

variable "web_min_size" {
  description = "The minimum size of the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "cidr_block" {
  description = "CIDR for VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "avlz" {
  description = "Availability zone names"
  type        = list(string)
  default     = ["us-west-1a", "us-west-1b"]
}

variable "publ_sub_cidr" {
  description = "List of CIDR for subnets"
  type        = list(string)
  default     = ["10.1.101.0/24", "10.1.102.0/24"]
}

variable "aws_project_name" {
  description = "Project name"
  type        = string
  default     = "Autoscaling-EC2"
}

variable "aws_region" {
  description = "AWS region."
  type        = string
  default     = "us-west-1"
}

variable "security_group_ingress" {
  description = "List of maps of ingress rules to set on the default security group"
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
    }
  ]
}