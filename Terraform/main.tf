provider "aws" {
  region  = var.region
}

resource "aws_vpc" "vpc_name" {
 cidr_block = var.vpc_cidr_block
 tags = {
    Name = "Project 1 VPC"
  }
}

resource "aws_subnet" "subnet_name" {
 vpc_id = aws_vpc.vpc_name.id
 cidr_block = var.subnet_cidr_block
 availability_zone = var.availability_zone
 tags = {
    Name = "Project 1 Subnet"
  }
}

resource "aws_internet_gateway" "subnet_ig" {
  vpc_id = aws_vpc.vpc_name.id
  tags = {
    Name = "Internet_IG"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc_name.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.subnet_ig.id
  }

  tags = {
    Name = "Public Route"
  }
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.subnet_name.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "instance_sg" {
  vpc_id = aws_vpc.vpc_name.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
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
    Name = "SSH_Port"
  }
}

resource "aws_key_pair" "AWS_SSH_KEY" {
  key_name = "AWS_SSH_KEY"
  public_key = var.public_key
}

resource "aws_instance" "server_name" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.subnet_name.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  key_name = "AWS_SSH_KEY"
  associate_public_ip_address = true
  tags = {
    Name = var.server_name
    Environment = "Project1",
    Application = "Jenkins",
    Application = "Ansible",
  }
}