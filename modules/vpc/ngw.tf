# Create a NAT Gateway in one of the Public Subnet
resource "aws_eip" "nat_eip" {
  tags = {
    Name = "NAT EIP"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.allocation_id
  subnet_id = aws_subnet.public_subnet[data.aws_availability_zones.available.names[0]].id
  connectivity_type = "public"

  tags = {
    Name = "${var.vpc_name}-nat-gw"
  }
}
