
# Cloud provider
provider "azurerm" {
  features {

  }
}

# Global variables
variable "rg-name" {}
variable "rg-location" {}
variable "storage-account-name" {}
variable "storage-container-name" {}
variable "storage-blob-name" {}
variable "security-group-name" {}
variable "virtual-network-name" {}

# Local variables
locals {
  Environment_variable = "terra-dev"
  Team_variable        = "Saffron"
  Build_variable       = "rg-dev-saffron"
  primary_subnet_name  = "saffronsubnet1"
}

// To Create Storage account, we need following details:
//1. Resource Group (name, location and tags) name
//2. Storage account name
//3. location 
//4. Account tiers (Standard or Premium)(account_tiers)
//5. Redundancy(account_replication_type)(LRS, ZRS, GRS)
//6. Tags(Maps) ex:Environment
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

# Network Security Group
resource "azurerm_network_security_group" "rg-security-group" {
  name                = var.security-group-name
  location            = azurerm_resource_group.rg-storage.location
  resource_group_name = azurerm_resource_group.rg-storage.name
  depends_on          = [azurerm_resource_group.rg-storage]
}

# Virtual Network
resource "azurerm_virtual_network" "name" {
  name                = var.virtual-network-name
  location            = azurerm_resource_group.rg-storage.location
  resource_group_name = azurerm_resource_group.rg-storage.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
  subnet {
    name           = local.primary_subnet_name
    security_group = azurerm_network_security_group.rg-security-group.id
    address_prefix = "10.0.1.0/24"
  }
  tags = {
    "Environment" = local.Environment_variable
    "Team"        = local.Team_variable
    "Build"       = local.Build_variable
  }
  depends_on = [
    azurerm_resource_group.rg-storage,
    azurerm_network_security_group.rg-security-group
  ]
}

# Storage Account
resource "azurerm_storage_account" "name" {
  name                     = var.storage-account-name
  resource_group_name      = azurerm_resource_group.rg-storage.name
  location                 = azurerm_resource_group.rg-storage.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    "Environment" = local.Environment_variable
    "Team"        = local.Team_variable
    "Build"       = local.Build_variable
  }
  depends_on = [azurerm_resource_group.rg-storage]
}

# Storage Containers
resource "azurerm_storage_container" "rg-storage-container" {
  name                  = var.storage-container-name
  storage_account_name  = azurerm_storage_account.name.name
  container_access_type = "blob"
  depends_on            = [azurerm_storage_account.name]
}

# Blob storage
# This is used to upload local file to the blob storage.
resource "azurerm_storage_blob" "rg-storage-blob" {
  name                   = var.storage-blob-name
  storage_account_name   = azurerm_storage_account.name.name
  storage_container_name = azurerm_storage_container.rg-storage-container.name
  type                   = "Block"
  source                 = var.storage-blob-name

  depends_on = [azurerm_storage_container.rg-storage-container]
}

#region Outputs
output "storage-account-id" {
  value = azurerm_storage_account.name.id
}

output "storage-account-location" {
  value = azurerm_storage_account.name.location
}

output "storage-account-access_tier" {
  value = azurerm_storage_account.name.access_tier
}
output "storage-account-large_file_share_enabled" {
  value = azurerm_storage_account.name.large_file_share_enabled
}

output "storage-account-container-id" {
  value = azurerm_storage_container.rg-storage-container.id
}

output "storage-account-has_legal_hold" {
  value = azurerm_storage_container.rg-storage-container.has_legal_hold
}

output "storage-account-has_immutability_policy" {
  value = azurerm_storage_container.rg-storage-container.has_immutability_policy
}

output "storage-account-resource_manager_id" {
  value = azurerm_storage_container.rg-storage-container.resource_manager_id
}

output "storage-account-metadata" {
  value = azurerm_storage_container.rg-storage-container.metadata
}

output "rg-storage-blob-id" {
  value = azurerm_storage_blob.rg-storage-blob.id
}

output "rg-storage-blob-url" {
  value = azurerm_storage_blob.rg-storage-blob.url
}
#endregion
