
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
 region = "us-east-2"
}

 resource "aws_vpc" "database" {
 cidr_block = "172.68.0.0/16"

 tags = {
  Name = "db_vpc"
 }
}

resource "aws_security_group" "rds_security_group" {
  name        = "rds-security-group"
  description = "Security group for RDS database access"
}

resource "aws_security_group_rule" "rds_ingress" {
  type        = "ingress"
  from_port   = 3306  # Assuming MySQL port, change as needed
  to_port     = 3306
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  # Allow traffic from a specific source IP or range

  security_group_id = aws_security_group.rds_security_group.id
}


resource "aws_db_instance" "default" {
 allocated_storage	= 10
 db_name		= "quick_cloud_db"
 engine			= "mysql"
 engine_version		= "5.7"
 instance_class		= "db.t3.micro"
 multi_az		= true
 username		= "peara"
 password		= "password123"
 parameter_group_name	= "default.mysql5.7"
 skip_final_snapshot	= true

 tags = {
  Name = "var.quick_cloud_db"
 }
}

