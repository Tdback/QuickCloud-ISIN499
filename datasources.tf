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

# vim: ft=terraform : ts=2
