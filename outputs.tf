output "vpn_gw_subnet_id" {
  description = "Dedicated subnet id for the GW."
  value       = "${module.azure-network-subnet-gateway.subnet_ids[0]}"
}

output "vpn_gw_id" {
  description = "Azure VPN GW id."
  value       = "${azurerm_virtual_network_gateway.public_virtual_network_gateway.id}"
}

output "vpn_gw_name" {
  description = "Azure VPN GW name."
  value       = "${azurerm_virtual_network_gateway.public_virtual_network_gateway.name}"
}

output "vpn_connection_id" {
  description = "The VPN connection id."
  value       = "${azurerm_virtual_network_gateway_connection.azure-hub_to_onprem.id}"
}
