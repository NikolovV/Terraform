# 1. Creating VPC
resource "aws_vpc" "ec2_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  tags             = var.res_tags
}

# 2. Creating Internet Gateway
resource "aws_internet_gateway" "ec2_vpc_gw" {
  vpc_id = aws_vpc.ec2_vpc.id
  tags   = var.res_tags
}

# 3. Creating Route Table
resource "aws_route_table" "ec2_vpc_rt" {
  vpc_id = aws_vpc.ec2_vpc.id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_internet_gateway.ec2_vpc_gw.id
  }

  tags = var.res_tags
}

# 4. Creating Subnet
resource "aws_subnet" "ec2_vpc_pub_sub" {
  vpc_id            = aws_vpc.ec2_vpc.id
  cidr_block        = var.pub_sub_cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]
  tags              = var.res_tags
}

# 5. Associate subnet with route table
resource "aws_route_table_association" "ec2_vpc_rt_assoc" {
  subnet_id      = aws_subnet.ec2_vpc_pub_sub.id
  route_table_id = aws_route_table.ec2_vpc_rt.id
}

# 6. Creating Security group
resource "aws_security_group" "ec2_vpc_sg" {
  name        = "allow-web-ssh"
  description = "Allow web and SSH traffic"
  vpc_id      = aws_vpc.ec2_vpc.id

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

# 7. Creating Network Interface
resource "aws_network_interface" "ec2_vpc_nic" {
  subnet_id       = aws_subnet.ec2_vpc_pub_sub.id
  private_ips     = [var.nic_ip]
  security_groups = [aws_security_group.ec2_vpc_sg.id]

  tags = var.res_tags
}

# 8. Create aws key-pair 
resource "aws_key_pair" "kp" {
  key_name   = "ec2-vpc-key"
  public_key = file(var.ec2_key_file)
}

# 9. Creating Elastic IP
resource "aws_eip" "ec2_vpc_eip" {
  vpc      = true
  network_interface = aws_network_interface.ec2_vpc_nic.id
  associate_with_private_ip = var.nic_ip

  depends_on = [aws_internet_gateway.ec2_vpc_gw]

  tags = var.res_tags
}

# 10. Creating EC2
resource "aws_instance" "ec2" {
  ami               = data.aws_ami.aws-linux.id
  instance_type     = var.ec2_instance_type
  availability_zone = data.aws_availability_zones.available.names[0]
  key_name          = aws_key_pair.kp.key_name

  provisioner "file" {
    source      = "install_apche.sh"
    destination = "/tmp/install_apche.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_apche.sh",
      "sudo /tmp/install_apche.sh"
    ]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.instance_user
    private_key = file(var.private_key)
  }

  root_block_device {
    volume_size = 8
    volume_type = "standard"
  }

  network_interface {
    network_interface_id = aws_network_interface.ec2_vpc_nic.id
    device_index         = 0
  }

  tags = var.res_tags
}