data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["098598839212"]

  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }
}

data "aws_ami" "bastion_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# vim: ft=terraform :ts=2
