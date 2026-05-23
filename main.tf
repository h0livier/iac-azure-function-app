resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_data.name
  location                 = var.resource_group_data.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "this" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_data.name
  location            = var.resource_group_data.location
  os_type             = "Linux"
  sku_name            = "F1" # Y1 for Consumption, F1 for Free
}

resource "azurerm_linux_function_app" "this" {
  name                       = var.function_app_name
  resource_group_name        = var.resource_group_data.name
  location                   = var.resource_group_data.location
  storage_account_name       = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key
  service_plan_id            = azurerm_service_plan.this.id

  site_config {
    application_stack {
      node_version   = var.node_runtime_version
      dotnet_version = var.dotnet_runtime_version
    }
  }

  app_settings = local.full_app_settings
}
