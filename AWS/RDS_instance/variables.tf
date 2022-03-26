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
    Project   = "S3-Website"
  }
}

variable "whitelist" {
  description = "Allowed list of IP for access."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

### VPC
variable "vpc_name" {
  description = "Default VPC name"
  type        = string
  default     = "rds-vpc"
}

variable "vpc_cidr" {
  description = "Default VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Default public subnets"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24"]
}

variable "security_group_name" {
  description = "Default security group name"
  type        = string
  default     = "rds-sg-vpc"
}

variable "sg_ingress" {
  description = "Default security group name"
  type        = map(string)
  default = {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
  }
}

variable "sg_egress" {
  description = "Default security group name"
  type        = map(string)
  default = {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
  }
}

### RDS
variable "db_indetifier" {
  description = "Default RDS indentifier"
  type        = string
  default     = "rds-write"
}

variable "instance_calass" {
  description = "Default instance calass"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Default RDS allocated storage"
  type        = number
  default     = 5
}

variable "engine" {
  description = "Default RDS engine"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Default RDS engine version"
  type        = string
  default     = "13.1"
}

variable "username" {
  description = "Default RDS username"
  type        = string
  default     = "user_pgdb"
}

variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
  default     = "ps_admin_123567"
}

variable "db_parameter_family" {
  description = "Default db parameter family"
  type        = string
  default     = "postgres13"
}

variable "db_parameters" {
  description = "Default db parameters"
  type        = map(string)
  default = {
    name  = "log_connections"
    value = "1"
  }
}

