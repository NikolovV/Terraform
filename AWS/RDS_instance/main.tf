module "vpc" {
  source              = "./modules/network"
  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  public_subnets      = var.public_subnets
  security_group_name = var.aws_region
  whitelist           = var.whitelist
  sg_ingress          = var.sg_ingress
  sg_egress           = var.sg_egress
}

module "rds" {
  source                 = "./modules/rds"
  db_indetifier          = var.db_indetifier
  instance_calass        = var.instance_calass
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  username               = var.username
  db_password            = var.db_password
  subnet_ids             = module.vpc.public_subnets
  vpc_security_group_ids = [module.vpc.security_group_id]
  db_parameter_family    = var.db_parameter_family
  db_parameters          = var.db_parameters
}