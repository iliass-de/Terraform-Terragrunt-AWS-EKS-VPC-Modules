# Internet VPC
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "main"
  }
}

# Subnets
resource "aws_subnet" "main-public-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr[0]
  map_public_ip_on_launch = "true"
  availability_zone       = var.availability_zone[0]

  tags = {
    Name = var.subnet_public_names[0]
  }
}

resource "aws_subnet" "main-public-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr[1]
  map_public_ip_on_launch = "true"
  availability_zone       = var.availability_zone[1]

  tags = {
    Name = var.subnet_public_names[1]
  }
}


resource "aws_subnet" "main-private-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidr[0]
  map_public_ip_on_launch = "false"
  availability_zone       = var.availability_zone[0]

  tags = {
    Name = var.subnet_private_names[0]
  }
}

resource "aws_subnet" "main-private-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidr[1]
  map_public_ip_on_launch = "false"
  availability_zone       = var.availability_zone[1]

  tags = {
    Name = var.subnet_private_names[1]
  }
}


# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.internet_gateway_name
  }
}

# route tables
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.route_table_cidr_block
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = var.route_table_name
  }
}

# route associations public
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = aws_subnet.main-public-1.id
  route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table_association" "main-public-2-a" {
  subnet_id      = aws_subnet.main-public-2.id
  route_table_id = aws_route_table.main-public.id
}