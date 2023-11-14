variable "project_prefix" {
  type        = string
  description = "prefix string put in front of string"
}

variable "project_suffix" {
  type        = string
  description = "prefix string put at the end of string"
}


variable "f5xc_api_token" {
  type = string
}

variable "namespace" {
  type    = string
  default = "system"
}

variable "feature" {
  type    = string
  default = "F5XC Enhanced Firewall Policy"
}

variable "data" {
  type = object({
    operating_system_version    = string
    volterra_software_version   = string
    api_url                     = string
    api_p12_file                = string
    tenant                      = string
    tgw_aws_creds               = string
    nfv_domain_suffix           = string
    tgw_vpc_attach_label_deploy = string
    owner_tag                   = string
  })
}

variable "aws_region" {
  type        = string
  description = "AWS region name"
  default     = "us-west-2"
}

variable "root_path" {
  type = string
}