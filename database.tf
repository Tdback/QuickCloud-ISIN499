resource "aws_security_group" "quickcloud_sg_db" {
  name        = "quickcloud-rds-sg"
  description = "Security group for RDS database access"
  vpc_id      = aws_vpc.quickcloud_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
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

<<<<<<< HEAD
resource "aws_security_group_rule" "rds_ingress" {
  type        = "ingress"
  from_port   = 3306 # Assuming MySQL port, change as needed
  to_port     = 3306
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"] # Allow traffic from a specific source IP or range

  security_group_id = aws_security_group.rds_security_group.id
}


=======
>>>>>>> 70ada1f (DB now launches in private subnets in VPC.)
resource "aws_db_instance" "quickcloud_db" {
  allocated_storage    = 10
  db_name              = "quick_cloud_db"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "peara"
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  multi_az             = true

  tags = {
    Name = "quickcloud_db"
  }
}

