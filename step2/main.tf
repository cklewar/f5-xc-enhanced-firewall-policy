resource "restapi_object" "efp" {
  path          = "/config/namespaces/system/aws_tgw_sites/${data.terraform_remote_state.step1.outputs.site_name}"
  data          = local.payload
  object_id     = data.terraform_remote_state.step1.outputs.site_name
  id_attribute  = data.terraform_remote_state.step1.outputs.site_name
  update_method = "PUT"
}