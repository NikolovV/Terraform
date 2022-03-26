# VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "frontend-vpc"
  cidr   = var.vpc_cidr_block

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.pub_subnet_cidr
  public_subnets  = var.prv_subnet_cidr

  enable_nat_gateway = true
  single_nat_gateway = true
  # one_nat_gateway_per_az = true
}