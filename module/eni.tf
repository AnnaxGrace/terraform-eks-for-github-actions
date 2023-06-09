resource "aws_network_interface" "eni_POC" {
  count     = var.public_subnet_count
  subnet_id = aws_subnet.subnet_public_POC.*.id[count.index]

   tags = merge(
    {
        "Name" = format("%s-${count.index}", var.eni_name)
    },
    var.app_tags,
    local.module_tags
  )
}
