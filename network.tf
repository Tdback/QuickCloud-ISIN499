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

resource "aws_subnet" "quickcloud_private_server" {
  count                   = length(var.private_server)
  vpc_id                  = aws_vpc.quickcloud_vpc.id
  cidr_block              = var.private_server[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "quickcloud_private_server_${count.index}"
  }
}

resource "aws_subnet" "quickcloud_private_db" {
  count                   = length(var.private_db)
  vpc_id                  = aws_vpc.quickcloud_vpc.id
  cidr_block              = var.private_db[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "quickcloud_private_db_${count.index}"
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
    Name = "quickcloud_rt_public"
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

resource "aws_security_group" "quickcloud_alb_sg" {
  name        = "alb-sg"
  description = "Security group for the ALB"
  vpc_id      = aws_vpc.quickcloud_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "quickcloud_alb_sg"
  }
}

resource "aws_lb" "quickcloud_alb" {
  name               = "webserver-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.quickcloud_alb_sg.id]
  subnets            = [for subnet in aws_subnet.quickcloud_public : subnet.id]

  enable_http2               = true
  enable_deletion_protection = false
}

resource "aws_lb_listener" "quickcloud_listener" {
  load_balancer_arn = aws_lb.quickcloud_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.quickcloud_tg.arn
  }
}

resource "aws_lb_target_group" "quickcloud_tg" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.quickcloud_vpc.id
}

resource "aws_lb_target_group_attachment" "quickcloud_tg_attach" {
  for_each         = { for k, v in var.server_name : k => v }
  target_group_arn = aws_lb_target_group.quickcloud_tg.arn
  target_id        = aws_instance.quickcloud_instance[each.key].id
  port             = 80
}

resource "aws_eip" "quickcloud_nat_eip" {
  count                     = length(var.public_subnet)
  associate_with_private_ip = var.eips[count.index]
  depends_on                = [aws_internet_gateway.quickcloud_gw]

  tags = {
    Name = "quickcloud_nat_eip"
  }
}

resource "aws_nat_gateway" "quickcloud_nat_gw" {
  count         = length(var.public_subnet)
  allocation_id = aws_eip.quickcloud_nat_eip[count.index].id
  subnet_id     = aws_subnet.quickcloud_public[count.index].id

  tags = {
    Name = "quickcloud_nat_gw_${count.index}"
  }
}

resource "aws_route_table" "quickcloud_rt_private" {
  count  = length(var.private_server)
  vpc_id = aws_vpc.quickcloud_vpc.id

  tags = {
    Name = "quickcloud_rt_private_${count.index}"
  }

}

resource "aws_route" "private_route" {
  count                  = length(var.private_server)
  route_table_id         = aws_route_table.quickcloud_rt_private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.quickcloud_nat_gw[count.index].id
}

resource "aws_route_table_association" "quickcloud_private_assoc" {
  count          = length(var.private_server)
  subnet_id      = aws_subnet.quickcloud_private_server[count.index].id
  route_table_id = aws_route_table.quickcloud_rt_private[count.index].id
}

# vim: ft=terraform : ts=2
