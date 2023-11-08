## Microsoft.Insights/dataCollectionRules@2022-06-01 - Error

### Description

I found an error when creating this resource:

```bash
 "Resource: (ResourceId \"/subscriptions/{subscription_id}/resourceGroups/acctest8801/providers/Microsoft.Insights/dataCollectionRules/acctest8801\" / Api Version \"2022-06-01\")": PUT https://management.azure.com/subscriptions/{subscription_id}/resourceGroups/acctest8801/providers/Microsoft.Insights/dataCollectionRules/acctest8801
--------------------------------------------------------------------------------
RESPONSE 400: 400 Bad Request
ERROR CODE: InvalidPayload
--------------------------------------------------------------------------------
{
  "error": {
    "code": "InvalidPayload",
    "message": "Data collection rule is invalid",
    "details": [
      {
        "code": "InvalidDataSource",
        "message": "'X Path Queries' must not be empty.",
        "target": "Properties.DataSources.WindowsEventLogs[0].XPathQueries"
      },
      {
        "code": "InvalidDataSource",
        "message": "'X Path Queries' item count should be 1 or more. Specified list has 0 items.",
        "target": "Properties.DataSources.WindowsEventLogs[0].XPathQueries"
      }
    ]
  }
}
--------------------------------------------------------------------------
```

### Details

1. ARM Fully-Qualified Resource Type
```
Microsoft.Insights/dataCollectionRules
```

2. API Version
```
2022-06-01
```

3. Swagger issue type
```
Other
```

4. OperationId
```
TODO
```

5. Swagger GitHub permalink
```
TODO, 
e.g., https://github.com/Azure/azure-rest-api-specs/blob/60723d13309c8f8060d020a7f3dd9d6e380f0bbd
/specification/compute/resource-manager/Microsoft.Compute/stable/2020-06-01/compute.json#L9065-L9101
```

6. Error code
```
TODO
```

7. Request traces
```
GET /subscriptions/{subscription_id}/resourceGroups/acctest8801/providers/Microsoft.Insights/dataCollectionRules/acctest8801?api-version=2022-06-01
Status Code: 404
------------ Request ------------
Authorization: REDACTED
User-Agent: HashiCorp Terraform/1.5.2 (+https://www.terraform.io) Terraform Plugin SDK/2.8.0 terraform-provider-azapi/v1.10.0 pid-222c6c49-1b0a-5959-a213-6608f9eb8820
X-Ms-Correlation-Request-Id: e4854079-42b8-8aaa-9d6a-b0db03647c4c
Accept: application/json

---


------------ Response ------------
Content-Length: 233
Content-Type: application/json; charset=utf-8
Date: Wed, 08 Nov 2023 06:08:29 GMT
Pragma: no-cache
X-Content-Type-Options: nosniff
X-Ms-Request-Id: e1c562fe-d400-4f2e-9c0a-254f6016411d
X-Ms-Routing-Request-Id: SOUTHEASTASIA:20231108T060829Z:e1c562fe-d400-4f2e-9c0a-254f6016411d
Cache-Control: no-cache
Expires: -1
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-Ms-Correlation-Request-Id: e4854079-42b8-8aaa-9d6a-b0db03647c4c
X-Ms-Failure-Cause: gateway
------
{
  "error": {
    "code": "ResourceNotFound",
    "message": "The Resource 'Microsoft.Insights/dataCollectionRules/acctest8801' under resource group 'acctest8801' was not found. For more details please go to https://aka.ms/ARMResourceNotFoundFix"
  }
}




PUT /subscriptions/{subscription_id}/resourceGroups/acctest8801/providers/Microsoft.Insights/dataCollectionRules/acctest8801?api-version=2022-06-01
Status Code: 400
------------ Request ------------
Accept: application/json
Authorization: REDACTED
Content-Length: 1424
Content-Type: application/json
User-Agent: HashiCorp Terraform/1.5.2 (+https://www.terraform.io) Terraform Plugin SDK/2.8.0 terraform-provider-azapi/v1.10.0 pid-222c6c49-1b0a-5959-a213-6608f9eb8820
X-Ms-Correlation-Request-Id: e4854079-42b8-8aaa-9d6a-b0db03647c4c

---
{
  "location": "eastus",
  "properties": {
    "dataFlows": [
      {
        "destinations": [
          "centralWorkspace"
        ],
        "streams": [
          "Microsoft-Perf",
          "Microsoft-Syslog",
          "Microsoft-WindowsEvent"
        ]
      }
    ],
    "dataSources": {
      "performanceCounters": [
        {
          "counterSpecifiers": [
            "\\Processor(_Total)\\% Processor Time",
            "\\Memory\\Committed Bytes",
            "\\LogicalDisk(_Total)\\Free Megabytes",
            "\\PhysicalDisk(_Total)\\Avg. Disk Queue Length"
          ],
          "name": "cloudTeamCoreCounters",
          "samplingFrequencyInSeconds": 15,
          "streams": [
            "Microsoft-Perf"
          ]
        },
        {
          "counterSpecifiers": [
            "\\Process(_Total)\\Thread Count"
          ],
          "name": "appTeamExtraCounters",
          "samplingFrequencyInSeconds": 30,
          "streams": [
            "Microsoft-Perf"
          ]
        }
      ],
      "syslog": [
        {
          "facilityNames": [
            "cron"
          ],
          "logLevels": [
            "Debug",
            "Critical",
            "Emergency"
          ],
          "name": "cronSyslog",
          "streams": [
            "Microsoft-Syslog"
          ]
        },
        {
          "facilityNames": [
            "syslog"
          ],
          "logLevels": [
            "Alert",
            "Critical",
            "Emergency"
          ],
          "name": "syslogBase",
          "streams": [
            "Microsoft-Syslog"
          ]
        }
      ],
      "windowsEventLogs": [
        {
          "name": "cloudSecurityTeamEvents",
          "streams": [
            "Microsoft-WindowsEvent"
          ],
          "xPathQueries": []
        },
        {
          "name": "appTeam1AppEvents",
          "streams": [
            "Microsoft-WindowsEvent"
          ],
          "xPathQueries": [
            "System![System[(Level = 1 or Level = 2 or Level = 3)]]",
            "Application!*[System[(Level = 1 or Level = 2 or Level = 3)]]"
          ]
        }
      ]
    },
    "destinations": {
      "logAnalytics": [
        {
          "name": "centralWorkspace",
          "workspaceResourceId": "/subscriptions/{subscription_id}/resourceGroups/acctest8801/providers/Microsoft.OperationalInsights/workspaces/acctest8801"
        }
      ]
    }
  }
}

------------ Response ------------
Expires: -1
Content-Length: 420
X-Ms-Client-Request-Id: 4b574a0e-ba91-44a9-bec4-68cd50f21c60
X-Ms-Correlation-Request-Id: e4854079-42b8-8aaa-9d6a-b0db03647c4c
Cache-Control: no-cache
Content-Type: application/json
Pragma: no-cache
Server: Microsoft-HTTPAPI/2.0
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-Ms-Ratelimit-Remaining-Subscription-Resource-Requests: 149
X-Ms-Routing-Request-Id: SOUTHEASTASIA:20231108T060827Z:ce969355-1946-4b74-b940-59507448efb4
Api-Supported-Versions: 2019-11-01-preview, 2021-04-01, 2021-09-01-preview, 2022-06-01, 2023-03-11
Date: Wed, 08 Nov 2023 06:08:29 GMT
Request-Context: appId=cid-v1:2bbfbac8-e1b0-44af-b9c6-3a40669d37e3
X-Content-Type-Options: nosniff
X-Ms-Request-Id: 3336e395-82ce-4763-9502-55f1f7fcee83
------
{
  "error": {
    "code": "InvalidPayload",
    "details": [
      {
        "code": "InvalidDataSource",
        "message": "'X Path Queries' must not be empty.",
        "target": "Properties.DataSources.WindowsEventLogs[0].XPathQueries"
      },
      {
        "code": "InvalidDataSource",
        "message": "'X Path Queries' item count should be 1 or more. Specified list has 0 items.",
        "target": "Properties.DataSources.WindowsEventLogs[0].XPathQueries"
      }
    ],
    "message": "Data collection rule is invalid"
  }
}




GET /subscriptions/{subscription_id}/resourceGroups/acctest8801/providers/Microsoft.Insights/dataCollectionRules/acctest8801?api-version=2022-06-01
Status Code: 404
------------ Request ------------
Accept: application/json
Authorization: REDACTED
User-Agent: HashiCorp Terraform/1.5.2 (+https://www.terraform.io) Terraform Plugin SDK/2.8.0 terraform-provider-azapi/v1.10.0 pid-222c6c49-1b0a-5959-a213-6608f9eb8820
X-Ms-Correlation-Request-Id: e4854079-42b8-8aaa-9d6a-b0db03647c4c

---


------------ Response ------------
Content-Type: application/json; charset=utf-8
Date: Wed, 08 Nov 2023 06:08:25 GMT
Expires: -1
Pragma: no-cache
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-Ms-Correlation-Request-Id: e4854079-42b8-8aaa-9d6a-b0db03647c4c
X-Ms-Request-Id: cac2d79c-56f0-425d-9035-d53e3a7aaa81
Cache-Control: no-cache
X-Content-Type-Options: nosniff
X-Ms-Failure-Cause: gateway
X-Ms-Routing-Request-Id: SOUTHEASTASIA:20231108T060826Z:cac2d79c-56f0-425d-9035-d53e3a7aaa81
Content-Length: 233
------
{
  "error": {
    "code": "ResourceNotFound",
    "message": "The Resource 'Microsoft.Insights/dataCollectionRules/acctest8801' under resource group 'acctest8801' was not found. For more details please go to https://aka.ms/ARMResourceNotFoundFix"
  }
}





```

### Links
1. [Semantic and Model Violations Reference](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/Semantic-and-Model-Violations-Reference.md)
2. [S360 action item generator for Swagger issues](https://aka.ms/swaggers360)