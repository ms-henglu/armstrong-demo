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
  default = "acctest6172"
}

variable "location" {
  type    = string
  default = "westeurope"
}

// OperationId: Operations_List
// GET /providers/Microsoft.Purview/operations
data "azapi_resource_list" "listOperationsByTenant" {
  type      = "Microsoft.Purview/operations@2021-12-01"
  parent_id = "/"
}

