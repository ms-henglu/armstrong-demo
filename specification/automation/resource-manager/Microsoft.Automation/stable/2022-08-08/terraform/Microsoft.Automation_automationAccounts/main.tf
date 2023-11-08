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

variable "resource_name" {
  type    = string
  default = "acctest3106"
}

variable "location" {
  type    = string
  default = "East US 2"
}

resource "azapi_resource" "resourceGroup" {
  type     = "Microsoft.Resources/resourceGroups@2020-06-01"
  name     = var.resource_name
  location = var.location
}

// OperationId: AutomationAccount_CreateOrUpdate, AutomationAccount_Get, AutomationAccount_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}
resource "azapi_resource" "automationAccount" {
  type      = "Microsoft.Automation/automationAccounts@2022-08-08"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
  body = jsonencode({
    properties = {
      sku = {
        name = "Free"
      }
    }
  })
  schema_validation_enabled = false
}

// OperationId: AutomationAccount_Update
// PATCH /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}
resource "azapi_resource_action" "patch_automationAccount" {
  type        = "Microsoft.Automation/automationAccounts@2022-08-08"
  resource_id = azapi_resource.automationAccount.id
  action      = ""
  method      = "PATCH"
  body = jsonencode({
    properties = {
      sku = {
        name = "Free"
      }
    }
  })
}

// OperationId: Keys_ListByAutomationAccount
// POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/listKeys
resource "azapi_resource_action" "listKeys" {
  type        = "Microsoft.Automation/automationAccounts@2022-08-08"
  resource_id = azapi_resource.automationAccount.id
  action      = "listKeys"
  method      = "POST"
}

// OperationId: Statistics_ListByAutomationAccount
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/statistics
data "azapi_resource_action" "statistics" {
  type        = "Microsoft.Automation/automationAccounts@2022-08-08"
  resource_id = azapi_resource.automationAccount.id
  action      = "statistics"
  method      = "GET"
}

// OperationId: Usages_ListByAutomationAccount
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/usages
data "azapi_resource_action" "usages" {
  type        = "Microsoft.Automation/automationAccounts@2022-08-08"
  resource_id = azapi_resource.automationAccount.id
  action      = "usages"
  method      = "GET"
}

data "azapi_resource" "subscription" {
  type                   = "Microsoft.Resources/subscriptions@2020-06-01"
  response_export_values = ["*"]
}

// OperationId: AutomationAccount_List
// GET /subscriptions/{subscriptionId}/providers/Microsoft.Automation/automationAccounts
data "azapi_resource_list" "listAutomationAccountsBySubscription" {
  type       = "Microsoft.Automation/automationAccounts@2022-08-08"
  parent_id  = data.azapi_resource.subscription.id
  depends_on = [azapi_resource.automationAccount]
}

// OperationId: AutomationAccount_ListByResourceGroup
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts
data "azapi_resource_list" "listAutomationAccountsByResourceGroup" {
  type       = "Microsoft.Automation/automationAccounts@2022-08-08"
  parent_id  = azapi_resource.resourceGroup.id
  depends_on = [azapi_resource.automationAccount]
}

