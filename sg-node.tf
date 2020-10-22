resource "alicloud_security_group" "node-sg" {
  name        = var.node_sg_name
  vpc_id      = alicloud_vpc.vpc.id
  description = "Security group for node traffic"
}