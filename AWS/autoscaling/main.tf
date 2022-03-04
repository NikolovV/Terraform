// source https://github.com/andreivmaksimov/terraform-recipe-managing-auto-scaling-groups-and-load-balancers

# Create VPC, NAT GW, subnet for availability zones
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name             = "${terraform.workspace}-my-vpc"
  cidr             = var.cidr_block
  azs              = var.avlz
  public_subnets   = var.publ_sub_cidr
  instance_tenancy = "default"

  # Single NAT Gateway - https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = false

  vpc_tags                 = var.res_tags
  public_subnet_tags       = var.res_tags
  private_route_table_tags = var.res_tags
}

# Create web security group for the auto scaling group.
resource "aws_security_group" "web_server_sg" {
  name   = "${terraform.workspace}-web-server-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.whitelist
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.res_tags
}

# Create security group for load balancer.
resource "aws_security_group" "elb_sg" {
  name        = "elb_sg"
  description = "Allow standard HTTP and HTTPS ports inbound and everything outbound"
  vpc_id      = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = var.security_group_ingress

    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = var.whitelist
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.res_tags
}

# Construct auto scaling module.
module "autoscaling_ec2" {
  source = "./autoscaling_ec2"

  avlz                     = var.avlz
  web_image_id             = var.web_image_id
  web_instance_type        = var.web_instance_type
  web_desired_capacity     = var.web_desired_capacity
  web_max_size             = var.web_max_size
  web_min_size             = var.web_min_size
  subnets                  = module.vpc.public_subnets
  elb_security_groups      = [aws_security_group.elb_sg.id]
  web_serv_security_groups = [aws_security_group.web_server_sg.id]
  resource_tags            = var.res_tags
  aws_project_name         = var.aws_project_name
}