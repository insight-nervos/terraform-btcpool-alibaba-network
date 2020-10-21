variable "alicloud_region" {
  default = "us-east-1"
}

provider "alicloud" {
  region = var.alicloud_region
}

module "defaults" {
  source   = "../.."
  vpc_name = "example"
  num_azs  = 2

}
