locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  vnet_gw_name         = coalesce(var.custom_name, azurecaf_name.vnet_gw.result)
  vpn_gw_ipconfig_name = coalesce(var.vpn_gw_ipconfig_custom_name, "vnetGatewayIPConfig")
  gw_pub_ip_name       = coalesce(var.vpn_gw_public_ip_custom_name, azurecaf_name.gw_pub_ip.result)
}
