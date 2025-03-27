# Create an Internet Gateway if var.needs_igw is true
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}
