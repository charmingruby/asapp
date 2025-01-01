terraform {
  required_version = "1.10.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    region = "us-east-1"
    bucket = "asapp-tf"
    key    = "backend/terraform.tfstate"
  }
}

provider "aws" {
  region = var.aws_region
}
