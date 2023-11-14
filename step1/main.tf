provider "aws" {
  region = var.f5xc_aws_region
  alias  = "default"
}

provider "volterra" {
  api_p12_file = format("%s/%s", var.root_path, var.f5xc_api_p12_file_absolute)
  url          = var.f5xc_api_url
  alias        = "default"
  timeout      = "30s"
}

locals {
  aws_availability_zone = format("%s%s", var.5xc_aws_region, var.f5xc_aws_availability_zone)
  custom_tags           = {
    Owner        = var.owner
    f5xc-tenant  = var.f5xc_tenant
    f5xc-feature = "f5xc-aws-vpc-site"
  }
}

module "workload_vpc_a" {
  source             = "../modules/aws/vpc"
  aws_owner          = var.owner
  aws_region         = var.f5xc_aws_region
  aws_az_name        = format("%s%s", var.f5xc_aws_region, "a")
  aws_vpc_name       = format("%s-%s-%s", var.project_prefix, var.aws_vpc_workload_a_name, var.project_suffix)
  aws_vpc_cidr_block = var.aws_vpc_workload_a_cidr_block
  create_igw         = false
  custom_tags        = local.custom_tags
  providers          = {
    aws = aws.default
  }
}

module "workload_vpc_b" {
  source             = "../modules/aws/vpc"
  aws_owner          = var.owner
  aws_region         = var.f5xc_aws_region
  aws_az_name        = format("%s%s", var.f5xc_aws_region, "a")
  aws_vpc_name       = format("%s-%s-%s", var.project_prefix, var.aws_vpc_workload_b_name, var.project_suffix)
  aws_vpc_cidr_block = var.aws_vpc_workload_b_cidr_block
  create_igw         = false
  custom_tags        = local.custom_tags
  providers          = {
    aws = aws.default
  }
}

module "workload_subnets_a" {
  source          = "../modules/aws/subnet"
  aws_vpc_id      = module.workload_vpc_a.aws_vpc["id"]
  aws_vpc_subnets = [
    {
      name                    = format("%s-%s-%s-private", var.project_suffix, var.aws_vpc_workload_a_name, var.project_suffix)
      owner                   = var.owner
      cidr_block              = var.aws_subnet_workload_a_private_cidr
      custom_tags             = local.custom_tags
      availability_zone       = format("%s%s", var.f5xc_aws_region, "a")
      map_public_ip_on_launch = false
    }
  ]
  providers = {
    aws = aws.default
  }
}

module "workload_subnets_b" {
  source          = "../modules/aws/subnet"
  aws_vpc_id      = module.workload_vpc_b.aws_vpc["id"]
  aws_vpc_subnets = [
    {
      name                    = format("%s-%s-%s-private", var.project_suffix, var.aws_vpc_workload_b_name, var.project_suffix)
      owner                   = var.owner
      cidr_block              = var.aws_subnet_workload_b_private_cidr
      custom_tags             = local.custom_tags
      availability_zone       = format("%s%s", var.f5xc_aws_region, "a")
      map_public_ip_on_launch = false
    }
  ]
  providers = {
    aws = aws.default
  }
}

module "tgw" {
  depends_on                     = []
  source                         = "../modules/f5xc/site/aws/tgw"
  f5xc_tenant                    = var.f5xc_tenant
  f5xc_api_url                   = var.f5xc_api_url
  f5xc_aws_cred                  = var.f5xc_aws_cred
  f5xc_api_token                 = var.f5xc_api_token
  f5xc_namespace                 = var.f5xc_namespace
  f5xc_aws_region                = var.f5xc_aws_region
  f5xc_aws_tgw_name              = local.f5xc_aws_tgw_name
  f5xc_aws_tgw_owner             = var.f5xc_aws_tgw_owner
  f5xc_aws_tgw_primary_ipv4      = "192.168.168.0/21"
  f5xc_aws_vpc_attachment_ids    = [module.workload_vpc_a.aws_vpc["id"], module.workload_vpc_b.aws_vpc["id"]]
  f5xc_aws_tgw_no_worker_nodes   = true
  f5xc_aws_default_ce_sw_version = true
  f5xc_aws_default_ce_os_version = true
  f5xc_aws_tgw_az_nodes          = {
    node0 : {
      f5xc_aws_tgw_workload_subnet = "192.168.168.0/26", f5xc_aws_tgw_inside_subnet = "192.168.168.64/26",
      f5xc_aws_tgw_outside_subnet  = "192.168.168.128/26", f5xc_aws_tgw_az_name = format("%s%s", var.f5xc_aws_region, var.f5xc_aws_az_name)
    }
  }
  custom_tags    = local.custom_tags
  ssh_public_key = file(format("%s/%s", var.root_path, var.ssh_public_key_file_absolute))
  providers      = {
    aws      = aws.default
    volterra = volterra.default
  }
}

module "apply_timeout_workaround" {
  source         = "../modules/utils/timeout"
  depend_on      = module.tgw.f5xc_aws_tgw
  create_timeout = "120s"
  delete_timeout = "180s"
}

module "efp_pan_east_west_simple_vpc" {
  source                        = "../modules/f5xc/enhanced-fw-policy"
  f5xc_namespace                = var.f5xc_namespace
  f5xc_enhanced_fw_policy_name  = format("%s-%s-%s", var.project_prefix, "efp-test", var.project_suffix)
  f5xc_enhanced_fw_policy_rules = [
    {
      metadata = {
        name = "vpc-a-subnet-to-vpc-b-subnet"
      }
      allow                   = true
      source_aws_vpc_ids      = [module.workload_vpc_a.aws_vpc["id"]]
      destination_aws_vpc_ids = [module.workload_vpc_b.aws_vpc["id"]]
    }
  ]
  providers = {
    volterra = volterra.default
  }
}

/*
module "nfv" {
  depends_on                   = [module.apply_timeout_workaround, module.tgw.f5xc_aws_tgw]
  source                       = "../modules/f5xc/nfv/aws"
  f5xc_tenant                  = var.f5xc_tenant
  f5xc_api_url                 = var.f5xc_api_url
  f5xc_nfv_type                = var.f5xc_nfv_type_f5_big_ip_aws_service
  f5xc_nfv_name                = format("%s-%s-efp-%s", var.project_prefix, var.nfv_name, var.project_suffix)
  f5xc_api_token               = var.f5xc_api_token
  f5xc_namespace               = var.f5xc_namespace
  f5xc_nfv_domain_suffix       = var.nfv_domain_suffix
  f5xc_nfv_admin_password      = var.nfv_admin_password
  f5xc_nfv_admin_username      = var.nfv_admin_username
  f5xc_nfv_aws_tgw_site_params = {
    name      = module.tgw.f5xc_aws_tgw["site_name"]
    tenant    = var.f5xc_tenant
    namespace = module.tgw.f5xc_aws_tgw["namespace"]
  }
  f5xc_aws_nfv_nodes = {
    "${var.project_prefix}-${var.nfv_name}-node1-${var.project_suffix}" = {
      aws_az_name          = format("%s%s", var.f5xc_aws_region, "a")
      automatic_prefix     = true
      reserved_mgmt_subnet = false
    }
  }
  f5xc_https_mgmt_advertise_on_internet_default_vip = true
  ssh_public_key                                    = file(var.ssh_public_key_file)
  custom_tags                                       = local.custom_tags_bigip
  providers                                         = {
    aws      = aws.default
    volterra = volterra.default
  }
}*/

/*module "efp_pan_east_west_simple_nfv" {
  source                        = "./modules/f5xc/enhanced-fw-policy"
  f5xc_namespace                = var.f5xc_namespace
  f5xc_enhanced_fw_policy_name  = format("%s-%s-%s", var.project_prefix, "efp-test", var.project_suffix)
  f5xc_enhanced_fw_policy_rules = [
    {
      metadata = {
        name = "vpc-a-subnet-nfv-to-vpc-b-subnet-nfv"
      }
      insert_service = {
        nfv_service = {
          name = module.nfv.nfv["name"]
        }
      }
      source_prefix_list      = var.f5xc_source_prefix_list
      destination_prefix_list = var.f5xc_destination_prefix_list
    }
  ]
  providers = {
    volterra = volterra.default
  }
}*/