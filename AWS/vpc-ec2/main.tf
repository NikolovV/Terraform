terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  profile = "default"
  region  = var.aws-region
}

// 1. Creating VPC
resource "aws_vpc" "terr-ec2-vpc" {
  cidr_block = var.vpc-cidr-block // you can change default value with: terraform apply -var "vpc-cidr-block=type_yout_IP"
  instance_tenancy = "default"
  tags = {
    Name = "ec2-vpc"

    // Add tags to resource
    Provisioner = var.tags-descr["Provisioner"]
    Project     = var.tags-descr["Project"]
  }
}

// 2. Creating Internet Gateway
resource "aws_internet_gateway" "terr-ec2-gw" {
  vpc_id = aws_vpc.terr-ec2-vpc.id

  tags = {
    Name        = "ec2-igw"
    Provisioner = var.tags-descr["Provisioner"]
    Project     = var.tags-descr["Project"]
  }
}

// 3. Creating Route Table
resource "aws_route_table" "terr-ec2-rt" {
  vpc_id = aws_vpc.terr-ec2-vpc.id

  route {
    cidr_block = var.rt-cidr-block
    gateway_id = aws_internet_gateway.terr-ec2-gw.id
  }

  tags = {
    Name        = "ec2-rt"
    Provisioner = var.tags-descr["Provisioner"]
    Project     = var.tags-descr["Project"]
  }
}

// 4. Creating Subnet
resource "aws_subnet" "terr-ec2-pub-sub" {
  vpc_id     = aws_vpc.terr-ec2-vpc.id
  cidr_block = var.pub-sub-cidr-block

  availability_zone = var.alz

  tags = {
    Name        = "ec2-pub-sub"
    Provisioner = var.tags-descr["Provisioner"]
    Project     = var.tags-descr["Project"]
  }
}

// 5. Associate subnet with route table
resource "aws_route_table_association" "terr-ec2-sub-rt-assoc" {
  subnet_id      = aws_subnet.terr-ec2-pub-sub.id
  route_table_id = aws_route_table.terr-ec2-rt.id
}

// 6. Creating Security group and open port 22, 80, 443
resource "aws_security_group" "terr-ec2-sg" {
  name        = "allow-web-ssh"
  description = "Allow web and SSH traffic"
  vpc_id      = aws_vpc.terr-ec2-vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "ec2-sg"
    Provisioner = var.tags-descr["Provisioner"]
    Project     = var.tags-descr["Project"]
  }
}

// 7. Creating Network Interface
resource "aws_network_interface" "terr-ec2-nic" {
  subnet_id       = aws_subnet.terr-ec2-pub-sub.id
  private_ips     = [var.nic-ip]
  security_groups = [aws_security_group.terr-ec2-sg.id]

  tags = {
    Name        = "ec2-nic"
    Provisioner = var.tags-descr["Provisioner"]
    Project     = var.tags-descr["Project"]
  }
}

// 8. Creating Elastic IP
resource "aws_eip" "terr-ec2-eip" {
  vpc      = true
  network_interface = aws_network_interface.terr-ec2-nic.id
  associate_with_private_ip = var.nic-ip

  depends_on = [aws_internet_gateway.terr-ec2-gw]

  tags = {
    Name        = "ec2-eip"
    Provisioner = var.tags-descr["Provisioner"]
    Project     = var.tags-descr["Project"]
  }
}

// 9. Creating EC2
resource "aws_instance" "terr-ec2" {
  ami           = var.ec2-ami
  instance_type = var.ec2-instance-type
  availability_zone = var.alz
  key_name = "ec2-vpc"

  root_block_device {
    volume_size = 8
    volume_type = "standard"
  }

  network_interface {
    network_interface_id = aws_network_interface.terr-ec2-nic.id
    device_index         = 0
  }
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd.x86_64
    systemctl start httpd.service
    systemctl enable httpd.service
    echo “Hello World from $(hostname -f)” > /var/www/html/index.html
  EOF

  tags = {
    Name        = "ec2"
    Provisioner = var.tags-descr["Provisioner"]
    Project     = var.tags-descr["Project"]
  }
}