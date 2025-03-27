# Create Network ACL for each subnets
resource "aws_network_acl" "acl" {
  for_each = merge(aws_subnet.private_subnet, aws_subnet.public_subnet)
  vpc_id     = aws_vpc.custom_vpc.id
  subnet_ids = [each.value.id]

  ingress {
    protocol  = "-1"
    rule_no   = 100
    action    = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  ingress {
    protocol = "-1"
    rule_no   = 200
    action    = "deny"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  egress {
    protocol  = "-1"
    rule_no   = 100
    action    = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  egress {
    protocol = "-1"
    rule_no   = 200
    action    = "deny"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  tags = {
    Name = "${var.vpc_name}-acl-${each.value.tags.Name}"
  }
}
