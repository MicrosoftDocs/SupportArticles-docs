---
title: Troubleshoot Application Insights auto-instrumentation
description: Helps troubleshoot problems with auto-instrumentation in Application Insights.
ms.service: azure-monitor
ms.custom: sap:Missing or Incorrect data after enabling Application Insights in Azure Portal
ms.date: 06/24/2024
---
# Troubleshoot Application Insights autoinstrumentation

This article helps you troubleshoot problems with autoinstrumentation in Application Insights.

> [!NOTE]
> Autoinstrumentation was known as "codeless attach" before October 2021.

## Telemetry data isn't reported after you enable autoinstrumentation

Review these common scenarios if you've enabled Application Insights autoinstrumentation for your app service but don't see telemetry data reported.

### The Application Insights SDK was previously installed

Autoinstrumentation fails when .NET and .NET Core apps were already instrumented with the SDK.

Remove the Application Insights SDK if you want to autoinstrument your app.

### An app was published by using an unsupported version of .NET or .NET Core

Verify that a supported version of .NET or .NET Core was used to build and publish applications.

To determine if your version is upported, see the .NET or .NET Core documentation:

- [Application monitoring for Azure App Service and ASP.NET](/azure/azure-monitor/app/azure-web-apps-net#application-monitoring-for-azure-app-service-and-aspnet)
- [Application monitoring for Azure App Service and ASP.NET Core](/azure/azure-monitor/app/azure-web-apps-net-core#application-monitoring-for-azure-app-service-and-aspnet-core)

### A diagnostics library was detected

Autoinstrumentation fails if it detects the following libraries:

- `System.Diagnostics.DiagnosticSource`
- `Microsoft.AspNet.TelemetryCorrelation`
- `Microsoft.ApplicationInsights`

These libraries must be removed for autoinstrumentation to succeed.

## You encounter issues with the Application Insights SDK itself after you enable autoinstrumentation

You can collect self-diagnostic logs for the Application Insights SDK to diagnose issues. For more information, see [How to collect self-diagnostic logs for Application Insights SDKs](enable-self-diagnostics.md).

## More help

If you have questions about Application Insights autoinstrumentation, you can post a question on our [Microsoft Q&A question page](/answers/topics/azure-monitor.html).

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
