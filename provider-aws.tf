terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.72"
    }

  }
}

provider "aws" {
  #version    = "~> 2.0"
  access_key = ""
  secret_key = ""
  #region     = "ap-northeast-2"
  region     = var.aws_region
}
