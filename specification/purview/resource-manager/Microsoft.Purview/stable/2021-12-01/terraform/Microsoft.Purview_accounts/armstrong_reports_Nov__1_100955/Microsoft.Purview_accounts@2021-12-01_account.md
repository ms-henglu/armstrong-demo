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
Content-Type: application/json
User-Agent: HashiCorp Terraform/1.5.2 (+https://www.terraform.io) Terraform Plugin SDK/2.8.0 terraform-provider-azapi/dev pid-222c6c49-1b0a-5959-a213-6608f9eb8820
X-Ms-Correlation-Request-Id: 989080b2-107f-b596-c425-c11cb215470d
Accept: application/json
Authorization: REDACTED
Content-Length: 198

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
Server: Kestrel
X-Ms-Account-Status: Creating
X-Ms-Correlation-Request-Id: 989080b2-107f-b596-c425-c11cb215470d
Api-Supported-Versions: 2020-12-01-preview, 2021-07-01, 2021-12-01, 2023-05-01-preview
Content-Length: 1340
Content-Type: application/json; charset=utf-8
Pragma: no-cache
Date: Wed, 01 Nov 2023 02:05:53 GMT
Expires: -1
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-Ms-Routing-Request-Id: SOUTHEASTASIA:20231101T020553Z:8b6d99c8-6c49-4a17-b5ac-4b6810e6ed7d
Location: https://management.azure.com/subscriptions/{subscription_id}/resourceGroups/acctest2590/providers/Microsoft.Purview/accounts/acctest2590?api-version=2021-12-01
Cache-Control: no-cache
X-Content-Type-Options: nosniff
X-Ms-Ratelimit-Remaining-Subscription-Writes: 1197
X-Ms-Request-Id: 8b6d99c8-6c49-4a17-b5ac-4b6810e6ed7d
------
{
  "id": "/subscriptions/{subscription_id}/resourceGroups/acctest2590/providers/Microsoft.Purview/accounts/acctest2590",
  "identity": {
    "principalId": "cfb07280-8932-46bc-87e7-2c721d8efae5",
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
      "awsExternalId": "7fa3c0e7-f9e8-43bc-9b14-d94f451f0de1"
    },
    "createdAt": "2023-11-01T02:05:45.6208617Z",
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
    "createdAt": "2023-11-01T02:05:45.6208617Z",
    "createdBy": "henglu@microsoft.com",
    "createdByType": "User",
    "lastModifiedAt": "2023-11-01T02:05:45.6208617Z",
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
X-Ms-Correlation-Request-Id: 977e3947-431c-0fb8-c86e-94101995ee93

---


------------ Response ------------
Vary: Accept-Encoding
Expires: -1
X-Content-Type-Options: nosniff
X-Ms-Request-Id: bfff2aa8-a95c-4d70-88b5-4ed6d58422b9
X-Ms-Routing-Request-Id: SOUTHEASTASIA:20231101T020955Z:bfff2aa8-a95c-4d70-88b5-4ed6d58422b9
Api-Supported-Versions: 2020-12-01-preview, 2021-07-01, 2021-12-01, 2023-05-01-preview
Date: Wed, 01 Nov 2023 02:09:54 GMT
X-Ms-Correlation-Request-Id: 977e3947-431c-0fb8-c86e-94101995ee93
X-Ms-Ratelimit-Remaining-Subscription-Reads: 11996
Cache-Control: no-cache
Content-Type: application/json; charset=utf-8
Pragma: no-cache
Server: Kestrel
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-Ms-Account-Status: Succeeded
------
{
  "id": "/subscriptions/{subscription_id}/resourceGroups/acctest2590/providers/Microsoft.Purview/accounts/acctest2590",
  "identity": {
    "principalId": "cfb07280-8932-46bc-87e7-2c721d8efae5",
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
      "awsExternalId": "7fa3c0e7-f9e8-43bc-9b14-d94f451f0de1"
    },
    "createdAt": "2023-11-01T02:05:45.6208617Z",
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
      "eventHubNamespace": "/subscriptions/{subscription_id}/resourceGroups/custom-rgname/providers/Microsoft.EventHub/namespaces/Atlas-0a7fb156-235f-4ff6-9b9c-2d52558344ae",
      "resourceGroup": "/subscriptions/{subscription_id}/resourceGroups/custom-rgname",
      "storageAccount": "/subscriptions/{subscription_id}/resourceGroups/custom-rgname/providers/Microsoft.Storage/storageAccounts/scanwestus2ojcghku"
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
    "createdAt": "2023-11-01T02:05:45.6208617Z",
    "createdBy": "henglu@microsoft.com",
    "createdByType": "User",
    "lastModifiedAt": "2023-11-01T02:05:45.6208617Z",
    "lastModifiedBy": "henglu@microsoft.com",
    "lastModifiedByType": "User"
  },
  "type": "Microsoft.Purview/accounts"
}


```

### Links
1. [Semantic and Model Violations Reference](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/Semantic-and-Model-Violations-Reference.md)
2. [S360 action item generator for Swagger issues](https://aka.ms/swaggers360)