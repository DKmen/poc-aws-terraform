# Create a Public and Private Subnet for each AZ
resource "aws_subnet" "public_subnet" {
  for_each                = toset(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, index(tolist(data.aws_availability_zones.available.names), each.value) * 2)
  map_public_ip_on_launch = true
  availability_zone       = each.value
  tags = {
    Name = "${var.vpc_name}-public-${each.value}"
  }
}

resource "aws_subnet" "private_subnet" {
  for_each                = toset(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, index(tolist(data.aws_availability_zones.available.names), each.value) * 2 + 1)
  map_public_ip_on_launch = false
  availability_zone       = each.value
  tags = {
    Name = "${var.vpc_name}-private-${each.value}"
  }
}
