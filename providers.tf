provider "aws" {
  region              = "us-east-1"
}

terraform {
  backend "s3" {
    bucket            = "terraform-machine-setup"
    key               = "instance/terraform.tfstate"
    dynamodb_table    = "terraform"
    region            = "us-east-1"
  }
}