locals {
  storage_account_app_settings = {
    "AzureWebJobsStorage" = azurerm_storage_account.this.primary_connection_string
  }

  runtime_name = var.dotnet_runtime_version != null ? "dotnet-isolated" : "node"
  runtime_version = local.runtime_name == "dotnet-isolated" ? var.dotnet_runtime_version : var.node_runtime_version

  full_app_settings = merge(var.app_settings, local.storage_account_app_settings)
}