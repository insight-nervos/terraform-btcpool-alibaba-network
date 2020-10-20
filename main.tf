data "alicloud_regions" "current" {
  current = true
}

data "alicloud_zones" "az" {
  network_type = "Vpc"
}
