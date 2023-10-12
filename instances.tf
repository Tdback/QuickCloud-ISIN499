resource "aws_security_group" "quickcloud_ssh_sg" {
  name        = "SSH Access to jump box"
  description = "Enabling ssh access to the jump box"
  vpc_id      = aws_vpc.quickcloud_vpc.id

  ingress {
    from_port   = 2222
    to_port     = 2222
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
    Name = "SSH_sg"
  }
}

resource "aws_key_pair" "test_ssh" {
  key_name   = "aws_ssh_testing"
  public_key = file("~/.ssh/aws_ssh_testing.pub")
}

resource "aws_instance" "jump_box" {
  instance_type          = var.type
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.test_ssh.id
  vpc_security_group_ids = [aws_security_group.quickcloud_ssh_sg.id]
  subnet_id              = aws_subnet.quickcloud_public[0].id
  user_data              = file("./templates/jumpbox.tpl")

  root_block_device {
    volume_size = 8 # This box won't hold much data
  }

  tags = {
    Name = "quickcloud_jumpbox"
  }
}

resource "aws_security_group" "quickcloud_sg" {
  name        = "Everything"
  description = "Enabling all access to the cloud boxes (temporary)"
  vpc_id      = aws_vpc.quickcloud_vpc.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.quickcloud_ssh_sg.id]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.quickcloud_alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Everything_sg"
  }
}

resource "aws_instance" "quickcloud_instance" {
  count                  = length(var.server_name)
  instance_type          = var.type
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.test_ssh.id
  vpc_security_group_ids = [aws_security_group.quickcloud_sg.id]
  subnet_id              = aws_subnet.quickcloud_private_server[count.index].id
  private_ip             = var.private_ips[count.index]
  user_data              = file("./templates/bootstrap.tpl")

  root_block_device {
    volume_size = 16 # Max number of gigs in free tier
  }

  tags = {
    Name = "quickcloud_node_${count.index}"
  }
}

# vim: ft=terraform : ts=2
