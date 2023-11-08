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

variable "resource_name" {
  type    = string
  default = "acctest5609"
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
      publicNetworkAccess  = "Enabled"
      managedEventHubState = "Disabled"
    }
  })
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

resource "azapi_resource" "namespace" {
  type      = "Microsoft.EventHub/namespaces@2022-01-01-preview"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
  body = jsonencode({
    identity = {
      type                   = "None"
      userAssignedIdentities = null
    }
    properties = {
      disableLocalAuth     = false
      isAutoInflateEnabled = false
      publicNetworkAccess  = "Enabled"
      zoneRedundant        = false
    }
    sku = {
      capacity = 1
      name     = "Standard"
      tier     = "Standard"
    }
  })
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

resource "azapi_resource" "eventhub" {
  type      = "Microsoft.EventHub/namespaces/eventhubs@2023-01-01-preview"
  parent_id = azapi_resource.namespace.id
  name      = var.resource_name
  body = jsonencode({
    properties = {
      messageRetentionInDays = 1
      partitionCount         = 2
      status                 = "Active"
    }
  })
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

resource "azurerm_role_assignment" "roleAssignment" {
  scope                = azapi_resource.namespace.id
  role_definition_name = "Owner"
  principal_id         = azapi_resource.account.identity[0].principal_id
}


resource "azurerm_role_assignment" "roleAssignment2" {
  scope                = azapi_resource.eventhub.id
  role_definition_name = "Owner"
  principal_id         = azapi_resource.account.identity[0].principal_id
}

resource "azurerm_role_assignment" "roleAssignment3" {
  scope                = azapi_resource.eventhub.id
  role_definition_name = "Azure Event Hubs Data Sender"
  principal_id         = azapi_resource.account.identity[0].principal_id
}


// OperationId: KafkaConfigurations_CreateOrUpdate, KafkaConfigurations_Get, KafkaConfigurations_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Purview/accounts/{accountName}/kafkaConfigurations/{kafkaConfigurationName}
resource "azapi_resource" "kafkaConfiguration" {
  type      = "Microsoft.Purview/accounts/kafkaConfigurations@2021-12-01"
  parent_id = azapi_resource.account.id
  name      = var.resource_name
  body = jsonencode({
    properties = {
      consumerGroup = "consumerGroup"
      credentials = {
        type = "SystemAssigned"
      }
      eventHubPartitionId = "partitionId"
      eventHubResourceId  = azapi_resource.eventhub.id
      eventHubType        = "Notification"
      eventStreamingState = "Enabled"
      eventStreamingType  = "Azure"
    }
  })
  schema_validation_enabled = false
  depends_on = [
    azurerm_role_assignment.roleAssignment,
    azurerm_role_assignment.roleAssignment2,
    azurerm_role_assignment.roleAssignment3
  ]
}

// OperationId: KafkaConfigurations_ListByAccount
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Purview/accounts/{accountName}/kafkaConfigurations
data "azapi_resource_list" "listKafkaConfigurationsByAccount" {
  type       = "Microsoft.Purview/accounts/kafkaConfigurations@2021-12-01"
  parent_id  = azapi_resource.account.id
  depends_on = [azapi_resource.kafkaConfiguration]
}

