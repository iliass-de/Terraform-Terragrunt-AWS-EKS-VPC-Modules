module "vpc" {
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  availability_zone         = ["eu-central-1a","eu-central-1b"]
  subnet_public_names       = ["terraform-public-1","terraform-public-2"]
  public_subnet_cidr        = ["10.0.1.0/24","10.0.2.0/24"]
  subnet_private_names      = ["terraform-private-1","terraform-private-1"]
  private_subnet_cidr       = ["10.0.4.0/24","10.0.5.0/24"]
  internet_gateway_name     = "terraform"
  route_table_name          = "terraform-public-1"
  route_table_cidr_block    = "0.0.0.0/0"
}
