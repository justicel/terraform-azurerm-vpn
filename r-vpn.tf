resource "azurerm_public_ip" "virtual_gateway_pubip" {
  for_each = toset([for x in range(1, var.vpn_gw_public_ip_number + 1) : tostring(x)])
  name     = "${local.gw_pub_ip_name}-0${each.key}"

  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = var.vpn_gw_public_ip_allocation_method
  sku               = var.vpn_gw_public_ip_sku

  tags = merge(local.default_tags, var.extra_tags)
}

resource "azurerm_virtual_network_gateway" "public_virtual_network_gateway" {
  name = local.vnet_gw_name

  location = var.location

  # Must be in the same rg as VNET
  resource_group_name = coalesce(var.network_resource_group_name, var.resource_group_name)

  type     = var.vpn_gw_type
  vpn_type = var.vpn_gw_routing_type

  active_active = var.vpn_gw_active_active
  enable_bgp    = var.vpn_gw_enable_bgp
  generation    = var.vpn_gw_generation
  sku           = var.vpn_gw_sku

  dynamic "ip_configuration" {
    for_each = toset([for x in range(1, var.vpn_gw_public_ip_number + 1) : tostring(x)])

    content {
      name                 = "${local.vpn_gw_ipconfig_name}-0${ip_configuration.key}"
      public_ip_address_id = azurerm_public_ip.virtual_gateway_pubip[ip_configuration.key].id
      subnet_id            = module.subnet_gateway.subnet_id
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}

resource "azurerm_local_network_gateway" "local_network_gateway" {
  for_each = var.vpn_connections

  name = lookup(each.value, "custom_name", azurecaf_name.local_network_gateway[each.key].result)

  location            = var.location
  resource_group_name = var.resource_group_name

  gateway_address = lookup(each.value, "local_gateway_address", null)
  gateway_fqdn    = lookup(each.value, "local_gateway_fqdn", null)
  address_space   = lookup(each.value, "local_gateway_address_space", [])

  tags = merge(local.default_tags, var.extra_tags)
}

resource "azurerm_virtual_network_gateway_connection" "virtual_network_gateway_connection" {
  for_each = var.vpn_connections

  name                = lookup(each.value, "custom_name", azurecaf_name.vpn_gw_connection[each.key].result)
  location            = var.location
  resource_group_name = var.resource_group_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.public_virtual_network_gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_network_gateway[each.key].id

  shared_key = lookup(each.value, "shared_key", random_password.vpn_ipsec_shared_key[each.key].result)

  tags = merge(local.default_tags, var.extra_tags, each.value.extra_tags)

  dpd_timeout_seconds = lookup(each.value, "dpd_timeout_seconds", null)

  dynamic "ipsec_policy" {
    for_each = length(lookup(each.value, "ipsec_policy", {})) >= 1 ? ["_"] : []
    content {
      dh_group         = each.value.ipsec_policy.dh_group
      ike_encryption   = each.value.ipsec_policy.ike_encryption
      ike_integrity    = each.value.ipsec_policy.ike_integrity
      ipsec_encryption = each.value.ipsec_policy.ipsec_encryption
      ipsec_integrity  = each.value.ipsec_policy.ipsec_integrity
      pfs_group        = each.value.ipsec_policy.pfs_group
      sa_datasize      = each.value.ipsec_policy.sa_datasize
      sa_lifetime      = each.value.ipsec_policy.sa_lifetime
    }
  }
}

resource "random_password" "vpn_ipsec_shared_key" {
  for_each = var.vpn_connections
  length   = 32
  special  = false
}
