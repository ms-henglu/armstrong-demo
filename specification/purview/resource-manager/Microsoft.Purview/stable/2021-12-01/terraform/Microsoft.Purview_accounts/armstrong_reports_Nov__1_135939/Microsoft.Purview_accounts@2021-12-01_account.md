## Microsoft.Purview/accounts@2021-12-01 - ROUNDTRIP_INCONSISTENT_PROPERTY

### Description

I found differences between PUT request body and GET response:

- .properties.managedResourcesPublicNetworkAccess: expect Enabled, but got Disabled

```json
{
    "properties": {
        "managedEventHubState": "Enabled",
        "managedResourceGroupName": "custom-rgname",
        "managedResourcesPublicNetworkAccess": Got "Disabled" in response, expect "Enabled"
    }
}
```

### Details

1. ARM Fully-Qualified Resource Type
```
Microsoft.Purview/accounts
```

2. API Version
```
2021-12-01
```

3. Swagger issue type
```
Swagger Correctness
```

4. OperationId
```
TODO
e.g., VirtualMachines_Get
```

5. Swagger GitHub permalink
```
TODO, 
e.g., https://github.com/Azure/azure-rest-api-specs/blob/60723d13309c8f8060d020a7f3dd9d6e380f0bbd
/specification/compute/resource-manager/Microsoft.Compute/stable/2020-06-01/compute.json#L9065-L9101
```

6. Error code
```
ROUNDTRIP_INCONSISTENT_PROPERTY
```

7. Request traces
```
PUT /subscriptions/{subscription_id}/resourceGroups/acctest2590/providers/Microsoft.Purview/accounts/acctest2590?api-version=2021-12-01
Status Code: 201
------------ Request ------------
Accept: application/json
Authorization: REDACTED
Content-Length: 198
Content-Type: application/json
User-Agent: HashiCorp Terraform/1.5.2 (+https://www.terraform.io) Terraform Plugin SDK/2.8.0 terraform-provider-azapi/dev pid-222c6c49-1b0a-5959-a213-6608f9eb8820
X-Ms-Correlation-Request-Id: 474750d5-e95c-6dc4-5e4d-489be2ba1f22

---
{
  "identity": {
    "type": "SystemAssigned"
  },
  "location": "westus2",
  "properties": {
    "managedEventHubState": "Enabled",
    "managedResourceGroupName": "custom-rgname",
    "managedResourcesPublicNetworkAccess": "Enabled"
  }
}

------------ Response ------------
X-Ms-Correlation-Request-Id: 474750d5-e95c-6dc4-5e4d-489be2ba1f22
X-Ms-Ratelimit-Remaining-Subscription-Writes: 1197
Pragma: no-cache
X-Content-Type-Options: nosniff
Expires: -1
Location: https://management.azure.com/subscriptions/{subscription_id}/resourceGroups/acctest2590/providers/Microsoft.Purview/accounts/acctest2590?api-version=2021-12-01
X-Ms-Account-Status: Creating
Api-Supported-Versions: 2020-12-01-preview, 2021-07-01, 2021-12-01, 2023-05-01-preview
Content-Type: application/json; charset=utf-8
Date: Wed, 01 Nov 2023 05:55:46 GMT
Server: Kestrel
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-Ms-Request-Id: 335883ea-a671-4d72-b83a-b5616f5edc5f
Cache-Control: no-cache
Content-Length: 1340
X-Ms-Routing-Request-Id: SOUTHEASTASIA:20231101T055547Z:335883ea-a671-4d72-b83a-b5616f5edc5f
------
{
  "id": "/subscriptions/{subscription_id}/resourceGroups/acctest2590/providers/Microsoft.Purview/accounts/acctest2590",
  "identity": {
    "principalId": "a9b8a54a-4f20-473c-9673-d22bd6b23a2d",
    "tenantId": "72f988bf-86f1-41af-91ab-2d7cd011db47",
    "type": "SystemAssigned"
  },
  "location": "westus2",
  "name": "acctest2590",
  "properties": {
    "accountStatus": {
      "accountProvisioningState": "Creating"
    },
    "cloudConnectors": {
      "awsExternalId": "b2882c19-861e-454b-b7db-1d706d6aea7f"
    },
    "createdAt": "2023-11-01T05:55:39.6716226Z",
    "createdBy": "henglu@microsoft.com",
    "createdByObjectId": "a4aa5b5e-8054-440c-89e7-cb31bfbc8be7",
    "endpoints": {
      "catalog": "https://acctest2590.purview.azure.com/catalog",
      "guardian": "https://acctest2590.purview.azure.com/guardian",
      "scan": "https://acctest2590.purview.azure.com/scan"
    },
    "friendlyName": "acctest2590",
    "managedEventHubState": "Enabled",
    "managedResourceGroupName": "custom-rgname",
    "managedResourcesPublicNetworkAccess": "Enabled",
    "privateEndpointConnections": [],
    "provisioningState": "Creating",
    "publicNetworkAccess": "Enabled"
  },
  "sku": {
    "capacity": 1,
    "name": "Standard"
  },
  "systemData": {
    "createdAt": "2023-11-01T05:55:39.6716226Z",
    "createdBy": "henglu@microsoft.com",
    "createdByType": "User",
    "lastModifiedAt": "2023-11-01T05:55:39.6716226Z",
    "lastModifiedBy": "henglu@microsoft.com",
    "lastModifiedByType": "User"
  },
  "type": "Microsoft.Purview/accounts"
}




GET /subscriptions/{subscription_id}/resourceGroups/acctest2590/providers/Microsoft.Purview/accounts/acctest2590?api-version=2021-12-01
Status Code: 200
------------ Request ------------
Accept: application/json
Authorization: REDACTED
User-Agent: HashiCorp Terraform/1.5.2 (+https://www.terraform.io) Terraform Plugin SDK/2.8.0 terraform-provider-azapi/dev pid-222c6c49-1b0a-5959-a213-6608f9eb8820
X-Ms-Correlation-Request-Id: 0ee954cf-ad35-42ca-84b8-d78d739ce0d6

---


------------ Response ------------
Pragma: no-cache
Server: Kestrel
Vary: Accept-Encoding
X-Ms-Ratelimit-Remaining-Subscription-Reads: 11996
X-Content-Type-Options: nosniff
X-Ms-Correlation-Request-Id: 0ee954cf-ad35-42ca-84b8-d78d739ce0d6
Cache-Control: no-cache
Content-Type: application/json; charset=utf-8
Date: Wed, 01 Nov 2023 05:59:39 GMT
Expires: -1
X-Ms-Routing-Request-Id: SOUTHEASTASIA:20231101T055939Z:ba4a89f7-a255-468f-8c3a-d08b533d4edb
Api-Supported-Versions: 2020-12-01-preview, 2021-07-01, 2021-12-01, 2023-05-01-preview
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-Ms-Account-Status: Succeeded
X-Ms-Request-Id: ba4a89f7-a255-468f-8c3a-d08b533d4edb
------
{
  "id": "/subscriptions/{subscription_id}/resourceGroups/acctest2590/providers/Microsoft.Purview/accounts/acctest2590",
  "identity": {
    "principalId": "a9b8a54a-4f20-473c-9673-d22bd6b23a2d",
    "tenantId": "72f988bf-86f1-41af-91ab-2d7cd011db47",
    "type": "SystemAssigned"
  },
  "location": "westus2",
  "name": "acctest2590",
  "properties": {
    "accountStatus": {
      "accountProvisioningState": "Succeeded"
    },
    "cloudConnectors": {
      "awsExternalId": "b2882c19-861e-454b-b7db-1d706d6aea7f"
    },
    "createdAt": "2023-11-01T05:55:39.6716226Z",
    "createdBy": "henglu@microsoft.com",
    "createdByObjectId": "a4aa5b5e-8054-440c-89e7-cb31bfbc8be7",
    "endpoints": {
      "catalog": "https://acctest2590.purview.azure.com/catalog",
      "guardian": "https://acctest2590.purview.azure.com/guardian",
      "scan": "https://acctest2590.purview.azure.com/scan"
    },
    "friendlyName": "acctest2590",
    "managedEventHubState": "Enabled",
    "managedResourceGroupName": "custom-rgname",
    "managedResources": {
      "eventHubNamespace": "/subscriptions/{subscription_id}/resourceGroups/custom-rgname/providers/Microsoft.EventHub/namespaces/Atlas-9c49e2d8-eccb-4d2e-a084-7744e470f5cc",
      "resourceGroup": "/subscriptions/{subscription_id}/resourceGroups/custom-rgname",
      "storageAccount": "/subscriptions/{subscription_id}/resourceGroups/custom-rgname/providers/Microsoft.Storage/storageAccounts/scanwestus2moghhja"
    },
    "managedResourcesPublicNetworkAccess": "Disabled",
    "privateEndpointConnections": [],
    "provisioningState": "Succeeded",
    "publicNetworkAccess": "Enabled"
  },
  "sku": {
    "capacity": 1,
    "name": "Standard"
  },
  "systemData": {
    "createdAt": "2023-11-01T05:55:39.6716226Z",
    "createdBy": "henglu@microsoft.com",
    "createdByType": "User",
    "lastModifiedAt": "2023-11-01T05:55:39.6716226Z",
    "lastModifiedBy": "henglu@microsoft.com",
    "lastModifiedByType": "User"
  },
  "type": "Microsoft.Purview/accounts"
}


```

### Links
1. [Semantic and Model Violations Reference](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/Semantic-and-Model-Violations-Reference.md)
2. [S360 action item generator for Swagger issues](https://aka.ms/swaggers360)