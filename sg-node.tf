resource "alicloud_security_group" "node-sg" {
  name        = var.node_sg_name
  vpc_id      = alicloud_vpc.vpc.id
  description = "Security group for node traffic"
}

resource "alicloud_security_group_rule" "ssh-in" {
  count             = ! var.bastion_enabled ? 1 : 0
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "internet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.node-sg.*.id
  cidr_ip           = "0.0.0.0/0"
}