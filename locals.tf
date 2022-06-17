locals {
  vpn_gw_public_ip_number = var.vpn_gw_active_active && var.vpn_gw_public_ip_number < 2 ? 2 : var.vpn_gw_public_ip_number
}