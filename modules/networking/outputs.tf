output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "cidr_block" {
  value = aws_vpc.vpc.cidr_block
}
output "public_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet.*.id
}

output "public_route_table_id" {
  value = aws_route_table.public_route_table.id
}

output "private_route_table_ids" {
  value = aws_route_table.private_route_table.*.id
}

output "nat_gateway_id" {
  value = var.create_nat_gateway ? aws_nat_gateway.nat_gateway[0].id : "NAT Gateway Not Created"
}