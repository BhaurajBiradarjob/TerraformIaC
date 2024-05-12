provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "rg-name" {
  name     = "rg-dev-saffron"
  location = "West Europe"
  tags = {
    "Environment" = "terra-dev"
    "Team"        = "Saffron"
    "Build"       = "rg-dev-saffron"
  }
}

output "rg-dev-location" {
  value = azurerm_resource_group.rg-name.location
}
output "rg-dev-tags_environment" {
  value = azurerm_resource_group.rg-name.tags["Environment"]
}
output "rg-dev-tags_Team" {
  value = azurerm_resource_group.rg-name.tags["Team"]
}
output "rg-dev-tags_Build" {
  value = azurerm_resource_group.rg-name.tags["Build"]
}

