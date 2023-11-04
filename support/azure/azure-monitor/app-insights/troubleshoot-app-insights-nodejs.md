---
title: Troubleshoot App Insights monitoring of Node.js apps and services
description: Learn techniques for troubleshooting issues that are related to the Application Insights monitoring of Node.js applications and services.
ms.date: 11/03/2023
author: nzamoralopez
ms.author: nzamoralopez
ms.reviewer: ashisunnam, aaronmax, v-leedennis
editor: v-jsitser
ms.service: azure-monitor
ms.subservice: application-insights
ms.topic: troubleshooting-general
---
# Troubleshoot Application Insights monitoring of Node.js apps and services

This article discusses troubleshooting steps to fix general problems that are related to the Application Insights monitoring of Node.js apps and services.

## Troubleshooting checklist

### Troubleshooting step 1: Test connectivity between your application host and the ingestion service

Application Insights SDKs and agents send telemetry to be ingested as REST calls to our ingestion endpoints. To test connectivity from your web server or application host computer to the ingestion service endpoints, use raw REST clients from PowerShell or run [curl](https://curl.se) commands. For more information, see [Troubleshoot missing application telemetry in Azure Monitor Application Insights](./investigate-missing-telemetry.md).

### Troubleshooting step 2: Set up self-diagnostics

"Self-diagnostics" refers to internal logging entries from the [Application Insights Node.js SDK](/azure/azure-monitor/app/nodejs).

To identify and diagnose issues that affect Application Insights, you can enable "self-diagnostics." Self-diagnostics is the collection of internal logging entries from the Application Insights Node.js SDK.

By default, the Application Insights Node.js SDK logs to the console at the warning level. The following code demonstrates how to enable debug logging and generate telemetry for internal logs:

```nodejs
let appInsights = require("applicationinsights");
appInsights.setup("<Your-Connection-String>")
    .setInternalLogging(true, true)    // Enable both debug and warning logging.
    .setAutoCollectConsole(true, true) // Generate trace telemetry for winston, bunyan, and console logs.
    .start();
```

There are also several environment variables that you can use to set up your self-diagnostic configuration.

You can enable debug logs by configuring the `APPLICATION_INSIGHTS_ENABLE_DEBUG_LOGS` environment variable. To disable warnings, configure the `APPLICATION_INSIGHTS_DISABLE_WARNING_LOGS` environment variable.

You can put logs into a local file by configuring the `APPLICATIONINSIGHTS_LOG_DESTINATION` environment variable. The supported values are `file` and `file+console`. By default, a file named *applicationinsights.log* is generated within a temporary directory, and it includes all log entries. The temporary directory is named and located according to the following table.

| Operating system | Directory location              |
|------------------|---------------------------------|
| Unix/Linux       | */tmp*                          |
| Windows          | *USERDIR\\AppData\\Local\\Temp* |

You can configure a specific location for the log directory (instead of the temporary directory) by configuring the `APPLICATIONINSIGHTS_LOGDIR` environment variable.

The following code shows how to configure the self-diagnostic settings for the log directory in Node.js:

```nodejs
process.env.APPLICATIONINSIGHTS_LOG_DESTINATION = "file";
process.env.APPLICATIONINSIGHTS_LOGDIR = "C:\\applicationinsights\\logs"

// Application Insights SDK setup code follows.
```

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
