terraform {
  backend "s3" {
    bucket = "jb-tt-tf-state"
    key    = "eu-central/eu-central.tfstate"
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
