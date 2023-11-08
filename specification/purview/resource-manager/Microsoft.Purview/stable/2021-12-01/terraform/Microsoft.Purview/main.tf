terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
}

provider "azapi" {
  skip_provider_registration = false
}

provider "azurerm" {
  features {
  }
}

variable "resource_name" {
  type    = string
  default = "acctest1978"
}

variable "location" {
  type    = string
  default = "westeurope"
}

data "azurerm_client_config" "current" {

}

resource "azapi_resource" "resourceGroup" {
  type     = "Microsoft.Resources/resourceGroups@2020-06-01"
  name     = var.resource_name
  location = var.location
}

resource "azapi_resource" "account" {
  type      = "Microsoft.Purview/accounts@2021-12-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
  body = jsonencode({
    identity = {
      type                   = "SystemAssigned"
      userAssignedIdentities = null
    }
    properties = {
      publicNetworkAccess = "Enabled"
    }
  })
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

// OperationId: DefaultAccounts_Get
// GET /providers/Microsoft.Purview/getDefaultAccount
resource "azapi_resource_action" "getDefaultAccount" {
  type        = "Microsoft.Purview@2021-12-01"
  resource_id = "/providers/Microsoft.Purview"
  action      = "getDefaultAccount?scopeType=Subscription&scopeTenantId=${data.azurerm_client_config.current.tenant_id}&scope=${data.azapi_resource.subscription.name}"
  method      = "GET"
  depends_on = [ azapi_resource_action.setDefaultAccount ]
}

// OperationId: DefaultAccounts_Remove
// POST /providers/Microsoft.Purview/removeDefaultAccount
resource "azapi_resource_action" "removeDefaultAccount" {
  type        = "Microsoft.Purview@2021-12-01"
  resource_id = "/providers/Microsoft.Purview"
  action      = "removeDefaultAccount"
  method      = "POST"
  depends_on  = [azapi_resource_action.setDefaultAccount, data.azapi_resource_action.getDefaultAccount]
}

// OperationId: DefaultAccounts_Set
// POST /providers/Microsoft.Purview/setDefaultAccount
resource "azapi_resource_action" "setDefaultAccount" {
  type        = "Microsoft.Purview@2021-12-01"
  resource_id = "/providers/Microsoft.Purview"
  action      = "setDefaultAccount"
  method      = "POST"
  body = jsonencode({
    accountName       = azapi_resource.account.name
    resourceGroupName = azapi_resource.resourceGroup.name
    scope             = data.azapi_resource.subscription.name
    scopeTenantId     = data.azurerm_client_config.current.tenant_id
    scopeType         = "Subscription"
    subscriptionId    = data.azapi_resource.subscription.name
  })
}

data "azapi_resource" "subscription" {
  type                   = "Microsoft.Resources/subscriptions@2020-06-01"
  response_export_values = ["*"]
}

data "azapi_resource_id" "subscriptionScopeProvider" {
  type      = "Microsoft.Resources/providers@2020-06-01"
  parent_id = data.azapi_resource.subscription.id
  name      = "Microsoft.Purview"
}

// OperationId: Accounts_CheckNameAvailability
// POST /subscriptions/{subscriptionId}/providers/Microsoft.Purview/checkNameAvailability
resource "azapi_resource_action" "checkNameAvailability" {
  type        = "Microsoft.Purview@2021-12-01"
  resource_id = data.azapi_resource_id.subscriptionScopeProvider.id
  action      = "checkNameAvailability"
  method      = "POST"
  body = jsonencode({
    name = "account1"
    type = "Microsoft.Purview/accounts"
  })
}

