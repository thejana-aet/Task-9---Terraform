module "vnet" {
  source = "../../modules/vnet"

  vnet_name           = var.vnet_name
  location            = data.azurerm_resource_group.shared.location
  resource_group_name = data.azurerm_resource_group.shared.name
  address_space       = var.vnet_address_space
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  public_nsg_rules    = var.public_nsg_rules
  private_nsg_rules   = var.private_nsg_rules
  create_public_nics  = true
#   tags                = var.tags
}


# Attach NSG directly to Pritunl NIC
resource "azurerm_network_interface_security_group_association" "pritunl_nsg" {
  network_interface_id      = module.vnet.public_nic_ids[0]
  network_security_group_id = module.vnet.public_nsg_ids[0]
}

# Attach NSG directly to Jenkins NIC
resource "azurerm_network_interface_security_group_association" "jenkins_nsg" {
  network_interface_id      = module.vnet.private_nic_ids[0]
  network_security_group_id = module.vnet.private_nsg_ids[0]
}