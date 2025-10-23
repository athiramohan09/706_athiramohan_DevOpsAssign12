terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "tls_private_key" "repo_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content  = tls_private_key.repo_key.private_key_pem
  filename = "${path.root}/terraform-key.pem"
}

resource "aws_key_pair" "generated" {
  key_name   = "devops_assignment_key"
  public_key = tls_private_key.repo_key.public_key_openssh
}

resource "aws_security_group" "swarm_sg" {
  name_prefix = "swarm-sg-"
  description = "Allow SSH, HTTP, Swarm ports"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress { from_port = 2377; to_port = 2377; protocol = "tcp"; cidr_blocks = ["0.0.0.0/0"] }
  ingress { from_port = 7946; to_port = 7946; protocol = "tcp"; cidr_blocks = ["0.0.0.0/0"] }
  ingress { from_port = 7946; to_port = 7946; protocol = "udp"; cidr_blocks = ["0.0.0.0/0"] }
  ingress { from_port = 4789; to_port = 4789; protocol = "udp"; cidr_blocks = ["0.0.0.0/0"] }
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ssh_allowed_cidr" {
  default = "0.0.0.0/0"
}

output "info" {
  value = "Terraform templates included. Customize before running."
}
