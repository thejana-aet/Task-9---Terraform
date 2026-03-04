variable "subscription_id" {
  type    = string
  default = "83c788e7-e715-4617-94ef-5caa0f5d39f4"
}

variable "location" {
  type    = string
  default = "westus2"
}

variable "resource_group_name" {
  type    = string
  default = "Task9-Thejana-Development-RG"
}

variable "vnet_name" {
  type    = string
  default = "dev-vnet"
}

variable "vnet_address_space" {
  type    = string
  default = "10.1.0.0/16"
}

variable "public_subnets" {
  type = list(object({
    name = string
    cidr = string
  }))
  default = [
    {
      name = "dev-public-subnet-az1"
      cidr = "10.1.1.0/24"
    },
    {
      name = "dev-public-subnet-az2"
      cidr = "10.1.3.0/24"
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
      name = "dev-private-subnet-az1"
      cidr = "10.1.2.0/24"
    },
    {
      name = "dev-private-subnet-az2"
      cidr = "10.1.4.0/24"
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
      name                       = "allow-http-inbound"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-https-inbound"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-gateway-manager"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "65200-65535"
      source_address_prefix      = "GatewayManager"
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
      name                       = "allow-http-from-appgw"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "10.1.1.0/24"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-ssh-from-vpn"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.0.0.0/16"
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

variable "acr_name" {
  type    = string
  default = "devhelloworldacr"
}

variable "acr_sku" {
  type    = string
  default = "Basic"
}

variable "vmss_name" {
  type    = string
  default = "dev-vmss"
}

variable "vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "instance_count" {
  type    = number
  default = 2
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "ssh_public_key" {
  type    = string
  default = "ssh-rsa YOUR_PUBLIC_KEY_HERE"
}

variable "image_name" {
  type    = string
  default = "helloworld"
}

variable "container_name" {
  type    = string
  default = "helloworld"
}

variable "os_disk_size_gb" {
  type    = number
  default = 30
}

# variable "tags" {
#   type = map(string)
#   default = {
#     environment = "development"
#     project     = "helloworld"
#     managed_by  = "terraform"
#   }
# }