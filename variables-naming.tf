# Generic naming variables
variable "name_prefix" {
  description = "Optional prefix for the generated name"
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Optional suffix for the generated name"
  type        = string
  default     = ""
}

variable "use_caf_naming" {
  description = "Use the Azure CAF naming provider to generate default resource name. `custom_name` override this if set. Legacy default name is used if this is set to `false`."
  type        = bool
  default     = true
}

# Custom naming override
variable "vpn_gateway_custom_name" {
  description = "Custom VPN Gateway name, generated if not set"
  type        = string
  default     = ""
}

variable "vpn_gw_ipconfig_custom_name" {
  description = "VPN GW IP Config resource custom name"
  type        = string
  default     = ""
}

variable "vpn_gw_public_ip_custom_name" {
  description = "VPN GW Public IP resource custom name"
  type        = string
  default     = ""
}
