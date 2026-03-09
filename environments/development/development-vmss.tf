module "vmss" {
  source = "../../modules/vmss"

  vmss_name           = var.vmss_name
  location            = data.azurerm_resource_group.dev.location
  resource_group_name = data.azurerm_resource_group.dev.name
  vm_size             = var.vm_size
  instance_count      = var.instance_count
  admin_username      = var.admin_username
  ssh_public_key      = var.ssh_public_key
  subnet_id           = module.vnet.private_subnet_ids[0]
  backend_pool_id     = module.app_gateway.backend_pool_id
  acr_login_server    = module.acr.login_server
  acr_username        = module.acr.admin_username
  acr_password        = module.acr.admin_password
  image_name          = var.image_name
  container_name      = var.container_name
  os_disk_size_gb     = var.os_disk_size_gb
  #tags                = var.tags
}