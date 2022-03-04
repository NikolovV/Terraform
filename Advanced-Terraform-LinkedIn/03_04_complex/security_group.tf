# Security group
resource "aws_security_group" "sg_frontend" {
  name   = "sg_frontend"
  vpc_id = module.vpc.vpc_id

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
}
