terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.24"
    }
  }

  # backend "s3" {
  #   bucket         = "system9020-tf-backend"
  #   key            = "state/python-demo-4/terraform.tfstate"
  #   region         = "eu-west-1"

  #   dynamodb_table = "tf-state-lock"
  #   encrypt        = true
  # }
}

provider "aws" {
  profile = var.profile
  region  = "eu-west-1"
}
