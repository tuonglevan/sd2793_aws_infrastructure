resource "aws_eip" "nat_eip" {
  count = var.create_nat_gateway ? 1 : 0
}

resource "aws_nat_gateway" "nat_gateway" {
  count = var.create_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat_eip[0].id
  subnet_id     = aws_subnet.public_subnet[0].id
  depends_on    = [aws_internet_gateway.igw]

  tags = {
	Name = "NAT Gateway for ${var.vpc_base_name}"
  }
}

# Create private route table
resource "aws_route_table" "private_route_table" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.vpc.id

  dynamic "route" {
	for_each = var.create_nat_gateway ? [1] : []
	content {
	  cidr_block     = "0.0.0.0/0"
	  nat_gateway_id = aws_nat_gateway.nat_gateway[0].id
	}
  }

  tags = {
	Name = "Private Route table ${var.region}${element(split(",", "a,b,c"), count.index)} for ${var.vpc_base_name} "
  }
}

# Associate private subnets to private route table
resource "aws_route_table_association" "private_subnet_association" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
}