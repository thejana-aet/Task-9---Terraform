data "azurerm_resource_group" "shared" {
  name = var.resource_group_name
  
}







# module "resource_group" {
#   source = "../../modules/resource_group"

#   name     = var.resource_group_name
#   location = var.location
#   tags     = var.tags
# }