terraform {
  required_version = ">=1.2.3"
  backend "s3" {
    bucket         = "gbg-terraform-state"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "gbg-terraform-state-lock"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.2"
    }
    random = {
      source= "hashicorp/random"
      version="~> 3.3"
    }
  }
}