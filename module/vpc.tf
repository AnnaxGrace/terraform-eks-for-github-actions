##creates VPC
resource "aws_vpc" "vpc_POC" {
  cidr_block = "10.0.0.0/16"

  tags = merge(
    {
      "Name" = format("%s-public", var.vpc_name)
    },
    var.app_tags,
    local.module_tags
  )
}

##creates subnets in determined availability zones
resource "aws_subnet" "subnet_public_POC" {
  count      = var.public_subnet_count
  vpc_id     = aws_vpc.vpc_POC.id
  cidr_block = "10.0.${count.index + var.public_subnet_count}.0/24"
  availability_zone = var.subnet_azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    {
      "Name" = format("%s-public", var.vpc_name)
    },
    var.app_tags,
    local.module_tags
  )
}

resource "aws_subnet" "subnet_private_POC" {
  count      = var.private_subnet_count
  vpc_id     = aws_vpc.vpc_POC.id
  cidr_block = "10.0.${count.index}.0/24"
  availability_zone = var.subnet_azs[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    {
      "Name" = format("%s-private", var.vpc_name),
      "kubernetes.io/cluster/${var.master_cluster_name}" = "shared"
    },
    var.app_tags,
    local.module_tags
  )
}
