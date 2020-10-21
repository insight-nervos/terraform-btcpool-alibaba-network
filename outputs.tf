#####
# VPC
#####

output "vpc_id" {
  value = alicloud_vpc.vpc.id
}

output "private_vswitch_ids" {
  value = alicloud_vswitch.private.*.id
}

output "public_vswitch_ids" {
  value = alicloud_vswitch.public.*.id
}

#####
# SGs
#####
output "bastion_security_group_id" {
  value = alicloud_security_group.bastion-sg.*.id
}