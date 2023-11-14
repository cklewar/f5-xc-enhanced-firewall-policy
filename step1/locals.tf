locals {
  f5xc_aws_tgw_name = format("%s-%s-efp-%s", var.project_prefix, var.f5xc_aws_tgw_name, var.project_suffix)
  custom_tags_vpc = {
    f5xc-tenant  = var.f5xc_tenant
    f5xc-feature = "aws-vpc-efp"
  }
  efp_name_list            = [
    module.efp_pan_east_west_simple_vpc.enhanced_firewall_policy["name"],
  ]
}