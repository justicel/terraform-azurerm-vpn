# Global variables
variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "location" {
  description = "Azure region to use"
}

variable "location_short" {
  description = "Short string for Azure location"
}

variable "environment" {
  description = "Project environment"
}

variable "stack" {
  description = "Project stack name"
}

variable "client_name" {
  description = "Client name/account used in naming"
  type        = "string"
}

variable "name_prefix" {
  description = "Optional prefix for VPN Gateway name"
  type        = "string"
  default     = ""
}

variable "custom_name" {
  description = "Custom VPN Gateway name, generated if not set"
  default     = ""
}

variable "extra_tags" {
  description = "Additional tags to associate with your VPN Gateway."
  type        = "map"
  default     = {}
}

# VPN GW mandatory parameters
variable "virtual_network_name" {
  description = "Virtual Network Name where the dedicated Subnet and GW will be created."
  type        = "string"
}

variable "network_resource_group_name" {
  description = "Vnet and subnet Resource group name. To use only if you need to have a dedicated Resource Group for all VPN GW resources. (set via `resource_group_name` var.)"
  type        = "string"
  default     = ""
}

variable "subnet_gateway_cidr" {
  description = "CIDR range for the dedicated Gateway subnet. Must be a range available in the Vnet."
  type        = "string"
}

variable "on_prem_gateway_ip" {
  description = "On-premise Gateway endpoint IP to connect Azure with."
  type        = "string"
}

variable "on_prem_gateway_subnets_cidrs" {
  description = "On-premise subnets list to route from the Hub. (list of strings)"
  type        = "list"
}

variable "vpn_ipsec_shared_key" {
  description = "The Shared key between both On-premise Gateway and Azure GW for VPN IPsec connection."
  type        = "string"
}

# VPN GW specific options
variable "vpn_gw_public_ip_custom_name" {
  description = "VPN GW resource custom name"
  type        = "string"
  default     = ""
}

variable "vpn_gw_public_ip_allocation_method" {
  description = "Defines the allocation method for this IP address. Possible values are `Static` or `Dynamic`."
  type        = "string"
  default     = "Dynamic"
}

variable "vpn_gw_public_ip_sku" {
  description = "The SKU of the Public IP. Accepted values are `Basic` and `Standard`."
  type        = "string"
  default     = "Basic"
}

variable "vpn_gw_type" {
  description = "The type of the Virtual Network Gateway. Valid options are `Vpn` or `ExpressRoute`. Changing the type forces a new resource to be created"
  type        = "string"
  default     = "Vpn"
}

variable "vpn_gw_routing_type" {
  description = "The routing type of the Virtual Network Gateway. Valid options are `RouteBased` or `PolicyBased`. Defaults to RouteBased."
  type        = "string"
  default     = "RouteBased"
}

variable "vpn_gw_active_active" {
  description = " If true, an active-active Virtual Network Gateway will be created. An active-active gateway requires a HighPerformance or an UltraPerformance sku. If false, an active-standby gateway will be created. Defaults to false."
  default     = "false"
}

variable "vpn_gw_sku" {
  description = "Configuration of the size and capacity of the virtual network gateway. Valid options are Basic, Standard, HighPerformance, UltraPerformance, ErGw1AZ, ErGw2AZ, ErGw3AZ, VpnGw1, VpnGw2, VpnGw3, VpnGw1AZ, VpnGw2AZ, and VpnGw3AZ and depend on the type and vpn_type arguments. A PolicyBased gateway only supports the Basic sku. Further, the UltraPerformance sku is only supported by an ExpressRoute gateway."
  default     = "VpnGw1"
}

variable "vpn_gw_enable_bgp" {
  description = "If true, BGP (Border Gateway Protocol) will be enabled for this Virtual Network Gateway. Defaults to false."
  default     = "false"
}

variable "vpn_gw_connection_name" {
  description = "Custom name for VPN Gateway connection resource."
  default     = "azure_hub_to_on-prem_resources"
}
