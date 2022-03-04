variable "aws_region" {
  description = "Default AWS region"
  type        = string
  default     = "us-west-1"
}

variable "res_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    Terraform = "True"
    Project     = "EKS"
  }
}

# VPC
#---------------------------
variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "vpc-eks"
}

variable "vpc_cidr_block" {
  description = "CIDR for VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "pub_sub_cidr_block" {
  description = "Default CIDR for public subnet"
  type        = list(string)
  default     = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "prv_sub_cidr_block" {
  description = "Default CIDR for private subnet"
  type        = list(string)
  default     = ["10.1.10.0/24", "10.1.20.0/24"]
}

# EKS
#---------------------------
variable "eks_name" {
  description = "EKS name"
  type        = string
  default     = "eks-sample"
}

variable "eks_node_group_name" {
  description = "EKS node group name"
  type        = string
  default     = "eks-node-group"
}

variable "eks_scaling_config" {
  description = "EKS node scalling config block"
  type        = map(any)
  default = {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }
}

variable "eks_update_config" {
  description = "EKS node update config block"
  type        = map(any)
  default = {
    max_unavailable = 2
  }
}


