output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.pg_db_instance.address
  sensitive   = true
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.pg_db_instance.port
  sensitive   = true
}

output "rds_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.pg_db_instance.username
}

output "rds_replica_connection_parameters" {
  description = "RDS replica instance connection parameters"
  value       = "psql -h ${aws_db_instance.pg_db_read_instance.address} -p ${aws_db_instance.pg_db_read_instance.port} -U ${aws_db_instance.pg_db_read_instance.username} postgres"
}