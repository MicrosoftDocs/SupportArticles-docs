---
title: Application Insights logs are missing or incorrect
description: Get answers to frequently asked questions about missing or incorrect logs for AI logs in Azure Functions.
ms.date: 08/18/2023
ms.reviewer: gasridha, v-jayaramanp
---

# Application Insights logs are missing or incorrect for Azure Function Apps

You can closely monitor your Function apps through the integration between [Azure Functions](https://azure.microsoft.com/products/functions) and Application Insights. And you can use Application Insights without any custom configuration.

If the Application Insights logs are missing or if the data appears to be partial or inaccurate, use the following steps to resolve the issue.

## Check if the Functions app is configured correctly to generate logs

The **Diagnose and Solve** option in Azure Functions App has a **Configuration checks** feature that checks the configuration for Application Insights, particularly the following:

- Only one of the connection settings Application Insights Instrumentation key `APPINSIGHTS_INSTRUMENTATIONKEY` or the `APPLICATIONINSIGHTS_CONNECTION_STRING` connection string exists. We recommend using the [APPLICATIONINSIGHTS_CONNECTION_STRING](/azure/azure-monitor/app/sdk-connection-string?tabs=net#overview) for more stable behavior. Using `APPINSIGHTS_INSTRUMENTATIONKEY` will be deprecated by 2025.
- The `AzureWebJobsDashboard` built-in logging is disabled, as recommended.
- Sampling is enabled for the Azure Functions telemetry, which is enabled by default.

> **Recommendation**: The Function app should be on version 4 and the runtime version should be at least 4.15.2xx, because from this version onwards, you can track the log flows from Azure Functions to [Application Insights](/azure/azure-monitor/app/app-insights-overview?tabs=net) service. By monitoring the log flows, you can check for missing logs.

## Logs are missing or partial

Application Insights collects log, performance, and error data. [Sampling configuration](/azure/azure-functions/configure-monitoring?tabs=v2#configure-sampling) is used to reduce the volume of telemetry. The Sampling feature is enabled by default with the settings shown in the following example. Excluded types aren't sampled.

```JSON
host.json
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
```

If you find any partially missing logs, it might be due to sampling. To find out the actual sampling rate, use an Analytics query with the required time interval as shown in the following code snippet. If you observe that the `TelemetrySavedPercentage` for any sampling type is less than 100, then that type of telemetry is being sampled.

```sql
UNION requests,dependencies,pageViews,browserTimings,exceptions,traces
| WHERE timestamp > todatetime("mm/dd/yyyy hh:mm:ss") AND timestamp < todatetime("mm/dd/yyyy hh:mm:ss")
| summarize TelemetrySavedPercentage = 100/avg(itemCount), TelemetryDroppedPercentage = 100-100/avg(itemCount) BY bin(timestamp, 1d), itemType
| sort BY timestamp asc
```

For more information, see [Data collection, retention, and storage in Application Insights](/azure/azure-monitor/app/data-retention-privacy).

## Control the volume or verbosity of the logs being written

You can increase or suppress the logs being written, by using a combination of log level and categories configured in *host.json*.

The Azure Functions logger includes a category for every log. The category indicates which part of the runtime code or your function code generated the log. For example:

- The `Host.Results` and `Function.<YOUR_FUNCTION_NAME>` are some of the available categories.
- A log level is assigned to every log. The value indicates relative importance, such as `Warning` or `Information`.

For more information, see the other [categories](/azure/azure-functions/configure-monitoring?tabs=v2#configure-categories) and [log levels](/azure/azure-functions/configure-monitoring?tabs=v2#configure-log-levels) available.

You can configure how your application should write the logs by following the sample code snippet:

```JSON
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
```

To configure these values at the App settings level (to avoid redeployment on *host.json* changes), override specific *host.json* values by creating an equivalent value as an application setting. For more information, see [Override host.json values](/azure/azure-functions/functions-host-json#override-hostjson-values).

For more examples about how to suppress logs, see [functions-log-suppression](https://github.com/anthonychu/functions-log-suppression).

## My Function app that's integrated with VNet isn't generating logs

You must open port 443 for outgoing traffic in your server's firewall to allow the Application Insights SDK or Application Insights Agent to send data to the portal for the following URLs:

- *dc.applicationinsights.azure.com*
- *dc.applicationinsights.microsoft.com*
- *dc.services.visualstudio.com*
- **.in.applicationinsights.azure.com*

For more information, see [IP addresses used by Azure Monitor](/azure/azure-monitor/app/ip-addresses#outgoing-ports).

[!INCLUDE [support-disclaimer](../../../includes/support-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
