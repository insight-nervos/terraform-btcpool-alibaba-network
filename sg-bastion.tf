resource "alicloud_security_group" "bastion-sg" {
  name        = var.bastion_sg_name
  vpc_id      = alicloud_vpc.vpc.id
  description = "Security group for bastion traffic"
}

resource "alicloud_security_group_rule" "ssh-in" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.bastion-sg.id
  cidr_ip           = "0.0.0.0/0"
}
