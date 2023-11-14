terraform {
  required_version = ">= 1.3.0"

  cloud {
    organization = "cklewar"
    hostname     = "app.terraform.io"

    workspaces {
      name = "f5-xc-enhanced-firewall-policy-step2-module"
    }
  }

  required_providers {
    restapi = {
      source  = "Mastercard/restapi"
      version = ">= 1.18.2"
    }

    local = ">= 2.2.3"
    null  = ">= 3.1.1"
  }
}