output "vpn_gw_subnet_id" {
  description = "Dedicated subnet ID for the GW."
  value       = coalesce(var.subnet_id, try(module.subnet_gateway["subnet_gw"].subnet_id, null))
}

output "vpn_gw_id" {
  description = "Azure VPN GW ID."
  value       = azurerm_virtual_network_gateway.public_virtual_network_gateway.id
}

output "vpn_gw_name" {
  description = "Azure VPN GW name."
  value       = azurerm_virtual_network_gateway.public_virtual_network_gateway.name
}

output "vpn_public_ip_name" {
  description = "Azure VPN GW public IP resource name."
  value       = [for pip in azurerm_public_ip.virtual_gateway_pubip : pip.name]
}

output "vpn_public_ip" {
  description = "Azure VPN GW public IP."
  value       = [for pip in azurerm_public_ip.virtual_gateway_pubip : pip.ip_address]
}

output "vpn_local_gateway_names" {
  description = "Azure VNET local Gateway names."
  value       = { for k, v in azurerm_local_network_gateway.local_network_gateway : k => v.name }
}

output "vpn_local_gw_ids" {
  description = "Azure VNET local Gateway IDs."
  value       = { for k, v in azurerm_local_network_gateway.local_network_gateway : k => v.id }
}

output "vpn_connection_ids" {
  description = "The VPN created connections IDs."
  value       = { for k, v in azurerm_virtual_network_gateway_connection.virtual_network_gateway_connection : k => v.id }
}

output "vpn_shared_keys" {
  description = "Shared Keys used for VPN connections."
  value       = { for k, v in var.vpn_connections : k => lookup(v, "shared_key", random_password.vpn_ipsec_shared_key[k].result) }
  sensitive   = true
}
