variable "aws-region" {
  description = "Dfault AWS region"
  type        = string
  default     = "us-west-1"
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
}

variable "cidr-block" {
  description = "Default CIDR"
  type        = string
  default     = "10.1.0.0/16"
}

variable "avlz" {
  description = "List of availability zones"
  type        = list(string)
  //default     = ["us-west-1a", "us-west-1b"]
}

variable "publ_sub_cidr" {
  description = "List of public subnet cidr"
  type        = list(string)
  //default     = ["10.1.101.0/24", "10.1.102.0/24"]
}

