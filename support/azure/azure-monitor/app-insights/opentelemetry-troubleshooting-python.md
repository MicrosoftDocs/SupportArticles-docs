---
title: Troubleshoot OpenTelemetry issues in Python
description: Learn how to troubleshoot OpenTelemetry issues in Python. View known issues that involve Azure Monitor OpenTelemetry Exporters.
ms.date: 4/22/2023
ms.author: v-dele
author: DennisLee-DennisLee
editor: v-jsitser
ms.service: azure-monitor
ms.subservice: application-insights
ms.devlang: python
ms.reviewer: mmcc, lechen, aaronmax
---

# Troubleshoot OpenTelemetry issues in Python

This article discusses how to troubleshoot OpenTelemetry issues in Python.

## Troubleshooting checklist

### Step 1: Enable diagnostic logging

The Microsoft Azure Monitor Exporter uses the [Python standard logging library](https://docs.python.org/3/library/logging.html) for its internal logging. OpenTelemetry API and Azure Monitor Exporter logs are assigned a severity level of `WARNING` or `ERROR` for irregular activity. The `INFO` severity level is used for regular or successful activity.

By default, the Python logging library sets the severity level to `WARNING`. Therefore, you must change the severity level to see logs under this severity setting. The following example code shows how to output logs of all severity levels to the console and a file:

```python
...
import logging

logging.basicConfig(format = "%(asctime)s:%(levelname)s:%(message)s", level = logging.DEBUG)

logger = logging.getLogger(__name__)
file = logging.FileHandler("example.log")
stream = logging.StreamHandler()
logger.addHandler(file)
logger.addHandler(stream)
...
```

### Step 2: Test connectivity between your application host and the ingestion service

Application Insights SDKs and agents send telemetry to get ingested as REST calls at our ingestion endpoints. To test connectivity from your web server or application host computer to the ingestion service endpoints, use cURL commands or raw REST requests from PowerShell. For more information, see [Troubleshoot missing application telemetry in Azure Monitor Application Insights](investigate-missing-telemetry.md).

### Step 3: Avoid duplicate telemetry

Duplicate telemetry is often caused if you create multiple instances of processors or exporters. Make sure that you run only one exporter and processor at a time for each telemetry pillar (logs, metrics, and distributed tracing).

The following sections describe scenarios that can cause duplicate telemetry.

#### Azure Functions

When the **Always On** setting is set to **On**, Azure Functions keeps some processes running in the background after each run is complete. For instance, suppose you have a five-minute timer Function that reconfigures Azure Monitor each time. After 20 minutes, you then might have four metric exporters that are running at the same time. This situation might be the source of duplicate metrics telemetry.

In this situation, either set the **Always On** setting to **Off**, or manually shut down the providers after each Azure Function run or before extra `configure_azure_monitor` calls. To shut down each provider, run shutdown calls for each current meter, tracer, and logger provider, as shown in the following code:

```python
get_meter_provider().shutdown()
get_tracer_provider().shutdown()
get_logger_provider().shutdown()
```

#### Azure Workbooks and Jupyter Notebooks

Azure Workbooks and Jupyter Notebooks may keep exporter processes running in the background. To prevent duplicate telemetry, clear the cache before you make more calls to `configure_azure_monitor`.

## Known issues

The following items are known issues for the Azure Monitor OpenTelemetry Exporters:

- The operation name is missing from dependency telemetry. The missing operation name causes failures and adversely affects performance tab experience.

- The device model is missing from request and dependency telemetry. The missing device model adversely affects device cohort analysis.

- The database server name is missing from the dependency name. Because the database server name isn't included, OpenTelemetry Exporters incorrectly aggregate tables that have the same name onto different servers.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
