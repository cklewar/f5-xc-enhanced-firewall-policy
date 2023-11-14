variable "f5xc_api_url" {
  type = string
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

variable "aws_region" {
  type        = string
  description = "AWS region name"
  default     = "us-west-2"
}