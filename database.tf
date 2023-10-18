resource "aws_security_group" "quickcloud_sg_db" {
  name        = "quickcloud-rds-sg"
  description = "Security group for RDS database access"
  vpc_id      = aws_vpc.quickcloud_vpc.id

  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.quickcloud_sg.id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.quickcloud_sg.id]
  }

  tags = {
    Name = "quickcloud_sg_db"
  }
}

resource "aws_db_subnet_group" "quickcloud_db_subnetgroup" {
  name       = "quickcloud_db_subnetgroup"
  subnet_ids = [for subnet in aws_subnet.quickcloud_private_db : subnet.id]

  tags = {
    Name = "quickcloud_db_subnet_group"
  }
}

resource "aws_db_instance" "quickcloud_db" {
  db_name              = "quick_cloud_db"
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mariadb10.5"
  db_subnet_group_name = aws_db_subnet_group.quickcloud_db_subnetgroup.name
  skip_final_snapshot  = true
  multi_az             = true
  allocated_storage    = 50
  max_allocated_storage = 100

  tags = {
    Name = "quickcloud_db"
  }
}

