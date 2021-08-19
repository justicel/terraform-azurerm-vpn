output "vpn_gw_subnet_id" {
  description = "Dedicated subnet id for the GW."
  value       = module.subnet_gateway.subnet_id
}

output "vpn_gw_id" {
  description = "Azure VPN GW id."
  value       = azurerm_virtual_network_gateway.public_virtual_network_gateway.id
}

output "vpn_gw_name" {
  description = "Azure VPN GW name."
  value       = azurerm_virtual_network_gateway.public_virtual_network_gateway.name
}

output "vpn_public_ip_name" {
  description = "Azure VPN GW public IP resource name."
  value       = azurerm_public_ip.virtual_gateway_pubip.name
}

output "vpn_public_ip" {
  description = "Azure VPN GW public IP."
  value       = azurerm_public_ip.virtual_gateway_pubip.ip_address
}

output "vpn_local_gw_name" {
  description = "Azure vnet local GW name."
  value       = azurerm_local_network_gateway.local_network_gateway.name
}

output "vpn_local_gw_id" {
  description = "Azure vnet local GW id."
  value       = azurerm_local_network_gateway.local_network_gateway.id
}

output "vpn_connection_id" {
  description = "The VPN connection id."
  value       = azurerm_virtual_network_gateway_connection.azurehub_to_onprem.id
}

