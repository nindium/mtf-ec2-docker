provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "mtf-state-bucket"
    key            = "terraform.tfstate"
    dynamodb_table = "mtf-project"
    encrypt        = true
  }
}
