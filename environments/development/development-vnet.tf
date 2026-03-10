module "vnet" {
  source = "../../modules/vnet"

  vnet_name           = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  appgw_subnet        = var.appgw_subnet
  appgw_nsg_rules     = var.appgw_nsg_rules
  public_nsg_rules    = var.public_nsg_rules
  private_nsg_rules   = var.private_nsg_rules
  create_public_nics  = false
#   tags                = var.tags
}

# resource "azurerm_network_interface_security_group_association" "public_nsg" {
#   count                     = length(var.public_subnets)
#   network_interface_id      = module.vnet.public_nic_ids[count.index]
#   network_security_group_id = module.vnet.public_nsg_ids[count.index]
# }

resource "azurerm_network_interface_security_group_association" "private_nsg" {
  count                     = length(var.private_subnets)
  network_interface_id      = module.vnet.private_nic_ids[count.index]
  network_security_group_id = module.vnet.private_nsg_ids[count.index]
}