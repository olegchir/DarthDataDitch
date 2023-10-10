data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket = "jb-tt-tf-state"
    key    = "global/global.tfstate"
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "us-east" {
  backend = "s3"
  config = {
    bucket = "jb-tt-tf-state"
    key    = "us-east/us-east.tfstate"
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "eu-central" {
  backend = "s3"
  config = {
    bucket = "jb-tt-tf-state"
    key    = "eu-central/eu-central.tfstate"
    region = "eu-central-1"
  }
}