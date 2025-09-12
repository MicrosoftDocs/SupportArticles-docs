---
title: Troubleshoot OpenTelemetry issues in Python
description: Learn how to troubleshoot OpenTelemetry issues in Python. View known issues that involve Azure Monitor OpenTelemetry Exporters.
ms.date: 10/28/2024
editor: v-jsitser
ms.service: azure-monitor
ms.devlang: python
ms.reviewer: azuremacic, jeremyvoss, mmcc, lechen, aaronmax, v-leedennis
ms.custom: sap:Missing or Incorrect data after enabling Application Insights in Azure Portal
---

# Troubleshoot OpenTelemetry issues in Python

This article discusses how to troubleshoot OpenTelemetry issues in Python.

## Troubleshooting checklist

### Enable diagnostic logging

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

### Test connectivity between your application host and the ingestion service

Application Insights SDKs and agents send telemetry to get ingested as REST calls at our ingestion endpoints. To test connectivity from your web server or application host computer to the ingestion service endpoints, use cURL commands or raw REST requests from PowerShell. For more information, see [Troubleshoot missing application telemetry in Azure Monitor Application Insights](../investigate-missing-telemetry.md).

### Avoid duplicate telemetry

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

Azure Workbooks and Jupyter Notebooks might keep exporter processes running in the background. To prevent duplicate telemetry, clear the cache before you make more calls to `configure_azure_monitor`.

### Missing Requests telemetry from FastAPI or Flask apps

If you are missing Requests table data but not other categories of data, your HTTP framework might not be instrumented correctly. This issue can occur in FastAPI and Flask apps using the [Azure Monitor OpenTelemetry Distro client library for Python](/python/api/overview/azure/monitor-opentelemetry-readme) if you don't structure your `import` declarations correctly. You might be importing the `fastapi.FastAPI` or `flask.Flask` respectively before you call the `configure_azure_monitor` function to instrument the FastAPI and Flask libraries. For example, the following code doesn't successfully instrument the FastAPI and Flask apps:

```python
# FastAPI

from azure.monitor.opentelemetry import configure_azure_monitor
from fastapi import FastAPI

configure_azure_monitor()

app = FastAPI()
```

```python
# Flask

from azure.monitor.opentelemetry import configure_azure_monitor
from flask import Flask

configure_azure_monitor()

app = Flask(__name__)
```

Instead, we recommend that you import the `fastapi` or `flask` modules as a whole, and then call `configure_azure_monitor` to configure OpenTelemetry to use Azure Monitor before you access `fastapi.FastAPI` or `flask.Flask`:

```python
# FastAPI

from azure.monitor.opentelemetry import configure_azure_monitor
import fastapi

configure_azure_monitor()

app = fastapi.FastAPI(__name__)
```

```python
# Flask

from azure.monitor.opentelemetry import configure_azure_monitor
import flask

configure_azure_monitor()

app = flask.Flask(__name__)
```

Alternatively, you can call `configure_azure_monitor` before you import `fastapi.FastAPI` or `flask.Flask`:

```python
# FastAPI

from azure.monitor.opentelemetry import configure_azure_monitor

configure_azure_monitor()

from fastapi import FastAPI

app = FastAPI(__name__)
```

```python
# Flask

from azure.monitor.opentelemetry import configure_azure_monitor

configure_azure_monitor()

from flask import Flask

app = Flask(__name__)
```

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
