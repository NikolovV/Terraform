# Set beckend
terraform {
  backend "s3" {
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-module-example"

  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.pub_subnet_cidr
  public_subnets  = var.prv_subnet_cidr

  enable_nat_gateway = true
  single_nat_gateway = true
}
