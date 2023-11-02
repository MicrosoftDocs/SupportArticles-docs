--- 
title: Resolve an intermittent test failure and protocol violation error
description: This article describes how to resolve an intermittent test failure and protocol violation error in Application Insights availability monitoring.
ms.date: 09/12/2022
editor: v-jsitser
ms.reviewer: aaronmax, v-leedennis
ms.service: azure-monitor
ms.subservice: application-insights
#Customer intent: As an Azure Application Insights user, I want to understand how to resolve an intermittent test failure and protocol violation error in Application Insights availability monitoring so I can effectively monitor Azure applications.  
---

# Resolve an intermittent test failure and protocol violation error

This article explains how to resolve an intermittent test failure that causes a protocol violation error.

## Symptoms

An Application Insights availability monitoring intermittent test fails and generates a protocol violation error.  

## Cause

The error, "protocol violation...CR must be followed by LF," indicates an issue with the server or its dependencies. This error occurs if malformed headers are set in the response. It can be caused by load balancers or CDNs. Specifically, some headers might not be using CRLF to indicate end of line. This violates the HTTP specification. Therefore, the test fails validation at the .NET WebRequest level.  

## Solution

Inspect the response, and look for headers that might be violating this HTTP specification.

> [!NOTE]
> The URL might not fail in web browsers that have a relaxed validation of HTTP headers. For a detailed explanation of this issue, see the blog article, [A tale of debugging - the LinkedIn API, .NET and HTTP protocol violations](http://mehdi.me/a-tale-of-debugging-the-linkedin-api-net-and-http-protocol-violations/).

## Next steps

* Use [TrackAvailability](xref:Microsoft.ApplicationInsights.TelemetryClient.TrackAvailability%2A) to submit [custom availability tests](/azure/azure-monitor/app/availability-azure-functions).

* Learn about [URL ping tests](/azure/azure-monitor/app/monitor-web-app-availability).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
