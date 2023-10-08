terraform {
  backend "s3" {
    bucket = "jb-tt-tf-state"
    key    = "us-east/us-east.tfstate"
    region = "eu-central-1"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.20.0"
    }
  }
}

provider "aws" {
    region    = var.region
}
