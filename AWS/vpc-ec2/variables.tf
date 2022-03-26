variable "vpc-cidr-block" {
  description = "Default CIDR"
  type        = string
  default     = "10.1.0.0/16"
}
variable "pub-sub-cidr-block" {
  description = "Default CIDR for public subnet"
  type        = string
  default     = "10.1.1.0/24"
}

variable "nic-ip" {
  description = "Default IP for nic"
  type        = string
  default     = "10.1.1.10"
}

variable "rt-cidr-block" {
  description = "Default CIDR for route table"
  type        = string
  default     = "0.0.0.0/0"
}

variable "aws-region" {
  description = "Dfault AWS region"
  type        = string
  default     = "us-west-1"
}

variable "alz" {
  description = "List of availability zones"
  type        = string
  default     = "us-west-1a"
}

variable "ec2-ami" {
  description = "EC2 ami"
  type        = string
  default     = "ami-03af6a70ccd8cb578" // Amazon Linux 2 AMI (HVM) - Kernel 5.10
}

variable "ec2-instance-type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "tags-descr" {
  type = map(string)
  default = {
    Terraform = "True"
    Project     = "EC2-VPC"
  }
}