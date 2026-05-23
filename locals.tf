locals {
  storage_account_app_settings = {
    "AzureWebJobsStorage" = azurerm_storage_account.this.primary_connection_string
  }

  full_app_settings = merge(var.app_settings, local.storage_account_app_settings)
}