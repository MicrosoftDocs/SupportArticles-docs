---
title: Troubleshoot Application Insights auto-instrumentation
description: Helps troubleshoot problems with auto-instrumentation in Application Insights.
ms.service: azure-monitor
ms.custom: sap:Missing or Incorrect data after enabling Application Insights in Azure Portal
ms.date: 06/24/2024
---
# Troubleshoot Application Insights auto-instrumentation

This article helps you troubleshoot problems with auto-instrumentation in Application Insights.

> [!NOTE]
> Auto-instrumentation used to be known as "codeless attach" before October 2021.

## Telemetry data isn't reported after you enable auto-instrumentation

Review these common scenarios if you've enabled Application Insights auto-instrumentation for your app service but don't see telemetry data reported.

### The Application Insights SDK was previously installed

Auto-instrumentation fails when .NET and .NET Core apps were already instrumented with the SDK.

Remove the Application Insights SDK if you want to auto-instrument your app.

### An app was published by using an unsupported version of .NET or .NET Core

Verify that a supported version of .NET or .NET Core was used to build and publish applications.

See the .NET or .NET Core documentation to determine if your version is supported:

- [Application monitoring for Azure App Service and ASP.NET](/azure/azure-monitor/app/azure-web-apps-net#application-monitoring-for-azure-app-service-and-aspnet)
- [Application monitoring for Azure App Service and ASP.NET Core](/azure/azure-monitor/app/azure-web-apps-net-core#application-monitoring-for-azure-app-service-and-aspnet-core)

### A diagnostics library was detected

Auto-instrumentation fails if it detects the following libraries:

- `System.Diagnostics.DiagnosticSource`
- `Microsoft.AspNet.TelemetryCorrelation`
- `Microsoft.ApplicationInsights`

These libraries must be removed for auto-instrumentation to succeed.

## You encounter issues with the Application Insights SDK itself after you enable auto-instrumentation

You can collect self-diagnostic logs for the Application Insights SDK to diagnose issues. For more information, see [How to collect self-diagnostic logs for Application Insights SDKs](enable-self-diagnostics.md).

## More help

If you have questions about Application Insights auto-instrumentation, you can post a question on our [Microsoft Q&A question page](/answers/topics/azure-monitor.html).

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
