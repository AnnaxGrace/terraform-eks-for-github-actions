resource "aws_route_table" "route_table_public_POC" {
  vpc_id = aws_vpc.vpc_POC.id

  tags = merge(
    {
      "Name" = format("%s-rt-public", var.vpc_name)
    },
    var.app_tags,
    local.module_tags
  )
}

resource "aws_route_table" "route_table_private_POC" {
  count = var.private_subnet_count
  vpc_id = aws_vpc.vpc_POC.id

  tags = merge(
    {
      "Name" = format("%s-rt-private", var.vpc_name)
    },
    var.app_tags,
    local.module_tags
  )
}

resource "aws_route" "public_internet_gateway_POC" {
  route_table_id         = aws_route_table.route_table_public_POC.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_POC.id
}

resource "aws_route" "private_nat_gateway_POC" {
  count                  = var.private_subnet_count
  route_table_id         = aws_route_table.route_table_private_POC.*.id[count.index]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw_POC.*.id[count.index]
}

resource "aws_route_table_association" "rta_public_POC" {
  count          = var.public_subnet_count
  subnet_id      = aws_subnet.subnet_public_POC.*.id[count.index]
  route_table_id = aws_route_table.route_table_public_POC.id
}

resource "aws_route_table_association" "rta_private_POC" {
  count          = var.private_subnet_count
  subnet_id      = aws_subnet.subnet_private_POC.*.id[count.index]
  route_table_id = aws_route_table.route_table_private_POC.*.id[count.index]
}
