variable "public_ports" {
  description = "List of publicly open ports"
  type        = list(number)
  default = [
    1800, # Stratum Server
    8114, # CKB RPC
    8115, # CKB p2p
    9021, # Kafka control center
    9090, # Prometheus
    3000, # Grafana
  ]
}

resource "alicloud_security_group" "node-sg" {
  name        = var.node_sg_name
  vpc_id      = alicloud_vpc.vpc.id
  description = "Security group for node traffic"
}

resource "alicloud_security_group_rule" "node-ssh-in" {
  count             = ! var.bastion_enabled ? 1 : 0
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.node-sg.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "node-bastion-in" {
  count                    = var.bastion_enabled ? 1 : 0
  type                     = "ingress"
  ip_protocol              = "tcp"
  nic_type                 = "intranet"
  policy                   = "accept"
  port_range               = "22/22"
  priority                 = 1
  security_group_id        = alicloud_security_group.node-sg.id
  source_security_group_id = coalesce(join(",", alicloud_security_group.bastion-sg.*.id))
}

resource "alicloud_security_group_rule" "node-app-in" {
  count             = length(var.public_ports)
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "${var.public_ports[count.index]}/${var.public_ports[count.index]}"
  priority          = 1
  security_group_id = alicloud_security_group.node-sg.id
  cidr_ip           = "0.0.0.0/0"
}
