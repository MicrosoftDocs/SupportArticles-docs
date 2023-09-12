---
title: Troubleshoot OpenTelemetry issues in Node.js
description: Learn how to troubleshoot OpenTelemetry issues in Node.js. View known issues that involve Azure Monitor OpenTelemetry Exporters.
ms.date: 04/07/2023
editor: v-jsitser
ms.service: azure-monitor
ms.subservice: application-insights
ms.devlang: javascript, typescript
ms.reviewer: mmcc, lechen, aaronmax, v-leedennis
---

# Troubleshoot OpenTelemetry issues in Node.js

This article discusses how to troubleshoot OpenTelemetry issues in Node.js.

## Troubleshooting checklist

### Step 1: Enable diagnostic logging

Azure Monitor Exporter uses the OpenTelemetry API logger for internal logs. To enable the logger, run the following code snippet:

```javascript
const { diag, DiagConsoleLogger, DiagLogLevel } = require("@opentelemetry/api");
const { NodeTracerProvider } = require("@opentelemetry/sdk-trace-node");

const provider = new NodeTracerProvider();
diag.setLogger(new DiagConsoleLogger(), DiagLogLevel.ALL);
provider.register();
```

### Step 2: Test connectivity between your application host and the ingestion service

Application Insights SDKs and agents send telemetry to get ingested as REST calls at our ingestion endpoints. To test connectivity from your web server or application host computer to the ingestion service endpoints, use cURL commands or raw REST requests from PowerShell. For more information, see [Troubleshoot missing application telemetry in Azure Monitor Application Insights](investigate-missing-telemetry.md).

## Known issues

The following items are known issues for the Azure Monitor OpenTelemetry Exporters:

- The operation name is missing from dependency telemetry. The missing operation name causes failures and adversely affects performance tab experience.

- The device model is missing from request and dependency telemetry. The missing device model adversely affects device cohort analysis.

- The database server name is missing from the dependency name. Because the database server name isn't included, OpenTelemetry Exporters incorrectly aggregate tables that have the same name onto different servers.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
