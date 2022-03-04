variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}

variable "db_indetifier" {
  description = "Default RDS indentifier"
  type        = string
}

variable "instance_calass" {
  description = "Default instance calass"
  type        = string
}

variable "allocated_storage" {
  description = "Default RDS allocated storage"
  type        = number
}

variable "engine" {
  description = "Default RDS engine"
  type        = string
}

variable "engine_version" {
  description = "Default RDS engine version"
  type        = string
}

variable "username" {
  description = "Default RDS username"
  type        = string
}

variable "subnet_ids" {
  description = "subnet ids"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "Security group id"
  type        = set(string)
}

variable "db_parameter_name" {
  description = "RDS parameter name"
  type        = string
  default     = "db-rds-param"
}

variable "db_parameter_family" {
  description = "Default db parameter family"
  type        = string
}

variable "db_subnet_group_name" {
  description = "Default db subnet group name"
  type        = string
  default     = "rds-sub-gr"
}

variable "db_parameters" {
  description = "Default db parameters"
  type        = map(string)
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    Terraform = "True"
    Project   = "RDS"
  }
}