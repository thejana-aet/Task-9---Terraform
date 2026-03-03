module "jenkins" {
  source = "../../modules/vm"

  vm_name             = var.jenkins_vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  vm_size             = var.jenkins_vm_size
  admin_username      = var.admin_username
  ssh_public_key      = var.ssh_public_key
  subnet_id           = module.vnet.private_subnet_ids[0]
  associate_public_ip = false
  user_data           = file("${path.module}/user-data/jenkins-userdata.sh")
}

module "pritunl" {
  source = "../../modules/vm"

  vm_name             = var.pritunl_vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  vm_size             = var.pritunl_vm_size
  admin_username      = var.admin_username
  ssh_public_key      = var.ssh_public_key
  subnet_id           = module.vnet.public_subnet_ids[0]
  associate_public_ip = true
  user_data           = file("${path.module}/user-data/pritunl-userdata.sh")  
  
}