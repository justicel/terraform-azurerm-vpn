# Global variables
variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region to use."
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "environment" {
  description = "Project environment."
  type        = string
}

variable "stack" {
  description = "Project stack name."
  type        = string
}

variable "client_name" {
  description = "Client name/account used in naming."
  type        = string
}

# VPN GW mandatory parameters
variable "virtual_network_name" {
  description = "Virtual Network Name where the dedicated VPN Subnet and GW will be created."
  type        = string
}

variable "network_resource_group_name" {
  description = "VNet and Subnet Resource group name. To use only if you need to have a dedicated Resource Group for all VPN GW resources. (set via `resource_group_name` variable.)"
  type        = string
  default     = ""
}

variable "subnet_gateway_cidr" {
  description = "CIDR range for the dedicated Gateway subnet. Must be a range available in the VNet."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Subnet Gateway ID to use if already existing. Must be named `GatewaySubnet`."
  type        = string
  default     = null
}

# VPN GW specific options

variable "vpn_gw_public_ip_number" {
  description = "Number of Public IPs to allocate and associated to the Gateway. By default only 1. Maximum is 3."
  type        = number
  default     = 1
  validation {
    condition     = var.vpn_gw_public_ip_number >= 1 && var.vpn_gw_public_ip_number <= 3
    error_message = "Only one, two or three IPs can be associated to the Gateway."
  }
}

variable "vpn_gw_public_ip_allocation_method" {
  description = "Defines the allocation method for this IP address. Possible values are `Static` or `Dynamic`."
  type        = string
  default     = "Dynamic"
}

variable "vpn_gw_public_ip_sku" {
  description = "The SKU of the Public IP. Accepted values are `Basic` and `Standard`."
  type        = string
  default     = "Basic"
}

variable "vpn_gw_public_ip_zones" {
  description = "Public IP zones to configure."
  type        = list(number)
  default     = [1, 2, 3]
}

variable "vpn_gw_type" {
  description = "The type of the Virtual Network Gateway. Valid options are `Vpn` or `ExpressRoute`. Changing the type forces a new resource to be created"
  type        = string
  default     = "Vpn"
}

variable "vpn_gw_routing_type" {
  description = "The routing type of the Virtual Network Gateway. Valid options are `RouteBased` or `PolicyBased`. Defaults to RouteBased."
  type        = string
  default     = "RouteBased"
}

variable "vpn_gw_active_active" {
  description = "If true, an active-active Virtual Network Gateway will be created. An active-active gateway requires a `HighPerformance` or an `UltraPerformance` SKU. If false, an active-standby gateway will be created."
  default     = false
  type        = bool
}

variable "vpn_gw_generation" {
  description = "Configuration of the generation of the virtual network gateway. Valid options are `Generation1`, `Generation2` or `None`"
  type        = string
  default     = "Generation2"
}

variable "vpn_gw_sku" {
  description = <<EOD
Configuration of the size and capacity of the virtual network gateway.
Valid options are `Basic`, `Standard`, `HighPerformance`, `UltraPerformance`, `ErGw[1-3]AZ`, `VpnGw[1-5]`, `VpnGw[1-5]AZ`, and depend on the type and vpn_type arguments.
A PolicyBased gateway only supports the Basic SKU. Further, the UltraPerformance sku is only supported by an ExpressRoute gateway.
SKU details and list is available at https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways.
EOD
  type        = string
  default     = "VpnGw2AZ"
}

variable "vpn_gw_enable_bgp" {
  description = "If true, BGP (Border Gateway Protocol) will be enabled for this Virtual Network Gateway. Defaults to false."
  default     = false
  type        = bool
}

variable "vpn_connections" {
  description = "List of VPN Connection configurations."
  type = list(object({
    name       = string
    extra_tags = optional(map(string))

    name_suffix          = optional(string)
    local_gw_custom_name = optional(string) # Generated if not set
    vpn_gw_custom_name   = optional(string) # Generated if not set

    local_gateway_address        = optional(string)
    local_gateway_fqdn           = optional(string)
    local_gateway_address_spaces = optional(list(string), []) # CIDR Format

    shared_key          = optional(string) # Generated if not set
    dpd_timeout_seconds = optional(number)

    egress_nat_rule_ids  = optional(list(string))
    ingress_nat_rule_ids = optional(list(string))

    ipsec_policy = optional(object({
      dh_group         = string
      ike_encryption   = string
      ike_integrity    = string
      ipsec_encryption = string
      ipsec_integrity  = string
      pfs_group        = string

      sa_datasize = optional(number)
      sa_lifetime = optional(number)
    }))
  }))
  default = []
}


variable "vpn_aad_client_configuration" {
  description = <<EOD
VPN client configuration using Azure AD authorization, must match this type:
```
map(
  aad_audience          string                # The client id of the Azure VPN application
  aad_issuer            string                # The STS url for your tenant
  aad_tenant            string                # AzureAD Tenant URL
  address_space         list(string)          # The address space out of which IP addresses for vpn clients will be taken
)
```
EOD
  type        = map(any)
  default     = {}
}

variable "additional_routes_to_advertise" {
  description = "Additional routes to advertise"
  default     = []
  type        = list(string)
}
