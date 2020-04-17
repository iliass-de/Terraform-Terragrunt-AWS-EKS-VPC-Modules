terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {
    bucket = var.bucket
    key    = var.key
    region = var.region
  }
}


