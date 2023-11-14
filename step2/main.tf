resource "restapi_object" "efp" {
  path          = "/config/namespaces/system/aws_tgw_sites/${data.tfe_outputs.step1.values.site_name}"
  data          = local.payload
  object_id     = data.tfe_outputs.step1.values.site_name
  id_attribute  = data.tfe_outputs.step1.values.site_name
  update_method = "PUT"
}