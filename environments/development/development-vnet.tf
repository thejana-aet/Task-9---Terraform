module "vnet" {
  source = "../../modules/vnet"

  vnet_name           = var.vnet_name
  location            = var.location
  resource_group_name = module.resource_group.name
  address_space       = var.vnet_address_space
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
#   tags                = var.tags
}

resource "azurerm_network_interface_security_group_association" "public_nsg" {
  count                     = length(var.public_subnets)
  network_interface_id      = module.vnet.public_nic_ids[count.index]
  network_security_group_id = module.vnet.public_nsg_ids[count.index]
}

resource "azurerm_network_interface_security_group_association" "private_nsg" {
  count                     = length(var.private_subnets)
  network_interface_id      = module.vnet.private_nic_ids[count.index]
  network_security_group_id = module.vnet.private_nsg_ids[count.index]
}