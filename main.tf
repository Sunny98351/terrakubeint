terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}
resource "azurerm_resource_group" "adi-t2" {
    name = var.resource_group_name
    location = var.location
  
}

resource "azurerm_container_registry" "acr" {
  name                = "kubernetedContainer"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = true
  
}
resource "azurerm_container_registry_scope_map" "Scope_map" {
  name                    = "kuberScMap"
  container_registry_name = azurerm_container_registry.acr.name
  resource_group_name     = var.resource_group_name
  actions = [
    "repositories/repo1/content/read",
    "repositories/repo1/content/write"
  ]
}
resource "azurerm_container_registry_token" "Token" {
  name                    = "KuberToken"
  container_registry_name = azurerm_container_registry.acr.name
  resource_group_name     = var.resource_group_name
  actions = [
    "repositories/repo1/content/read",
    "repositories/repo1/content/write"
  ]
}