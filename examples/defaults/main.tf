provider "alicloud" {
  region = var.alicloud_region
}

module "defaults" {
  source   = "../.."
  vpc_name = var.vpc_name
  num_azs  = 2
}
