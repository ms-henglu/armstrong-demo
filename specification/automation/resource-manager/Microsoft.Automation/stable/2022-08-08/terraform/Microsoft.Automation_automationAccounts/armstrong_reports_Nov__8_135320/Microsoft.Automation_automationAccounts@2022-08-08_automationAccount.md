## Microsoft.Automation/automationAccounts@2022-08-08 - ROUNDTRIP_INCONSISTENT_PROPERTY

### Description

I found differences between PUT request body and GET response:

- .properties.sku.name: expect Free, but got Basic

```json
{
    "properties": {
        "sku": {
            "name": Got "Basic" in response, expect "Free"
        }
    }
}
```

### Details

1. ARM Fully-Qualified Resource Type
```
Microsoft.Automation/automationAccounts
```

2. API Version
```
2022-08-08
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
PUT /subscriptions/{subscription_id}/resourceGroups/acctest3106/providers/Microsoft.Automation/automationAccounts/acctest3106?api-version=2022-08-08
Status Code: 200
------------ Request ------------
X-Ms-Correlation-Request-Id: 33360ef2-c3c4-490c-1aa7-4dc8e697d8e6
Accept: application/json
Authorization: REDACTED
Content-Length: 59
Content-Type: application/json
User-Agent: HashiCorp Terraform/1.5.2 (+https://www.terraform.io) Terraform Plugin SDK/2.8.0 terraform-provider-azapi/v1.10.0 pid-222c6c49-1b0a-5959-a213-6608f9eb8820

---
{
  "location": "eastus2",
  "properties": {
    "sku": {
      "name": "Free"
    }
  }
}

------------ Response ------------
Cache-Control: no-cache
Content-Type: application/json; charset=utf-8
Date: Wed, 08 Nov 2023 05:53:11 GMT
X-Content-Type-Options: nosniff
X-Ms-Ratelimit-Remaining-Subscription-Writes: 1199
Expires: -1
Pragma: no-cache
Server: Microsoft-HTTPAPI/2.0
Strict-Transport-Security: max-age=31536000; includeSubDomains
Vary: Accept-Encoding
X-Ms-Correlation-Request-Id: 33360ef2-c3c4-490c-1aa7-4dc8e697d8e6
X-Ms-Request-Id: 69213657-ca8a-4526-b4c6-df50e811bf60
X-Ms-Routing-Request-Id: SOUTHEASTASIA:20231108T055312Z:1934169a-6685-43f6-ab15-37cd1834a3d2
------
{
  "etag": null,
  "id": "/subscriptions/{subscription_id}/resourceGroups/acctest3106/providers/Microsoft.Automation/automationAccounts/acctest3106",
  "location": "eastus2",
  "name": "acctest3106",
  "properties": {
    "RegistrationUrl": "https://275b6946-d66d-44f9-b5c4-ac619c827973.agentsvc.eus2.azure-automation.net/accounts/275b6946-d66d-44f9-b5c4-ac619c827973",
    "RuntimeConfiguration": {
      "powershell": {
        "builtinModules": {
          "Az": "8.0.0"
        }
      },
      "powershell7": {
        "builtinModules": {
          "Az": "8.0.0"
        }
      },
      "powershell72": {
        "builtinModules": {
          "Az": "8.3.0"
        }
      }
    },
    "automationHybridServiceUrl": "https://275b6946-d66d-44f9-b5c4-ac619c827973.jrds.eus2.azure-automation.net/automationAccounts/275b6946-d66d-44f9-b5c4-ac619c827973",
    "creationTime": "2023-11-08T05:48:26.273+00:00",
    "disableLocalAuth": false,
    "encryption": {
      "identity": {
        "userAssignedIdentity": null
      },
      "keySource": "Microsoft.Automation"
    },
    "lastModifiedBy": null,
    "lastModifiedTime": "2023-11-08T05:53:12.08+00:00",
    "sku": {
      "capacity": null,
      "family": null,
      "name": "Basic"
    },
    "state": "Ok"
  },
  "systemData": {
    "createdAt": "2023-11-08T05:48:26.273+00:00",
    "lastModifiedAt": "2023-11-08T05:53:12.08+00:00"
  },
  "tags": {},
  "type": "Microsoft.Automation/AutomationAccounts"
}




GET /subscriptions/{subscription_id}/resourceGroups/acctest3106/providers/Microsoft.Automation/automationAccounts/acctest3106?api-version=2022-08-08
Status Code: 200
------------ Request ------------
Accept: application/json
Authorization: REDACTED
User-Agent: HashiCorp Terraform/1.5.2 (+https://www.terraform.io) Terraform Plugin SDK/2.8.0 terraform-provider-azapi/v1.10.0 pid-222c6c49-1b0a-5959-a213-6608f9eb8820
X-Ms-Correlation-Request-Id: 84c147a6-6260-be7c-b303-05adf4190134

---


------------ Response ------------
X-Ms-Request-Id: b33a35eb-3079-4eee-bc3f-07fbf08bfb43
Ocp-Automation-Accountid: 275b6946-d66d-44f9-b5c4-ac619c827973
X-Ms-Correlation-Request-Id: 84c147a6-6260-be7c-b303-05adf4190134
X-Ms-Ratelimit-Remaining-Subscription-Reads: 11997
X-Ms-Routing-Request-Id: SOUTHEASTASIA:20231108T055320Z:8dc461a5-1385-4038-9621-aa14ac232d3c
Cache-Control: no-cache
Date: Wed, 08 Nov 2023 05:53:20 GMT
Vary: Accept-Encoding
Content-Type: application/json; charset=utf-8
Expires: -1
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-Content-Type-Options: nosniff
Pragma: no-cache
Server: Microsoft-HTTPAPI/2.0
------
{
  "etag": null,
  "id": "/subscriptions/{subscription_id}/resourceGroups/acctest3106/providers/Microsoft.Automation/automationAccounts/acctest3106",
  "location": "eastus2",
  "name": "acctest3106",
  "properties": {
    "RegistrationUrl": "https://275b6946-d66d-44f9-b5c4-ac619c827973.agentsvc.eus2.azure-automation.net/accounts/275b6946-d66d-44f9-b5c4-ac619c827973",
    "RuntimeConfiguration": {
      "powershell": {
        "builtinModules": {
          "Az": "8.0.0"
        }
      },
      "powershell7": {
        "builtinModules": {
          "Az": "8.0.0"
        }
      },
      "powershell72": {
        "builtinModules": {
          "Az": "8.3.0"
        }
      }
    },
    "automationHybridServiceUrl": "https://275b6946-d66d-44f9-b5c4-ac619c827973.jrds.eus2.azure-automation.net/automationAccounts/275b6946-d66d-44f9-b5c4-ac619c827973",
    "creationTime": "2023-11-08T05:48:26.273+00:00",
    "disableLocalAuth": false,
    "encryption": {
      "identity": {
        "userAssignedIdentity": null
      },
      "keySource": "Microsoft.Automation"
    },
    "lastModifiedBy": null,
    "lastModifiedTime": "2023-11-08T05:53:12.08+00:00",
    "privateEndpointConnections": [],
    "sku": {
      "capacity": null,
      "family": null,
      "name": "Basic"
    },
    "state": "Ok"
  },
  "systemData": {
    "createdAt": "2023-11-08T05:48:26.273+00:00",
    "lastModifiedAt": "2023-11-08T05:53:12.08+00:00"
  },
  "tags": {},
  "type": "Microsoft.Automation/AutomationAccounts"
}


```

### Links
1. [Semantic and Model Violations Reference](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/Semantic-and-Model-Violations-Reference.md)
2. [S360 action item generator for Swagger issues](https://aka.ms/swaggers360)