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
  default = "acctest8801"
}

variable "location" {
  type    = string
  default = "eastus"
}

resource "azapi_resource" "resourceGroup" {
  type     = "Microsoft.Resources/resourceGroups@2020-06-01"
  name     = var.resource_name
  location = var.location
}

resource "azapi_resource" "workspace" {
  type      = "Microsoft.OperationalInsights/workspaces@2022-10-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
  body = jsonencode({
    properties = {
      features = {
        disableLocalAuth                            = false
        enableLogAccessUsingOnlyResourcePermissions = true
      }
      publicNetworkAccessForIngestion = "Enabled"
      publicNetworkAccessForQuery     = "Enabled"
      retentionInDays                 = 30
      sku = {
        name = "PerGB2018"
      }
      workspaceCapping = {
        dailyQuotaGb = -1
      }
    }
  })
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

resource "azapi_resource" "solution" {
  type      = "Microsoft.OperationsManagement/solutions@2015-11-01-preview"
  parent_id = azapi_resource.resourceGroup.id
  name      = "WindowsEventForwarding(${azapi_resource.workspace.name})"
  location  = azapi_resource.resourceGroup.location
  body = jsonencode({
    plan = {
      name          = "WindowsEventForwarding(${azapi_resource.workspace.name})"
      publisher     = "Microsoft"
      product       = "OMSGallery/WindowsEventForwarding"
      promotionCode = ""
    }
    properties = {
      workspaceResourceId = azapi_resource.workspace.id
    }
  })
}

// OperationId: DataCollectionRules_Create, DataCollectionRules_Get, DataCollectionRules_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/dataCollectionRules/{dataCollectionRuleName}
resource "azapi_resource" "dataCollectionRule" {
  type      = "Microsoft.Insights/dataCollectionRules@2022-06-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
  body = jsonencode({
    properties = {
      dataFlows = [
        {
          destinations = [
            "centralWorkspace",
          ]
          streams = [
            "Microsoft-Perf",
            "Microsoft-Syslog",
            "Microsoft-WindowsEvent",
          ]
        },
      ]
      dataSources = {
        performanceCounters = [
          {
            counterSpecifiers = [
              "\\Processor(_Total)\\% Processor Time",
              "\\Memory\\Committed Bytes",
              "\\LogicalDisk(_Total)\\Free Megabytes",
              "\\PhysicalDisk(_Total)\\Avg. Disk Queue Length",
            ]
            name                       = "cloudTeamCoreCounters"
            samplingFrequencyInSeconds = 15
            streams = [
              "Microsoft-Perf",
            ]
          },
          {
            counterSpecifiers = [
              "\\Process(_Total)\\Thread Count",
            ]
            name                       = "appTeamExtraCounters"
            samplingFrequencyInSeconds = 30
            streams = [
              "Microsoft-Perf",
            ]
          },
        ]
        syslog = [
          {
            facilityNames = [
              "cron",
            ]
            logLevels = [
              "Debug",
              "Critical",
              "Emergency",
            ]
            name = "cronSyslog"
            streams = [
              "Microsoft-Syslog",
            ]
          },
          {
            facilityNames = [
              "syslog",
            ]
            logLevels = [
              "Alert",
              "Critical",
              "Emergency",
            ]
            name = "syslogBase"
            streams = [
              "Microsoft-Syslog",
            ]
          },
        ]
        windowsEventLogs = [
          {
            name = "appTeam1AppEvents"
            streams = [
              "Microsoft-WindowsEvent",
            ]
            xPathQueries = [
              "System![System[(Level = 1 or Level = 2 or Level = 3)]]",
              "Application!*[System[(Level = 1 or Level = 2 or Level = 3)]]",
            ]
          },
        ]
      }
      destinations = {
        logAnalytics = [
          {
            name                = "centralWorkspace"
            workspaceResourceId = azapi_resource.workspace.id
          },
        ]
      }
    }
  })
  schema_validation_enabled = false
  depends_on                = [azapi_resource.solution]
}

// OperationId: DataCollectionRules_Update
// PATCH /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/dataCollectionRules/{dataCollectionRuleName}
resource "azapi_resource_action" "patch_dataCollectionRule" {
  type        = "Microsoft.Insights/dataCollectionRules@2022-06-01"
  resource_id = azapi_resource.dataCollectionRule.id
  action      = ""
  method      = "PATCH"
  body = jsonencode({
    tags = {
      tag1 = "A"
      tag2 = "B"
      tag3 = "C"
    }
  })
}

data "azapi_resource" "subscription" {
  type                   = "Microsoft.Resources/subscriptions@2020-06-01"
  response_export_values = ["*"]
}

// OperationId: DataCollectionRules_ListBySubscription
// GET /subscriptions/{subscriptionId}/providers/Microsoft.Insights/dataCollectionRules
data "azapi_resource_list" "listDataCollectionRulesBySubscription" {
  type       = "Microsoft.Insights/dataCollectionRules@2022-06-01"
  parent_id  = data.azapi_resource.subscription.id
  depends_on = [azapi_resource.dataCollectionRule]
}

// OperationId: DataCollectionRules_ListByResourceGroup
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/dataCollectionRules
data "azapi_resource_list" "listDataCollectionRulesByResourceGroup" {
  type       = "Microsoft.Insights/dataCollectionRules@2022-06-01"
  parent_id  = azapi_resource.resourceGroup.id
  depends_on = [azapi_resource.dataCollectionRule]
}

