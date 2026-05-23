# iac-azure-function-app

## Description

Terraform module that provisions a Linux Azure Function App together with its storage account and App Service plan. The module also injects `AzureWebJobsStorage` into the Function App settings and merges it with any custom application settings you provide.

## Requirements

| Requirement | Version |
|---|---|
| Terraform | `>= 1.14.0` |

## Providers

| Name | Version |
|---|---|
| azurerm | `>= 4.71.0` |

## Usage

```hcl
module "function_app" {
  source = "./modules/iac-azure-function-app"

  function_app_name    = "my-func-app"
  service_plan_name    = "my-func-plan"
  storage_account_name = "myfuncstorage01"
  resource_group_data = {
    name     = "rg-my-app"
    location = "westeurope"
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "node"
  }

  node_runtime_version = "20"
}
```

## Inputs

| Name | Type | Default | Description |
|---|---|---:|---|
| app_settings | `map(string)` | `{}` | Application settings for the Function App. |
| dotnet_runtime_version | `string` | `8.0` | The .NET runtime version. |
| function_app_name | `string` | `N/A` | The name of the Function App. |
| node_runtime_version | `string` | `null` | The runtime version for Node.js. |
| resource_group_data | `object({ name = string, location = string })` | `N/A` | The resource group name and location used for the Function App resources. |
| service_plan_name | `string` | `N/A` | The name of the Service Plan (App Service Plan). |
| storage_account_name | `string` | `N/A` | The name of the Storage Account required for the Function App. |

## Outputs

| Name | Description |
|---|---|
| function_app_default_hostname | The default hostname of the Function App. |
| function_app_id | The ID of the Function App. |
| function_app_name | The name of the Function App. |
| storage_account_name | The name of the Storage Account. |
| storage_account_primary_connection_string | The primary connection string for the Storage Account. This output is sensitive. |
