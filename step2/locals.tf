locals {
  custom_tags = { Feature = var.feature }
  payload     = jsonencode(
    {
      active_enhanced_firewall_policies = {
        enhanced_firewall_policies = [
          for name in data.tfe_outputs.step1.values.efp_name_list :
          {
            name      = name
            tenant    = data.tfe_outputs.step1.values.tenant
            namespace = var.namespace,
          }
        ]
      }
    }
  )
}