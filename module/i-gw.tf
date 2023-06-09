resource "aws_internet_gateway" "igw_POC" {
  vpc_id = aws_vpc.vpc_POC.id

 tags = merge(
    {
        "Name" = format("%s", var.internet_gateway_name)
    },
    var.app_tags,
    local.module_tags
  )
}
