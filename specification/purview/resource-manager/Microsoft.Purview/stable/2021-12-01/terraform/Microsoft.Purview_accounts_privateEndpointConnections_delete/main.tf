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
  default = "acctest6385"
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

resource "azapi_resource" "virtualNetwork" {
  type      = "Microsoft.Network/virtualNetworks@2023-05-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
  body = jsonencode({
    properties = {
      addressSpace = {
        addressPrefixes = [
          "10.5.0.0/16",
        ]
      }
    }
  })
  schema_validation_enabled = false
  response_export_values    = ["*"]
  ignore_body_changes       = ["properties.subnets"]
}

resource "azapi_resource" "subnet" {
  type      = "Microsoft.Network/virtualNetworks/subnets@2023-05-01"
  parent_id = azapi_resource.virtualNetwork.id
  name      = var.resource_name
  body = jsonencode({
    properties = {
      addressPrefix                  = "10.5.2.0/24"
      privateEndpointNetworkPolicies = "Enabled"
    }
  })
  schema_validation_enabled = false
  response_export_values    = ["*"]
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

resource "azapi_resource" "privateEndpoint" {
  type      = "Microsoft.Network/privateEndpoints@2023-05-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
  body = jsonencode({
    properties = {
      subnet = {
        id = azapi_resource.subnet.id
      }
      manualPrivateLinkServiceConnections = [
        {
          name = var.resource_name
          properties = {
            privateLinkServiceId = azapi_resource.account.id
            groupIds             = ["account"]
          }
        }
      ]
    }
  })
}

data "azapi_resource_id" "privateEndpointConnection" {
  type      = "Microsoft.Purview/accounts/privateEndpointConnections@2021-12-01"
  parent_id = azapi_resource.account.id
  name      = local.privateEndpointConnectionName == null ? "placeholder" : local.privateEndpointConnectionName
}

// OperationId: PrivateEndpointConnections_Delete
// DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Purview/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}
resource "azapi_resource_action" "delete_privateEndpointConnection" {
  type      = "Microsoft.Purview/accounts/privateEndpointConnections@2021-12-01"
  resource_id = data.azapi_resource_id.privateEndpointConnection.id
  method = "DELETE"
}

locals {
  privateEndpointConnectionName = one([for r in jsondecode(data.azapi_resource_list.listPrivateEndpointConnectionsByAccount.output).value : r.name
  if r.properties.privateEndpoint.id == azapi_resource.privateEndpoint.id])
}

// OperationId: PrivateEndpointConnections_ListByAccount
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Purview/accounts/{accountName}/privateEndpointConnections
data "azapi_resource_list" "listPrivateEndpointConnectionsByAccount" {
  type                   = "Microsoft.Purview/accounts/privateEndpointConnections@2021-12-01"
  parent_id              = azapi_resource.account.id
  response_export_values = ["*"]
  depends_on             = [azapi_resource.privateEndpoint]
}
