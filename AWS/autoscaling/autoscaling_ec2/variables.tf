variable "aws_project_name" {
  description = "Default AWS region"
  type        = string
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
}

variable "avlz" {
  description = "List of availability zones names."
  type        = list(string)
}

variable "subnets" {
  description = "List of subnets ids"
  type        = list(string)
}

variable "elb_security_groups" {
  description = "List of security group ids for load balancer"
  type        = list(string)
}

variable "web_serv_security_groups" {
  description = "List of security group ids for auto scaling group"
  type        = list(string)
}

variable "web_image_id" {
  description = "AWS AMI"
  type        = string
}

variable "web_instance_type" {
  description = "Type of instances."
  type        = string
}

variable "web_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  type        = number
}
variable "web_max_size" {
  description = "The maximum size of the Auto Scaling Group"
  type        = number
}
variable "web_min_size" {
  description = "The minimum size of the Auto Scaling Group"
  type        = number
}