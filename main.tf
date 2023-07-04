provider "azurerm" {
    subscription_id = "63624c86-fe10-49d1-b0c7-b5b0be84da6a"
    client_id = "27ed852a-f10d-41bc-951c-d12bca932c28"
    client_secret = "Wvi8Q~13MgHl609Cm6Ba6F-774N3uUnk5dECGb0F"
    tenant_id = "7270ce39-4b64-4579-8f7f-93639d71f1ca"

    features {
      
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
