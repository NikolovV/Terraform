resource "aws_db_instance" "pg_db_instance" {
  identifier              = var.db_indetifier
  instance_class          = var.instance_calass
  allocated_storage       = var.allocated_storage
  engine                  = var.engine
  engine_version          = var.engine_version
  username                = var.username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_gr.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  parameter_group_name    = aws_db_parameter_group.education.name
  publicly_accessible     = true
  skip_final_snapshot     = true
  apply_immediately       = true
  backup_retention_period = 1
}

resource "aws_db_subnet_group" "db_subnet_gr" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids
  tags       = var.resource_tags
}

# Create read replica
resource "aws_db_instance" "pg_db_read_instance" {
  name                   = "replica-${var.db_indetifier}"
  identifier             = "replica-${var.db_indetifier}"
  replicate_source_db    = aws_db_instance.pg_db_instance.identifier
  instance_class         = var.instance_calass
  apply_immediately      = true
  publicly_accessible    = true
  skip_final_snapshot    = true
  vpc_security_group_ids = var.vpc_security_group_ids
  parameter_group_name   = aws_db_parameter_group.education.name
}

resource "aws_db_parameter_group" "education" {
  name   = var.db_parameter_name
  family = var.db_parameter_family

  parameter {
    name  = var.db_parameters["name"]
    value = var.db_parameters["value"]
  }
}