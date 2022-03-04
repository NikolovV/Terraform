output "rds_username" {
  description = "RDS instance root username"
  value       = module.rds.rds_username
}

output "rds_replica_connection_parameters" {
  description = "RDS replica instance connection parameters"
  value       = module.rds.rds_replica_connection_parameters
}