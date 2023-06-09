resource "aws_nat_gateway" "natgw_POC" {
  count = var.public_subnet_count
  connectivity_type = "public"
  subnet_id = aws_subnet.subnet_public_POC.*.id[count.index]
  allocation_id = aws_eip.eip_POC.*.id[count.index]

  tags = merge(
    {
        "Name" = format("%s-${count.index}", var.nat_gateway_name)
    },
    var.app_tags,
    local.module_tags
  )
}