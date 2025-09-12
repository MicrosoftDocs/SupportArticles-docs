---
title: Troubleshoot OpenTelemetry issues in Spring Boot Java native
description: Learn how to troubleshoot OpenTelemetry issues in Spring Boot Java native image applications.
ms.date: 07/08/2024
ms.service: azure-monitor
ms.devlang: java
ms.reviewer: toddfous, jeanbisutti, v-weizhu
ms.custom: sap:Missing or Incorrect data after enabling Application Insights in Azure Portal
---
# Troubleshoot OpenTelemetry issues in Spring Boot native image applications

This article discusses how to troubleshoot OpenTelemetry issues in Spring Boot native image applications.

## Step 1: Verify the OpenTelemetry version

You might notice the following message during the application startup:

```output
WARN  c.a.m.a.s.OpenTelemetryVersionCheckRunner - The OpenTelemetry version is not compatible with the spring-cloud-azure-starter-monitor dependency.
The OpenTelemetry version should be <version>
```

In this case, you have to import the OpenTelemetry Bills of Materials
by following the OpenTelemetry documentation in the [Spring Boot starter](https://opentelemetry.io/docs/zero-code/java/spring-boot-starter/getting-started/).

## Step 2: Enable self-diagnostics

If something doesn't work as expected, you can enable self-diagnostics at the `DEBUG` level to get some insights. To do so, set the self-diagnostics level to `ERROR`, `WARN`, `INFO`, `DEBUG`, or `TRACE` by using the `APPLICATIONINSIGHTS_SELF_DIAGNOSTICS_LEVEL` environment variable.

To enable self-diagnostics at the `DEBUG` level when running a docker container, run the following command:

```console
docker run -e APPLICATIONINSIGHTS_SELF_DIAGNOSTICS_LEVEL=DEBUG <image-name>
```

> [!NOTE]
> Replace *`<image-name>`* with the docker image name accordingly.
> 
[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
