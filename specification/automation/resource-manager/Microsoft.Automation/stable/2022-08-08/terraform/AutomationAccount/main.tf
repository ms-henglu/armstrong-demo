// ====================================================
// Provider definition
// ====================================================
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
    features {}
}


// ====================================================
// Dependency definition
// ====================================================

data "azurerm_client_config" "current" {}

locals {
  subscription_id = data.azurerm_client_config.current.subscription_id
  location = "eastus2euap"
}

resource "azapi_resource" "rg" {
  type      = "Microsoft.Resources/resourceGroups@2020-06-01"
  parent_id = "/subscriptions/${local.subscription_id}"
  name      = "acctest0627"
  location  = local.location
}

// ====================================================
// Resource
// ====================================================

// PUT/GET/DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}
resource "azapi_resource" "automationAccount" {
  type      = "Microsoft.Automation/automationAccounts@2022-08-08"
  parent_id = azapi_resource.rg.id
  name      = "acctest0627"
  location  = azapi_resource.rg.location
  body = jsonencode({
    properties = {
      sku = {
        name = "Free"
      }
    }
  })
}

// PATCH /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}
resource "azapi_resource_action" "updateTags" {
  type        = "Microsoft.Automation/automationAccounts@2022-08-08"
  resource_id = azapi_resource.automationAccount.id
  method      = "PATCH"
  body = jsonencode({
    tags = {
      updatedBy = "PATCH"
    }
  })
}

// ====================================================
// Resource actions
// ====================================================

// POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/listKeys
data "azapi_resource_action" "listKeys" {
  type        = "Microsoft.Automation/automationAccounts@2022-08-08"
  resource_id = azapi_resource.automationAccount.id
  action      = "listKeys"
}

// POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/statistics
data "azapi_resource_action" "statistics" {
  type        = "Microsoft.Automation/automationAccounts@2022-08-08"
  resource_id = azapi_resource.automationAccount.id
  action      = "statistics"
  method      = "GET"
}

// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/usages
data "azapi_resource_action" "usage" {
  type        = "Microsoft.Automation/automationAccounts@2022-08-08"
  resource_id = azapi_resource.automationAccount.id
  action      = "usages"
  method      = "GET"
}

// ====================================================
// List resources
// ====================================================

// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts
data "azapi_resource_action" "listByResourceGroup" {
  type        = "Microsoft.Automation@2022-08-08"
  resource_id = "${azapi_resource.rg.id}/providers/Microsoft.Automation"
  action      = "automationAccounts"
  method      = "GET"
  depends_on  = [azapi_resource.automationAccount]
}

// GET /subscriptions/{subscriptionId}/providers/Microsoft.Automation/automationAccounts
data "azapi_resource_action" "listBySubscription" {
  type        = "Microsoft.Automation@2022-08-08"
  resource_id = "/subscriptions/${local.subscription_id}/providers/Microsoft.Automation"
  action      = "automationAccounts"
  method      = "GET"
  depends_on  = [azapi_resource.automationAccount]
}
