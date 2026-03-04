module "app_gateway" {
  source = "../../modules/app-gateway"

  name                = "dev-app-gateway"
  location            = data.azurerm_resource_group.dev.location
  resource_group_name = data.azurerm_resource_group.dev.name
  subnet_id           = module.vnet.public_subnet_ids[0]
  #tags                = var.tags
}