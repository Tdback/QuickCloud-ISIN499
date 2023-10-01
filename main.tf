provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "quickcloud_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "quickcloud_vpc"
  }
}

resource "aws_subnet" "quickcloud_public" {
  count                   = length(var.public_subnet)
  vpc_id                  = aws_vpc.quickcloud_vpc.id
  cidr_block              = var.public_subnet[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "quickcloud_public_${count.index}"
  }
}

resource "aws_subnet" "quickcloud_private" {
  count                   = length(var.private_subnet)
  vpc_id                  = aws_vpc.quickcloud_vpc.id
  cidr_block              = var.private_subnet[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "quickcloud_private_${count.index}"
  }
}

resource "aws_internet_gateway" "quickcloud_gw" {
  vpc_id = aws_vpc.quickcloud_vpc.id

  tags = {
    Name = "quickcloud_gw"
  }
}

resource "aws_route_table" "quickcloud_rt" {
  vpc_id = aws_vpc.quickcloud_vpc.id

  tags = {
    Name = "quickcloud_public_rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.quickcloud_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.quickcloud_gw.id
}

resource "aws_route_table_association" "quickcloud_public_assoc" {
  count          = length(var.public_subnet)
  subnet_id      = aws_subnet.quickcloud_public[count.index].id
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

resource "aws_instance" "quickcloud_instance" {
  count                  = length(var.server)
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.test_ssh.id
  vpc_security_group_ids = [aws_security_group.quickcloud_sg.id]
  subnet_id              = aws_subnet.quickcloud_public[count.index].id
  user_data              = file("./bootstrap.tpl")

  root_block_device {
    volume_size = 16 # Max number of gigs in free tier
  }

  tags = {
    Name = "quickcloud_node_${count.index}"
  }
}

# vim: ft=terraform : ts=2
