variable "function_app_name" {
  description = "The name of the Function App."
  type        = string
}

variable "service_plan_name" {
  description = "The name of the Service Plan (App Service Plan)."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the Storage Account (required for Function App)."
  type        = string
  validation {
    condition     = length(var.storage_account_name) >= 3 && length(var.storage_account_name) <= 24 && can(regex("^[a-z0-9]+$", var.storage_account_name))
    error_message = "Storage account name must be between 3 and 24 characters, and can only contain lowercase letters and numbers."
  }
}

variable "resource_group_data" {
  description = "The resource group data for the Function App."
  type = object({
    name     = string
    location = string
  })
}

variable "dotnet_runtime_version" {
  description = "The .NET runtime version (e.g., '6' for .NET 6)."
  type        = string
  default     = "8.0"
}

variable "node_runtime_version" {
  description = "The runtime version (e.g., '20' for Node.js 20)."
  type        = string
  default     = null
}

variable "app_settings" {
  description = "Application settings for the Function App."
  type        = map(string)
  default     = {}
}
