---
title: Troubleshoot OpenTelemetry issues in Python
description: Learn how to troubleshoot OpenTelemetry issues in Python. View known issues that involve Azure Monitor OpenTelemetry Exporters.
ms.date: 05/22/2023
editor: v-jsitser
ms.service: azure-monitor
ms.subservice: application-insights
ms.devlang: python
ms.reviewer: mmcc, lechen, aaronmax, v-leedennis
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

#### Duplicate trace logs in Azure Functions

If you see a pair of entries for each trace log within Application Insights, you probably enabled the following types of logging instrumentation:

- The native logging instrumentation in Azure Functions
- The `azure-monitor-opentelemetry` logging instrumentation within the distribution

To prevent duplication, you can disable the distribution's logging, but leave the native logging instrumentation in Azure Functions enabled. To do this, set the `OTEL_LOGS_EXPORTER` environment variable to `None`.

#### Duplicate telemetry in "Always On" Azure Functions

If the **Always On** setting in Azure Functions is set to **On**, Azure Functions keeps some processes running in the background after each run is complete. For instance, suppose that you have a five-minute timer function that calls `configure_azure_monitor` each time. After 20 minutes, you then might have four metric exporters that are running at the same time. This situation might be the source of your duplicate metrics telemetry.

In this situation, either set the **Always On** setting to **Off**, or try manually shutting down the providers between each `configure_azure_monitor` call. To shut down each provider, run shutdown calls for each current meter, tracer, and logger provider, as shown in the following code:

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
