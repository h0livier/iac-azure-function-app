output "function_app_name" {
  description = "The name of the Function App"
  value       = var.function_app_name
}

output "function_app_default_hostname" {
  description = "The default hostname of the Function App"
  value       = azurerm_function_app_flex_consumption.this.default_hostname
}

output "function_app_id" {
  description = "The ID of the Function App"
  value       = azurerm_function_app_flex_consumption.this.id
}

output "storage_account_name" {
  description = "The name of the Storage Account"
  value       = azurerm_storage_account.this.name
}

output "storage_account_primary_connection_string" {
  description = "The primary connection string for the Storage Account"
  value       = azurerm_storage_account.this.primary_connection_string
  sensitive   = true
}
