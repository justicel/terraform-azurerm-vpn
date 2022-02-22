resource "azurecaf_name" "vnet_gw" {
  name          = var.stack
  resource_type = "azurerm_virtual_network_gateway"
  prefixes      = compact([var.use_caf_naming ? null : "pub", var.name_prefix == "" ? null : local.name_prefix])
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "vng"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "local_network_gateway" {
  for_each = var.vpn_connections

  name          = var.stack
  resource_type = "azurerm_local_network_gateway"
  prefixes      = compact([var.use_caf_naming ? null : "local", var.name_prefix == "" ? null : local.name_prefix])
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, lookup(each.value, "name_suffix", ""), var.use_caf_naming ? "" : "vng"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "vpn_gw_connection" {
  for_each = var.vpn_connections

  name          = var.stack
  resource_type = "azurerm_vpn_gateway_connection"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, lookup(each.value, "name_suffix", "")])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

resource "azurecaf_name" "gw_pub_ip" {
  name          = var.stack
  resource_type = "azurerm_public_ip"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "pubip"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}
