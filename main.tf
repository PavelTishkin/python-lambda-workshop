terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"

  backend "s3" {
    bucket         = "system9020-tf-backend"
    key            = "state/python-demo/terraform.tfstate"
    region         = "eu-west-1"

    dynamodb_table = "tf-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}