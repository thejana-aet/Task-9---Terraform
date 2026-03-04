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