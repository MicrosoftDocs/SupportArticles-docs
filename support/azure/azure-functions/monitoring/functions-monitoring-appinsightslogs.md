---
title: Application Insights logs are missing or incorrect
description: Get answers to frequently asked questions about missing or incorrect logs for AI logs in Azure Functions.
ms.date: 08/15/2023
ms.reviewer: gasridha
---
# Application Insights logs are missing or incorrect for Azure Function apps

Azure Functions(https://azure.microsoft.com/products/functions) integrates with Application Insights to enable you to more closely monitor your function apps. You can use Application Insights without any custom configuration. 

If the Application insights logs are missing, or if the data appears to be partial or inaccurate, use the following steps to help resolve the issue.

[!INCLUDE [support-disclaimer](../../../includes/support-disclaimer.md)]

## How can I check if my Function app is configured correctly to emit logs ??

The **Diagnose and Solve** blade for Azure Functions has a **Function Configuration checks** detector that checks the configuration for Application Insights, particularly the following:

* Only one of the connection settings Application Insights Instrumentation key **"APPINSIGHTS_INSTRUMENTATIONKEY"** or Connection String "APPLICATIONINSIGHTS_CONNECTION_STRING" exists. We recommend using the [APPLICATIONINSIGHTS_CONNECTION_STRING](/azure/azure-monitor/app/sdk-connection-string?tabs=net#overview) for more stable behavior. Using `APPINSIGHTS_INSTRUMENTATIONKEY` will be deprecated by 2025.
* The `AzureWebJobsDashboard` built-in logging is disabled, as recommended.
* Sampling is enabled for the Azure Functions telemetry (enabled by default).

> **Recommendation**: The function app should be on V4 and the runtime version should be at least 4.15.2xx, because from this version on, the capability to track logs flow from Azure Functions to Application Insights service is present. By tracking log flows, you can diagnose why logs are missing.

## Why are the logs missing or partial ? What is sampling ?

Application Insights collects log, performance, and error data. [Sampling configuration](/azure/azure-functions/configure-monitoring?tabs=v2#configure-sampling) can be used to reduce the volume of telemetry. **Sampling is enabled by default** with the settings shown in the example below. Excluded types are not sampled.

~~~host.json
{
  "logging": {
    "applicationInsights": {
      "samplingSettings": {
        "isEnabled": true,
        "maxTelemetryItemsPerSecond" : 20,
        "excludedTypes": "Request;Exception"
      }
    }
  }
}
~~~

If you observe partially missing logs, this is probably due to sampling. To discover the actual sampling rate, no matter where it has been applied, use an Analytics query like the example below, with the time interval needed. If you see that the `TelemetrySavedPercentage` for any type is less than 100, then that type of telemetry is being sampled. 

~~~Analytics query
union requests,dependencies,pageViews,browserTimings,exceptions,traces
| where timestamp > todatetime("mm/dd/yyyy hh:mm:ss") and  timestamp < todatetime("mm/dd/yyyy hh:mm:ss")
| summarize TelemetrySavedPercentage = 100/avg(itemCount), TelemetryDroppedPercentage = 100-100/avg(itemCount) by bin(timestamp, 1d), itemType
| sort by timestamp asc
~~~

For more information, see [Data collection, retention, and storage in Application Insights](/azure/azure-monitor/app/data-retention-privacy).

## How can I control the volume or verbosity of the logs being written ?

By using a combination of log level and categories configured in host.json, you can increase or suppress the logs being written. 

The Azure Functions logger includes a category for every log. The category indicates which part of the runtime code or your function code wrote the log. 
- For example, `Host.Results` and `Function.<YOUR_FUNCTION_NAME>` are some of the  available categories.
- A log level is assigned to every log. The value indicates relative importance, such as `Warning` or `Information".

For more information, see the other [categories](/azure/azure-functions/configure-monitoring?tabs=v2#configure-categories) and [log levels](/azure/azure-functions/configure-monitoring?tabs=v2#configure-log-levels) available.

See the following host.json sample below, with associated details. You can following this sample to configure how your application should write the logs.

~~~host.json sample
{
  "version": "2.0",  
  "logging": {
    "logLevel": {
      "default": "Information", // catch all default, with modifications below for individual categories.
      "Function": "Warning", // Warning level from all Functions (except the ones configured below).
      "Host.Aggregator": "Trace", // Log all traces in the 'customMetrics' table of (and shown on Metrics/Alerts blade in AI) - use either this or Host.Results
      "Host.Results": "Error", // Error and Critical requests are only logged in the 'requests' table of the AI (and shown on Monitor Functions blade in Function App) - use either this or Host.Aggregator
      "Function.Function1": "Information", //Information level logs from Function 1, logged in 'traces', 'dependencies' and 'customMetrics' tables of AI
      "Function.Function2.User": "Information" //user code logs from Function2, logged in 'traces' table of AI 
    },
    "applicationInsights": {
      "samplingSettings": {
        "isEnabled": true,
        "maxTelemetryItemsPerSecond": 1,
        "excludedTypes": "Exception"
      }
    }
  }
} 
~~~

To configure these values at the App settings level (to avoid redeployment on host.json changes), you can override specific host.json values by creating an equivalent value as an application setting. For more information, see [Override host.json values](/azure/azure-functions/functions-host-json#override-hostjson-values).

For more examples of how to suppress logs, see this GitHub documentation: [functions-log-suppression](https://github.com/anthonychu/functions-log-suppression).

## Why is my Function app that's integrated with VNet not generating logs?

You need to open port 443 for outgoing traffic in your server's firewall to allow the Application Insights SDK or Application Insights Agent to send data to the portal for these URLs:
* dc.applicationinsights.azure.com
* dc.applicationinsights.microsoft.com
* dc.services.visualstudio.com
* *.in.applicationinsights.azure.com

For more information, see [IP addresses used by Azure Monitor](/azure/azure-monitor/app/ip-addresses#outgoing-ports).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
