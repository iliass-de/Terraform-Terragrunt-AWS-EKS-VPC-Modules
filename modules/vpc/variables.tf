variable "cidr_block" {
  description = "Ip of Internet VPC"
  type = string
}

variable "availability_zone" {
  description = "availability_zones"
  type        = list
}

variable "subnet_public_names" {
   description = "names of public subnets"
   type        = list
}
variable "public_subnet_cidr" {
  description = "ips of public subnets"
  type        = list
}

variable "subnet_private_names" {
   description = "names of private subnets"
   type        = list
}
variable "private_subnet_cidr" {
  description = "ips of private subnets"
  type        = list
}

variable "internet_gateway_name" {
  description  = "name of the internet gateway"
  type         = string
}

variable "route_table_name" {
  description = "name of the route table"
  type         = string
}

variable "route_table_cidr_block" {
  description = "cidr block"
  type         = string
}
