output "site_name" {
  value = module.tgw.f5xc_aws_tgw["site_name"]
}

output "tenant" {
  value = var.f5xc_tenant
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
  value = module.efp_pan_east_west_simple_vpc.enhanced_firewall_policy["name"]
}