data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["013907871322"]

  filter {
    name   = "name"
    values = ["suse-sles-15-sp5-v*-hvm-ssd-x86_64"]
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

# vim: ft=terraform : ts=2
