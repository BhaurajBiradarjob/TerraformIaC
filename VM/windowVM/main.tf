provider "azurerm" {
  features {

  }
}
variable "rg-name" {}
variable "rg-location" {}

locals {
  Environment_variable = "terra-dev"
  Team_variable        = "Saffron"
  Build_variable       = "rg-dev-saffron"
  primary_subnet_name  = "saffronsubnet1"
}

# VM creation : Resource Group, Virtual network, Subnet, Network Interface, Virtual Machine
# Resource Group
resource "azurerm_resource_group" "rg-storage" {
  name     = var.rg-name
  location = var.rg-location
  tags = {
    "Environment" = local.Environment_variable
    "Team"        = local.Team_variable
    "Build"       = local.Build_variable
  }
}

# Virtual network
resource "azurerm_virtual_network" "vm-network" {
  name                = "vm-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-storage.location
  resource_group_name = azurerm_resource_group.rg-storage.name
  depends_on          = [azurerm_resource_group.rg-storage]
}

# Subnet
resource "azurerm_subnet" "vm-subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg-storage.name
  virtual_network_name = azurerm_virtual_network.vm-network.name
  address_prefixes     = ["10.0.2.0/24"]
  depends_on           = [azurerm_resource_group.rg-storage, azurerm_virtual_network.vm-network]
}

# Network Interface
resource "azurerm_network_interface" "vm-ntwkinterface" {
  name                = "example-nic"
  location            = azurerm_resource_group.rg-storage.location
  resource_group_name = azurerm_resource_group.rg-storage.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [azurerm_resource_group.rg-storage, azurerm_subnet.vm-subnet]
}

# Virtual Machine
resource "azurerm_windows_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.rg-storage.name
  location            = azurerm_resource_group.rg-storage.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.vm-ntwkinterface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  depends_on = [azurerm_resource_group.rg-storage, azurerm_network_interface.vm-ntwkinterface]
}
