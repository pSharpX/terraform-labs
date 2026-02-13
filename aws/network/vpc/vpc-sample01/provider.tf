terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.32.1"
    }
  }

  # Backend configuration for remote state storage
  backend "s3" {}
}

provider "aws" {
    region = "${var.AWS_REGION}"
}