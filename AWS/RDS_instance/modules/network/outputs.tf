output "public_subnets" {
  description = "VPC public subnet list"
  value       = module.vpc.public_subnets
}

output "security_group_id" {
  description = "VPC  security groupslist"
  value       = aws_security_group.rds.id
}