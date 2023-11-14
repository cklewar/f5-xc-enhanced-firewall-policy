locals {
  custom_tags = { Feature = var.feature }
  payload     = jsonencode(
    {
      spec = {
        aws_parameters = {
          enable_internet_vip = {},
        },
        vpc_security = {
          active_enhanced_firewall_policies = {
            enhanced_firewall_policies = [
              for name in data.tfe_outputs.step1.values.efp_name_list :
              {
                name      = name
                tenant    = var.data.tenant
                namespace = var.namespace,
              }
            ]
          }
        }
        "vn_config" : {
        },
        "vpc_attachments" : {
          "vpc_list" : [
            {
              "labels" : {},
              "vpc_id" : data.tfe_outputs.step1.values.workload_vpc_a_id
            },
            {
              "labels" : {},
              "vpc_id" : data.tfe_outputs.step1.values.workload_vpc_b_id
            }
          ]
        }
      }
    }
  )
}