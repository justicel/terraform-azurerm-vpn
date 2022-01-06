locals {
  name_prefix      = var.name_prefix != "" ? replace(var.name_prefix, "/[a-z0-9]$/", "$0-") : ""
  default_basename = "${local.name_prefix}${var.stack}-${var.client_name}-${var.location_short}-${var.environment}"

  #Check if IP or string (FQDN)
  on_prem_gateway_ip   = try(cidrhost(format("%s/32", var.on_prem_gateway_endpoint), 0), null)
  on_prem_gateway_fqdn = local.on_prem_gateway_ip == null ? var.on_prem_gateway_endpoint : null

  default_tags = {
    env   = var.environment
    stack = var.stack
  }
}

