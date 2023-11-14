provider "restapi" {
  uri     = var.f5xc_api_url
  debug   = true
  headers = {
    Accept                      = "application/json"
    Content-Type                = "application/json"
    Authorization               = format("APIToken %s", var.f5xc_api_token)
    x-volterra-apigw-tenant     = data.tfe_outputs.step1.values.tenant
    Access-Control-Allow-Origin = "*"
  }
  create_method         = "PUT"
  update_method         = "PUT"
  destroy_method        = "PUT"
  create_returns_object = true
}

provider "tfe" {}