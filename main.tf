provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "quickcloud_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev_vpc"
  }
}

resource "aws_subnet" "quickcloud_sub_pub" {
  vpc_id                  = aws_vpc.quickcloud_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"

  tags = {
    Name = "dev_sub_pub"
  }
}

resource "aws_internet_gateway" "quickcloud_gw" {
  vpc_id = aws_vpc.quickcloud_vpc.id

  tags = {
    Name = "dev_gw"
  }
}

resource "aws_route_table" "quickcloud_rt" {
  vpc_id = aws_vpc.quickcloud_vpc.id

  tags = {
    Name = "dev_public_rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.quickcloud_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.quickcloud_gw.id
}

resource "aws_route_table_association" "quickcloud_public_assoc" {
  subnet_id      = aws_subnet.quickcloud_sub_pub.id
  route_table_id = aws_route_table.quickcloud_rt.id
}

resource "aws_security_group" "quickcloud_sg" {
  name        = "SSH_access"
  description = "Enabling SSH access to the boxes"
  vpc_id      = aws_vpc.quickcloud_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "test_ssh" {
  key_name   = "aws_ssh_testing"
  public_key = file("~/.ssh/aws_ssh_testing.pub")
}

resource "aws_instance" "quickcloud_instance_1" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.test_ssh.id
  vpc_security_group_ids = [aws_security_group.quickcloud_sg.id]
  subnet_id              = aws_subnet.quickcloud_sub_pub.id
  user_data              = file("./bootstrap.tpl")

  root_block_device {
    volume_size = 16 # Max number of gigs in free tier
  }

  tags = {
    Name = "dev-node"
  }
}

# vim: ft=terraform : ts=2
