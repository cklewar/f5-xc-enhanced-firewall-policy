variable "project_prefix" {
  type        = string
  description = "prefix string put in front of string"
  default     = "f5xc"
}

variable "project_suffix" {
  type        = string
  description = "prefix string put at the end of string"
  default     = "1"
}

variable "root_path" {
  type = string
}

variable "f5xc_aws_tgw_owner" {
  type    = string
  default = "c.klewar@ves.io"
}

variable "f5xc_api_p12_file_absolute" {
  type = string
}

variable "f5xc_api_url" {
  type = string
}

variable "f5xc_api_token" {
  type = string
}

variable "f5xc_api_cert" {
  type    = string
  default = ""
}

variable "f5xc_api_key" {
  type    = string
  default = ""
}

variable "f5xc_api_ca_cert" {
  type    = string
  default = ""
}

variable "f5xc_tenant" {
  type = string
}

variable "f5xc_namespace" {
  type    = string
  default = "system"
}

variable "f5xc_aws_cred" {
  type    = string
  default = "ck-aws-01"
}

variable "f5xc_aws_tgw_name" {
  type        = string
  description = "AWS TGW name"
  default     = "tgw-nfv"
}

variable "f5xc_aws_region" {
  type        = string
  description = "AWS region name"
  default     = "us-west-2"
}

variable "f5xc_aws_az_name" {
  type        = string
  description = "AWS availability zone name"
  default     = "a"
}

variable "nfv_admin_username" {
  type        = string
  description = "NFV admin user name"
}

variable "nfv_admin_password" {
  type        = string
  description = "NFC admin user password"
}

variable "nfv_name" {
  type        = string
  description = "NFV name"
  default     = "bigip"
}

variable "nfv_domain_suffix" {
  type    = string
  default = "adn-prod.helloclouds.app"
}

variable "f5xc_nfv_type_f5_big_ip_aws_service" {
  type    = string
  default = "f5_big_ip_aws_service"
}

variable "f5xc_source_prefix_list" {
  type    = list(string)
  default = ["192.168.0.0/24", "192.168.1.0/24"]
}

variable "f5xc_destination_prefix_list" {
  type    = list(string)
  default = ["172.16.24.0/24", "172.16.25.0/24"]
}

variable "ssh_public_key_file_absolute" {
  type = string
}

variable "f5xc_aws_availability_zone" {
  type    = string
  default = "a"
}

variable "f5xc_aws_vpc_owner" {
  type    = string
  default = "c.klewar@ves.io"
}

variable "owner" {
  type    = string
  default = "c.klewar@f5.com"
}

variable "aws_vpc_workload_a_name" {
  type        = string
  description = "Name for workload vpc a"
  default     = "vpc-workload-a"
}

variable "aws_vpc_workload_b_name" {
  type        = string
  description = "Name for workload vpc b"
  default     = "vpc-workload-b"
}

variable "aws_vpc_workload_a_cidr_block" {
  type        = string
  description = "vpc cidr block for workload vpc a"
  default     = "172.16.28.0/22"
}

variable "aws_vpc_workload_b_cidr_block" {
  type        = string
  description = "vpc cidr block for workload vpc b"
  default     = "172.16.32.0/22"
}

variable "aws_subnet_workload_a_private_cidr" {
  type        = string
  description = "Workload A private net subnet"
  default     = "172.16.29.0/24"
}

variable "aws_subnet_workload_b_private_cidr" {
  type        = string
  description = "Workload B private net subnet"
  default     = "172.16.33.0/24"
}