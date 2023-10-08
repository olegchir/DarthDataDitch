data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket = "jb-tt-tf-state"
    key    = "global/global.tfstate"
    region = "eu-central-1"
  }
}