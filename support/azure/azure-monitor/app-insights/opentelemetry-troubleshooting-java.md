---
title: Troubleshoot OpenTelemetry issues in Java
description: Learn how to troubleshoot OpenTelemetry issues in Java. Test connectivity between your application host and the ingestion service.
ms.date: 04/22/2023
editor: v-jsitser
ms.service: azure-monitor
ms.subservice: application-insights
ms.devlang: java
ms.reviewer: mmcc, lechen, aaronmax, v-leedennis
---

# Troubleshoot OpenTelemetry issues in Java

This article discusses how to troubleshoot OpenTelemetry issues in Java.

## Troubleshooting checklist

### Step 1: Enable diagnostic logging

By default, diagnostic logging is enabled in Azure Monitor Application Insights. For more information, see [Troubleshoot guide: Azure Monitor Application Insights for Java](java-standalone-troubleshoot.md).

### Step 2: Test connectivity between your application host and the ingestion service

Application Insights SDKs and agents send telemetry to get ingested as REST calls at our ingestion endpoints. To test connectivity from your web server or application host computer to the ingestion service endpoints, use cURL commands or raw REST requests from PowerShell. For more information, see [Troubleshoot missing application telemetry in Azure Monitor Application Insights](investigate-missing-telemetry.md).

## Known issues

- If you [download the Application Insights client library for installation](/azure/azure-monitor/app/opentelemetry-enable?tabs=java#install-the-client-libraries) from a browser, sometimes the downloaded JAR file is corrupted and is about half the size of the source file. If you experience this problem, download the JAR file by running the [curl](https://curl.se) or [wget](https://www.gnu.org/software/wget/) command, as shown in the following example command calls:

  ```bash
  curl --location --output applicationinsights-agent-3.4.11.jar https://github.com/microsoft/ApplicationInsights-Java/releases/download/3.4.11/applicationinsights-agent-3.4.11.jar
  ```

  ```bash
  wget --output-document=applicationinsights-agent-3.4.11.jar https://github.com/microsoft/ApplicationInsights-Java/releases/download/3.4.11/applicationinsights-agent-3.4.11.jar
  ```

  > [!NOTE]  
  > The example command calls apply to Application Insights for Java version 3.4.11. To find the version number and URL address of the current release of Application Insights for Java, see <https://github.com/microsoft/ApplicationInsights-Java/releases>.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
