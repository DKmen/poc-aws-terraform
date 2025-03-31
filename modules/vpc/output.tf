output "vpc_config" {
  value = {
    vpc_id                     = aws_vpc.custom_vpc.id
    public_subnet_ids          = [for subnet in aws_subnet.public_subnet : subnet.id]
    private_subnet_ids         = [for subnet in aws_subnet.private_subnet : subnet.id]
    igw_id                     = aws_internet_gateway.igw.id
    public_route_table_id      = aws_route_table.public_route_table.id
    private_route_table_id     = aws_route_table.private_route_table.id
    vpc_cidr_block             = aws_vpc.custom_vpc.cidr_block
    public_subnet_cidr_blocks  = [for subnet in aws_subnet.public_subnet : subnet.cidr_block]
    private_subnet_cidr_blocks = [for subnet in aws_subnet.private_subnet : subnet.cidr_block]
    aws_availability_zones     = data.aws_availability_zones.available.names
  }
}
