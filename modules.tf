module "azure-network-subnet-gateway" {
  source  = "claranet/subnet/azurerm"
  version = "2.0.1"

  environment    = var.environment
  location_short = var.location_short
  client_name    = var.client_name
  stack          = var.stack

  resource_group_name  = coalesce(var.network_resource_group_name, var.resource_group_name)
  virtual_network_name = var.virtual_network_name

  subnet_cidr_list = [var.subnet_gateway_cidr]

  # Fixed name, imposed by Azure
  custom_subnet_names = ["GatewaySubnet"]

  # No NSG because the GW needs to generates its own rules
  network_security_group_ids = []

  # No RTB because the GW needs to generates its own routes and propagate them
  route_table_ids = []
}

