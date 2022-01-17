resource "azurerm_public_ip" "virtual_gateway_pubip" {
  for_each = toset(range(1, var.vpn_gw_public_ip_number + 1))
  name     = "${local.gw_pub_ip_name}-0{each.key}"

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
    for_each = toset(range(1, var.vpn_gw_public_ip_number + 1))

    content {
      name                 = "${local.vpn_gw_ipconfig_name}-0{each.key}"
      public_ip_address_id = azurerm_public_ip.virtual_gateway_pubip[ip_configuration.key].id
      subnet_id            = module.subnet_gateway.subnet_id
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}

resource "azurerm_local_network_gateway" "local_network_gateway" {
  name = local.local_gw_name

  location            = var.location
  resource_group_name = var.resource_group_name

  gateway_address = local.on_prem_gateway_ip
  gateway_fqdn    = local.on_prem_gateway_fqdn
  address_space   = var.on_prem_gateway_subnets_cidrs

  tags = merge(local.default_tags, var.extra_tags)
}

resource "azurerm_virtual_network_gateway_connection" "azurehub_to_onprem" {
  name                = local.vpn_gw_connection_name
  location            = var.location
  resource_group_name = var.resource_group_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.public_virtual_network_gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_network_gateway.id

  shared_key = var.vpn_ipsec_shared_key

  tags = merge(local.default_tags, var.extra_tags)
}
