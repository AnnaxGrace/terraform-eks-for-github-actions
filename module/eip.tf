resource "aws_eip" "eip_POC" {
  count      = var.private_subnet_count
  vpc        = true
  depends_on = [aws_internet_gateway.igw_POC]

  tags = merge(
    {
      "Name" = format("%s", var.eip_name)
    },
    var.app_tags,
    local.module_tags
  )
}
