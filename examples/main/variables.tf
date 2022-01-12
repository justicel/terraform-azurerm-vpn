variable "azure_region" {
  description = "Azure region to use."
  type        = string
}

variable "client_name" {
  description = "Client name/account used in naming"
  type        = string
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "stack" {
  description = "Project stack name"
  type        = string
}

variable "on_prem_gateway_subnets" {
  description = "Subnets CIDRs on premises"
  type        = list(string)
}

variable "on_prem_gateway_endpoint" {
  description = "Gateway IP/FQDN on premises"
  type        = string
}

variable "shared_key" {
  description = "IPSec Shared key"
  type        = string
}
