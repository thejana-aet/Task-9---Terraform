module "acr" {
  source = "../../modules/acr"

  acr_name            = var.acr_name
  resource_group_name = data.azurerm_resource_group.dev.name
  location            = data.azurerm_resource_group.dev.location
  sku                 = var.acr_sku
  #tags                = var.tags
}