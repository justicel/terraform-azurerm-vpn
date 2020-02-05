resource "azurerm_public_ip" "virtual_gateway_pubip" {
  name = coalesce(
    var.vpn_gw_public_ip_custom_name,
    "pubgateway-${coalesce(var.custom_name, local.default_basename)}-pubip",
  )
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = var.vpn_gw_public_ip_allocation_method
  sku               = var.vpn_gw_public_ip_sku

  tags = merge(local.default_tags, var.extra_tags)
}

resource "azurerm_virtual_network_gateway" "public_virtual_network_gateway" {
  name     = "pub-${coalesce(var.custom_name, local.default_basename)}-vng"
  location = var.location
  // Must be in the same rg as VNET
  resource_group_name = coalesce(var.network_resource_group_name, var.resource_group_name)

  type     = var.vpn_gw_type
  vpn_type = var.vpn_gw_routing_type

  active_active = var.vpn_gw_active_active
  enable_bgp    = var.vpn_gw_enable_bgp
  sku           = var.vpn_gw_sku

  ip_configuration {
    name                 = coalesce(var.vpn_gw_ipconfig_custom_name, "vnetGatewayIPConfig")
    public_ip_address_id = azurerm_public_ip.virtual_gateway_pubip.id
    subnet_id            = module.azure-network-subnet-gateway.subnet_ids[0]
  }

  tags = merge(local.default_tags, var.extra_tags)
}

resource "azurerm_local_network_gateway" "local_network_gateway" {
  name                = "local-${coalesce(var.custom_name, local.default_basename)}-vng"
  location            = var.location
  resource_group_name = var.resource_group_name

  gateway_address = var.on_prem_gateway_ip
  address_space   = var.on_prem_gateway_subnets_cidrs

  tags = merge(local.default_tags, var.extra_tags)
}

resource "azurerm_virtual_network_gateway_connection" "azure-hub_to_onprem" {
  name                = var.vpn_gw_connection_name
  location            = var.location
  resource_group_name = var.resource_group_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.public_virtual_network_gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_network_gateway.id

  shared_key = var.vpn_ipsec_shared_key

  tags = merge(local.default_tags, var.extra_tags)
}

