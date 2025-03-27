# Create a VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.vpc_name}"
  }
}

# Fetch All AZs in Region
data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# Create a Public and Private Subnet for each AZ
resource "aws_subnet" "public_subnet" {
  for_each = toset(data.aws_availability_zones.available.names)
  vpc_id   = aws_vpc.custom_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, index(tolist(data.aws_availability_zones.available.names), each.value)*2)
  map_public_ip_on_launch = true
  availability_zone = each.value
  tags = {
    Name = "${var.vpc_name}-public-${each.value}"
  }
}

resource "aws_subnet" "private_subnet" {
  for_each = toset(data.aws_availability_zones.available.names)
  vpc_id   = aws_vpc.custom_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, index(tolist(data.aws_availability_zones.available.names), each.value)*2 +1)
  map_public_ip_on_launch = false
  availability_zone = each.value
  tags = {
    Name = "${var.vpc_name}-private-${each.value}"
  }
}

# Create an Internet Gateway if var.needs_igw is true
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# Create a Route Table for Public Subnet
resource "aws_route_table" "public_route_table" {
  vpc_id   = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_subnet_association" {
  for_each = toset(data.aws_availability_zones.available.names)
  subnet_id      = aws_subnet.public_subnet[each.key].id
  route_table_id = aws_route_table.public_route_table.id
}

# Create a Route Table for Private Subnet 
resource "aws_route_table" "private_route_table" {
  vpc_id   = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private_subnet_association" {
  for_each = toset(data.aws_availability_zones.available.names)
  subnet_id      = aws_subnet.private_subnet[each.key].id
  route_table_id = aws_route_table.private_route_table.id
}
