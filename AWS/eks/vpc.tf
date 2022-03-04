module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr_block

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.prv_sub_cidr_block
  public_subnets  = var.pub_sub_cidr_block

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = var.res_tags
}