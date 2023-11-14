provider "restapi" {
  uri     = var.data.api_url
  debug   = true
  headers = {
    Accept                      = "application/json"
    Content-Type                = "application/json"
    Authorization               = format("APIToken %s", var.f5xc_api_token)
    x-volterra-apigw-tenant     = var.data.tenant
    Access-Control-Allow-Origin = "*"
  }
  create_method         = "PUT"
  update_method         = "PUT"
  destroy_method        = "PUT"
  create_returns_object = true
}