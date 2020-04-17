provider "aws" {
  version = "~> 2.32"
  region  = "us-east-1"
}

module "vpc" {
  source = "./vpc"
}


