resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_data.name
  location                 = var.resource_group_data.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "this" {
  name                  = "deploymentpackage"
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
}

resource "azurerm_service_plan" "this" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_data.name
  location            = var.resource_group_data.location
  os_type             = "Linux"
  sku_name            = "FC1" # Y1 for Consumption, F1 for Free
}

resource "azurerm_function_app_flex_consumption" "this" {
  name                       = var.function_app_name
  resource_group_name        = var.resource_group_data.name
  location                   = var.resource_group_data.location
  service_plan_id            = azurerm_service_plan.this.id

  storage_container_type      = "blobContainer"
  storage_container_endpoint  = "${azurerm_storage_account.this.primary_blob_endpoint}${azurerm_storage_container.this.name}"
  storage_authentication_type = "StorageAccountConnectionString"
  storage_access_key          = azurerm_storage_account.this.primary_access_key
  runtime_name                = local.runtime_name
  runtime_version             = local.runtime_version
  maximum_instance_count      = 1
  instance_memory_in_mb       = 512

  site_config {}

  app_settings = local.full_app_settings
}
