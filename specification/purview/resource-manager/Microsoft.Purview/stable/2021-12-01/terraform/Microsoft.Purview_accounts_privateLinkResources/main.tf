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
  default = "acctest6962"
}

variable "location" {
  type    = string
  default = "westeurope"
}

resource "azapi_resource" "resourceGroup" {
  type     = "Microsoft.Resources/resourceGroups@2020-06-01"
  name     = var.resource_name
  location = var.location
}

resource "azapi_resource" "account" {
  type      = "Microsoft.Purview/accounts@2021-07-01"
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

// OperationId: PrivateLinkResources_GetByGroupId
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Purview/accounts/{accountName}/privateLinkResources/{groupId}
data "azapi_resource" "privateLinkResource" {
  type      = "Microsoft.Purview/accounts/privateLinkResources@2021-12-01"
  parent_id = azapi_resource.account.id
  name      = "account"
}

// OperationId: PrivateLinkResources_ListByAccount
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Purview/accounts/{accountName}/privateLinkResources
data "azapi_resource_list" "listPrivateLinkResourcesByAccount" {
  type       = "Microsoft.Purview/accounts/privateLinkResources@2021-12-01"
  parent_id  = azapi_resource.account.id
}

