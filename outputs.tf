#####
# SGs
#####
output "bastion_security_group_id" {
  value = alicloud_security_group.bastion-sg.id
}