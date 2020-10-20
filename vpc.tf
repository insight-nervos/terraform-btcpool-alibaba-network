locals {
  //    Logic for AZs is azs variable > az_num variable > max azs for region
  az_num = chunklist(data.alicloud_zones.az.ids, var.num_azs)[0]
  az_max = data.alicloud_zones.az.ids
  azs    = coalescelist(var.azs, local.az_num, local.az_max)

  num_azs = length(local.azs)
  //  TODO: If making additional subnets, this will change
  subnet_num   = 2
  subnet_count = local.subnet_num * local.num_azs

  subnet_bits = ceil(log(local.subnet_count, 2))

  public_subnets = [for subnet_num in range(local.num_azs) : cidrsubnet(
    var.cidr,
    local.subnet_bits,
  subnet_num)]

  private_subnets = [for subnet_num in range(local.num_azs) : cidrsubnet(
    var.cidr,
    local.subnet_bits,
    local.num_azs + subnet_num,
  )]
}

resource "alicloud_vpc" "vpc" {
  name       = var.vpc_name
  cidr_block = var.cidr
}

resource "alicloud_vswitch" "public" {
  count             = length(local.public_subnets)
  vpc_id            = alicloud_vpc.vpc.id
  cidr_block        = local.public_subnets[count.index]
  availability_zone = element(local.azs, count.index)
  name              = "public-${count.index}"
}

resource "alicloud_vswitch" "private" {
  count             = length(local.private_subnets)
  vpc_id            = alicloud_vpc.vpc.id
  cidr_block        = local.private_subnets[count.index]
  availability_zone = element(local.azs, count.index)
  name              = "private-${count.index}"
}