variable "location" {
  type    = string
  default = "westus2"
}

variable "resource_group_name" {
  type    = string
  default = "Task9-Thejana-Shared-RG"
}

variable "subscription_id" {
  type    = string
  default = "83c788e7-e715-4617-94ef-5caa0f5d39f4"
}

variable "vnet_name" {
  type    = string
  default = "Task9-Thejana-Shared-Vnet"
}

variable "vnet_address_space" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type = list(object({
    name = string
    cidr = string
  }))
  default = [
    {
      name = "Task9-Thejana-Shared-public-subnet"
      cidr = "10.0.1.0/24"
    }
  ]
}

variable "private_subnets" {
  type = list(object({
    name = string
    cidr = string
  }))
  default = [
    {
      name = "Task9-Thejana-Shared-private-subnet"
      cidr = "10.0.2.0/24"
    }
  ]
}

variable "public_nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "allow-vpn-udp"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "18857"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-pritunl-web"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-ssh-inbound"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-all-outbound"
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

variable "private_nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "allow-ssh-from-vpn"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-jenkins-from-vpn"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "8080"
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "*"
    },
    {
      name                       = "deny-all-inbound"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-all-outbound"
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

# variable "acr_name" {
#   type    = string
#   default = "myprojectacr"
# }

variable "jenkins_vm_name" {
  type    = string
  default = "Task9-Thejana-Shared-Jenkins-vm"
}

variable "jenkins_vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "pritunl_vm_name" {
  type    = string
  default = "Task9-Thejana-Shared-Pritunl-vm"
}

variable "pritunl_vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "os_disk_size_gb" {
  type    = number
  default = 30
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "ssh_public_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCoorGdgB7sDa9n2wNSPkMMLa7Bo+AmAIfCWLHeJ/X/379rBgVXnM6ALeOAkiycnsiQcTvW3jVUjStrX3/TdzXtNsBeal71N2eQF5dkP4vt/JY0vphc69VEhwl4l44V8oxzPPL9HcToDjanQDDeC6dBQ0PmN3rn032ypr0IbJgqVKvcADZm6DTaRRkhPzFGxxRykYR2vrnwXuaSpnI8ko7mkMXsiotDV5IikUnkhj3iDhuvjMs08ozHjQVm0J6NCc/cyRUsSahrR05YC4jxtNUfo2ALX4ZkalmkTwOUtHkRb/VIl525q0zvSKdITs2Ain9B2glfTusA0MIVLcaS+0Au7BDacgka/mTcmhIA+HRZ9xQFqrDsSjBwdcQTt4bvASQs1Oxd3PCOYlcBLeQ+nz2ou8gu6/Jhn8yBrt/I0UeV4CH+V/f+6F1Q94PzLwDKHI2hRst1uBMI8gbKnk4LF477crDZjPMwyi0zqa2oKcI0SFfepGRQiY3d7MnUvWV/Rz8xdSfI1EKLXjO4dypjDPM4XJX5QddsJR8AdLITR+MsvCeqbiBrA1T8qKNHCo7OEmRp5IL5L37mbun7o9ifWaW+o6J5wacIGoHxzOQGWkTIYAMzzAq22Kf2OB1a8waLqEMfTk0D+gHdbZxA5O+tIGF8+JIWsQkF3wGVyLcJ3EF+4w== azuread\thejanagalagama@THEJANA-GALAGAMA"
}

# variable "tags" {
#   type = map(string)
#   default = {
#     environment = "shared"
#     project     = "helloworld"
#     managed_by  = "terraform"
#   }
# }