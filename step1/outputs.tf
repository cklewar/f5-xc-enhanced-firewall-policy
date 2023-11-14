output "site_name" {
  value = module.tgw.f5xc_aws_tgw["site_name"]
}

output "workload_vpc_a_id" {
  value = module.workload_vpc_a.aws_vpc["id"]
}

output "workload_vpc_b_id" {
  value = module.workload_vpc_b.aws_vpc["id"]
}

output "efp_name_list" {
  value = local.efp_name_list
}

output "efp_pan_east_west_simple_name" {
  value = module.efp_pan_east_west_simple.enhanced-firewall-policy["name"]
}

output "aws_ec2_instance_nfv_node1_internal_interface_ip" {
  value = module.nfv.nfv["nodes"]["node1"]["instance"] != null ? module.nfv.nfv["nodes"]["node1"]["instance"]["private_ip"] : null
}

output "aws_ec2_instance_nfv_node2_internal_interface_ip" {
  value = module.nfv.nfv["nodes"]["node1"]["instance"] != null ? module.nfv.nfv["nodes"]["node2"]["instance"]["private_ip"] : null
}

output "aws_ec2_instance_nfv_node1_public_dns_name" {
  value = module.nfv.nfv["nodes"]["node1"]["instance"] != null ? module.nfv.nfv["nodes"]["node1"]["instance"]["public_dns"] : null
}

output "aws_ec2_instance_nfv_node2_public_dns_name" {
  value = module.nfv.nfv["nodes"]["node1"]["instance"] != null ? module.nfv.nfv["nodes"]["node2"]["instance"]["public_dns"] : null
}

output "aws_ec2_web_instance_private_ip" {
  value = module.web.aws_ec2_instance["private_ip"]
}

output "aws_ec2_web_instance_public_ip" {
  value = module.web.aws_ec2_instance["public_ip"]
}