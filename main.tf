
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
 scope_map_id = azurerm_container_registry_scope_map.Scope_map.id
  
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "Kube-p2"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}
