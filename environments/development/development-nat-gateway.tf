module "nat_gateway_az1" {
  source = "../../modules/nat-gateway"

  name                = "dev-nat-gateway-az1"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.dev.name
  subnet_id           = module.vnet.public_subnet_ids[0]
#   tags                = var.tags
}

module "nat_gateway_az2" {
  source = "../../modules/nat-gateway"

  name                = "dev-nat-gateway-az2"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.dev.name
  subnet_id           = module.vnet.public_subnet_ids[1]
#   tags                = var.tags
}