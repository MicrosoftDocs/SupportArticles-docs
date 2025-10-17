---
title: Troubleshoot Application Insights Autoinstrumentation
description: Provides troubleshooting help for problems in autoinstrumentation in Application Insights.
author: JarrettRenshaw
ms.author: jarrettr
ms.reviewer: matthofa, v-nawrothkai
ms.service: azure-monitor
ms.custom: sap:Missing or incorrect telemetry and performance issues
ms.date: 10/14/2025
---
# Troubleshoot Application Insights autoinstrumentation

This article helps you troubleshoot problems that affect autoinstrumentation in Application Insights.

> [!NOTE]
> Autoinstrumentation was known as "codeless attach" before October 2021.

## Telemetry data isn't reported after you enable autoinstrumentation

If you enabled Application Insights autoinstrumentation for your app service but don't see telemetry data reported, review the common scenarios in the following sections.

### The Application Insights SDK was previously installed

Autoinstrumentation fails if .NET and .NET Core apps already have the Application Insights SDK installed.

To be able to autoinstrument your app, remove the Application Insights SDK.

### An app was published by using an unsupported version of .NET or .NET Core

Verify that a supported version of .NET or .NET Core was used to build and publish applications.

To determine whether your version is supported, see the following .NET or .NET Core documentation:

- [Application monitoring for Azure App Service and ASP.NET](/azure/azure-monitor/app/azure-web-apps-net#application-monitoring-for-azure-app-service-and-aspnet)
- [Application monitoring for Azure App Service and ASP.NET Core](/azure/azure-monitor/app/azure-web-apps-net-core#application-monitoring-for-azure-app-service-and-aspnet-core)

### A diagnostics library is detected

Autoinstrumentation fails if it detects the following libraries:

- `System.Diagnostics.DiagnosticSource`
- `Microsoft.AspNet.TelemetryCorrelation`
- `Microsoft.ApplicationInsights`

For autoinstrumentation to work successfully, these libraries must be removed.

## You encounter SDK problems after you enable autoinstrumentation

If you encounter problems that are caused by the Application Insights SDK itself after you enable autoinstrumentation, collect self-diagnostic logs to diagnose the problems. For more information, see [How to collect self-diagnostic logs for Application Insights SDKs](enable-self-diagnostics.md).

## More information

If you have additional questions about Application Insights autoinstrumentation, you can post them on our [Microsoft Q&A question page](/answers/topics/azure-monitor.html).

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
