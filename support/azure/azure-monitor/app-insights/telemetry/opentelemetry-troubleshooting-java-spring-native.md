---
title: Troubleshoot OpenTelemetry issues in Spring Boot Java native image applications
description: Learn how to troubleshoot OpenTelemetry issues in Spring Boot Java native image applications.
ms.date: 06/24/2024
editor: v-jsitser
ms.service: azure-monitor
ms.devlang: java
ms.reviewer: mmcc, lechen, aaronmax, v-leedennis
ms.custom: sap:Missing or Incorrect data after enabling Application Insights in Azure Portal
---

# Troubleshoot OpenTelemetry issues in Spring Boot native image applications

This article discusses how to troubleshoot OpenTelemetry issues in Sping Boot native image applications.

## Troubleshooting checklist

### Step 1: Verify the OpenTelemetry version

You may notice the following message during the application start-up:
```
WARN  c.a.m.a.s.OpenTelemetryVersionCheckRunner - The OpenTelemetry version is not compatible with the spring-cloud-azure-starter-monitor dependency. The OpenTelemetry version should be
```

In this case, you have to import the OpenTelemetry Bills of Materials
by [following the OpenTelemetry documentation](https://opentelemetry.io/docs/instrumentation/java/automatic/spring-boot/#dependency-management).

By default, diagnostic logging is enabled in Azure Monitor Application Insights. For more information, see [Troubleshoot guide: Azure Monitor Application Insights for Java](java-standalone-troubleshoot.md).

### Step 2: Enable diagnostic logging

If something does not work as expected, you can enable self-diagnostics features at DEBUG level to get some insights.

You can configure the self-diagnostics level by using the APPLICATIONINSIGHTS_SELF_DIAGNOSTICS_LEVEL environment variable. You can configure the level with ERROR, WARN, INFO, DEBUG, or TRACE.

_The APPLICATIONINSIGHTS_SELF_DIAGNOSTICS_LEVEL environment variable only works for Logback today._

The following line shows you how to add self-diagnostics at the DEBUG level when running a docker container:
```
docker run -e APPLICATIONINSIGHTS_SELF_DIAGNOSTICS_LEVEL=DEBUG {image-name}
```

You have to replace `{image-name}` by your docker image name.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
