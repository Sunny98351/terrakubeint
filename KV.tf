resource "azurerm_key_vault" "adiKV" {
  name                        = "kubeKV"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = "7270ce39-4b64-4579-8f7f-93639d71f1ca"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}
resource "azurerm_key_vault_secret" "KVS" {
    name = "kubeSecret"
    value = azurerm_container_registry_token.Token.name
    key_vault_id = azurerm_key_vault.adiKV.id
  
}