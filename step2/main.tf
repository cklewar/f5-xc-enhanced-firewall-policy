module "update" {
  source              = "../modules/utils/update"
  del_key             = ""
  merge_key           = "tgw_security"
  merge_data          = local.payload
  f5xc_tenant         = var.f5xc_tenant
  f5xc_api_url        = var.f5xc_api_url
  f5xc_namespace      = var.namespace
  f5xc_api_token      = var.f5xc_api_token
  f5xc_api_get_uri    = "config/namespaces/system/aws_tgw_sites/${data.tfe_outputs.step1.values.site_name}"
  f5xc_api_update_uri = "config/namespaces/system/aws_tgw_sites/${data.tfe_outputs.step1.values.site_name}"
}

output "response" {
  value = module.update.*.data
}