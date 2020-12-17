variable "public_ports" {
  description = "List of publicly open ports"
  type        = list(number)
  default = [
    22,
    1800, # Stratum Server
    8114, # CKB RPC
    8115, # CKB p2p
    9021, # Kafka control center
    9090, # Prometheus
    3000, # Grafana
  ]
}

resource "alicloud_security_group" "bastion-sg" {
  count       = var.bastion_enabled ? 1 : 0
  name        = var.bastion_sg_name
  vpc_id      = alicloud_vpc.vpc.id
  description = "Security group for bastion traffic"
}

resource "alicloud_security_group_rule" "bastion-ssh-in" {
  count             = var.bastion_enabled ? length(var.public_ports) : 0
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "internet"
  policy            = "accept"
  port_range        = "${count.index}/${count.index}"
  priority          = 1
  security_group_id = alicloud_security_group.bastion-sg.*.id
  cidr_ip           = "0.0.0.0/0"
}
