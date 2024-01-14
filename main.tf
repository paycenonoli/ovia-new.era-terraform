# Create local values
locals {
  company = "ovia-new-era"
  environment = "Production"
  Purpose = "A three-tier web application"
}

# Create an EC2 instance
resource "aws_instance" "ovia-app" {
  ami           = "ami-07b36ea9852e986ad"
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.ovia-sg.id]

  tags = {
    Name = "ovia-instance"
    description = "Instance created by ${local.company} for ${local.Purpose}"
  }
  depends_on = [ aws_security_group.ovia-sg ]
}

# Create a security group
resource "aws_security_group" "ovia-sg" {
  name        = "ovia-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = ""
  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
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
    Name = "ovia-sg"
  }
}

# Create a VPC

module "vpc" {
  providers = {
    aws = aws.us
  }
  source = "terraform-aws-modules/vpc/aws"

  name = "ovia-vpc"
  cidr = "10.0.0.0/16"

  #azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = local.environment
    Description = local.Purpose
  }
}

