# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags = {
	Name = "${var.vpc_base_name} VPC"
  }
}

# Create Internet Gateway and NAT Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_base_name} Internet Gateway"
  }
}

# resource "aws_eip" "nat_eip" {
# }
#
# resource "aws_nat_gateway" "nat_gateway" {
#   allocation_id = aws_eip.nat_eip.id
#   subnet_id     = aws_subnet.public_subnet[0].id
#   depends_on    = [aws_internet_gateway.igw]
#   tags = {
#     Name = "${var.vpc_base_name} NAT Gateway"
#   }
# }

# Create 3 public subnets
resource "aws_subnet" "public_subnet" {
  count                   = 3
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public_subnet_ips, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(var.availability_zones, count.index)
  tags = {
    Name = "${var.vpc_base_name} Public Subnet ${count.index + 1}"
  }
}

# Create 3 private subnets
# resource "aws_subnet" "private_subnet" {
#   count             = 3
#   vpc_id            = aws_vpc.vpc.id
#   cidr_block        = element(var.private_subnet_ips, count.index)
#   availability_zone = element(var.availability_zones, count.index)
#   tags = {
# 	Name = "${var.vpc_base_name} Private Subnet ${count.index + 1}"
#   }
# }

# Create public route table creation
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
	Name = "${var.vpc_base_name} Public Route table"
  }
}

# Create private route table
# resource "aws_route_table" "private_route_table" {
#   vpc_id = aws_vpc.vpc.id
#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat_gateway.id
#   }
#   tags = {
# 	Name = "${var.vpc_base_name} Private Route table"
#   }
# }
# Set route table as the main
resource "aws_main_route_table_association" "set_main" {
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associate public subnets with public route table
resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_subnet_ips)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# Associate private subnets with private route table
# resource "aws_route_table_association" "private_subnet_association" {
#   count          = length(var.private_subnet_ips)
#   subnet_id      = aws_subnet.private_subnet[count.index].id
#   route_table_id = aws_route_table.private_route_table.id
# }