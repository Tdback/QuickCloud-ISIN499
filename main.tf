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

resource "aws_instance" "app_server" {
  ami           = "ami-0ddf7dfd13a83d8c8"
  instance_type = "t2.micro"
  tags = {
    Name = var.instance_name
  }
}

