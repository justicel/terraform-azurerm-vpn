module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "azure_network_vnet" {
  source  = "claranet/vnet/azurerm"
  version = "x.x.x"

  environment    = var.environment
  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name
  vnet_cidr           = ["10.10.1.0/16"]
}

module "vpn_gw" {
  source  = "claranet/vpn/azurerm"
  version = "x.x.x"

  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack
  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name

  virtual_network_name = module.azure_network_vnet.virtual_network_name
  subnet_gateway_cidr  = "10.10.1.0/25"

  vpn_connections = [
    {
      name                         = "azure_to_claranet"
      name_suffix                  = "claranet"
      extra_tags                   = { to = "claranet" }
      local_gateway_address        = "89.185.1.1"
      local_gateway_address_spaces = ["89.185.1.1/32"]
    }
  ]

  extra_tags = {
    foo = "bar"
  }
}
