terraform {
  backend "s3" {
    bucket = "jb-tt-tf-state"
    key    = "dnslb/dnslb.tfstate"
    region = "eu-central-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.20.0"
    }
  }
}

provider "aws" {
    region = "eu-central-1"
}

provider "aws" {
    region = "eu-central-1"
    alias  = "eu-central-1"
}

provider "aws" {
    region = "us-east-1"
    alias  = "us-east-1"
}