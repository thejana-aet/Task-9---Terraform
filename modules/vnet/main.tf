resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.address_space]

  tags = var.tags
}

resource "azurerm_subnet" "public" {
  count                = length(var.public_subnets)
  name                 = var.public_subnets[count.index].name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.public_subnets[count.index].cidr]
}

resource "azurerm_subnet" "private" {
  count                = length(var.private_subnets)
  name                 = var.private_subnets[count.index].name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.private_subnets[count.index].cidr]
}

# Public IPs for public subnet NICs
resource "azurerm_public_ip" "public" {
  count               = length(var.public_subnets)
  name                = "${var.public_subnets[count.index].name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

# NSG for public subnets
resource "azurerm_network_security_group" "public" {
  count               = length(var.public_subnets)
  name                = "${var.public_subnets[count.index].name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.public_nsg_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  tags = var.tags
}

# NSG for private subnets
resource "azurerm_network_security_group" "private" {
  count               = length(var.private_subnets)
  name                = "${var.private_subnets[count.index].name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.private_nsg_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  tags = var.tags
}

# Public subnet NSG associations
resource "azurerm_subnet_network_security_group_association" "public" {
  count                     = length(var.public_subnets)
  subnet_id                 = azurerm_subnet.public[count.index].id
  network_security_group_id = azurerm_network_security_group.public[count.index].id
}

# Private subnet NSG associations
resource "azurerm_subnet_network_security_group_association" "private" {
  count                     = length(var.private_subnets)
  subnet_id                 = azurerm_subnet.private[count.index].id
  network_security_group_id = azurerm_network_security_group.private[count.index].id
}

# Network interfaces for public subnets
resource "azurerm_network_interface" "public" {
  count               = length(var.public_subnets)
  name                = "${var.public_subnets[count.index].name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.public[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public[count.index].id
  }

  tags = var.tags
}

# Network interfaces for private subnets
resource "azurerm_network_interface" "private" {
  count               = length(var.private_subnets)
  name                = "${var.private_subnets[count.index].name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.private[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = null
  }

  tags = var.tags
}