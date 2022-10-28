# Unreleased

Breaking
  * AZ-840: Require Terraform 1.3+
  * AZ-886: Rework module code, minimum AzureRM version to `v3.22`
  * AZ-886: Default VPN is now `Generation2` with `VpnGw2AZ` multi AZ SKU

Added
  * AZ-884: Add NAT rules link options

# v6.0.0 - 2022-10-21

Changed
  * AZ-844: Bump `subnet` module to latest version

# v5.3.0 - 2022-06-17

Added
  * AZ-771: Allow usage of an existing subnet gateway
  * AZ-774: Add second IP by default for active-active VPN to match requirements

Fixed
  * AZ-771: Add a try function for the subnet gateway output

# v5.2.0 - 2022-05-13

Breaking
  * AZ-666: Option to select which generation of VPN to use
  * AZ-686: Add multi connections and public ips

Changed
  * AZ-666: Upgrade provider to `>= 2.38.0` [#9330](https://github.com/hashicorp/terraform-provider-azurerm/pull/9330)

# v5.1.0 - 2022-04-15

Added
  * AZ-615: Add an option to enable or disable default tags

# v5.0.0 - 2022-01-13

Breaking
  * AZ-515: Option to use Azure CAF naming provider to name resources
  * AZ-515: Require Terraform 0.13+

# v4.2.0 - 2022-01-12

Breaking
  * AZ-651: Change `on_prem_gateway_ip` parameter with a more generic one: `on_prem_gateway_endpoint` (which can be an IP or a FQDN)
  * AZ-651: Upgrade AzureRM provider minimum version to `v2.34.0`

Changed
  * AZ-572: Revamp examples and improve CI

# v4.1.0/v3.2.0 - 2021-08-24

Updated
  * AZ-495: Compatible with terraform `v0.15+/v1.0+`, README update
  * AZ-530: Module cleanup, linter errors fix
  * AZ-532: Revamp README with latest `terraform-docs` tool

# v3.1.0/v4.0.0 - 2021-02-26

Updated
  * AZ-273: Module now compatible terraform `v0.13+` and `v0.14+`

# v3.0.0 - 2020-07-09

Breaking
  * AZ-198: Upgrade module to Azurerm 2.x

Changed
  * AZ-209: Update CI with Gitlab template

# v2.0.0 - 2020-02-05

Breaking
  * AZ-94: Upgrade module to terraform v0.12

Added
  * AZ-118: Add NOTICE and LICENSE file + update README with badges
  * AZ-119: Revamp to match Terraform/Hashicorp best practices
  * AZ-175: Public release + Fix bug when using dedicated RG

# v0.1.1 - 2019-08-23

Updated
  * AZ-91: Allow custom name for GW IP tf resource

# v0.1.0 - 2019-07-19

Added
  * AZ-91: First version
