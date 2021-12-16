locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  vnet_gw_name           = coalesce(var.custom_name, azurecaf_name.vnet_gw.result)
  local_gw_name          = coalesce(var.custom_name, azurecaf_name.local_gw.result)
  vpn_gw_connection_name = coalesce(var.vpn_gw_connection_name, var.use_caf_naming ? azurecaf_name.vpn_gw_connection.result : "azure_hub_to_on-prem_resources")
  vpn_gw_ipconfig_name   = coalesce(var.vpn_gw_ipconfig_custom_name, "vnetGatewayIPConfig")
  gw_pub_ip_name         = coalesce(var.vpn_gw_public_ip_custom_name, azurecaf_name.gw_pub_ip.result)
}
