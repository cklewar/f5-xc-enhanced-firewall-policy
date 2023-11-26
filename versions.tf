terraform {
  required_version = ">= 1.3.0"
  cloud {
    organization = "cklewar"
    hostname     = "app.terraform.io"

    workspaces {
      name = "f5-xc-enhanced-firewall-policy-module"
    }
  }
  
  required_providers {
    volterra = {
      source = "volterraedge/volterra"
      version = "= 0.11.24"
    }
    tfe = {
      source = "hashicorp/tfe"
      version = ">= 0.50.0"
    }
    local = ">= 2.2.3"
    null = ">= 3.1.1"
  }
}