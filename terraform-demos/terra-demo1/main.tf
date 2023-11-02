terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"

}

# Configure the AWS Provider

provider "aws" {
  region = "ap-south-1"
}

#Providing resource details - EC2 instance:
#with Amazon Machine Image (AMI) - Ubuntu Server 20.04 LTS (HVM), SSD Volume Type

resource "aws_instance" "app_server" {
  ami                     = "ami-0287a05f0ef0e9d9a"
  instance_type           = "t2.micro"
  
  tags = {
    Name = "Terra-demo1"

	}

}


