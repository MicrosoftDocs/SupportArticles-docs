--- 
title: Use availability tests on an internal server behind a firewall
description: This article explains how to use Application Insights availability tests on an internal server that runs behind a firewall.
ms.date: 08/15/2022
editor: v-jsitser
ms.reviewer: aaronmax, v-leedennis
ms.service: azure-monitor
ms.subservice: application-insights
#Customer intent: As an Azure Application Insights user, I want to understand how to use Application Insights availability tests on an internal server that runs behind a firewall so that I can effectively monitor Azure applications while my firewall is enabled.  
---

# Use availability tests on an internal server behind a firewall

This article explains how to use Application Insights availability tests on an internal server that runs behind a firewall.  

There are two possible solutions:

- Configure your firewall to permit incoming requests from the [IP addresses of our web test agents](/azure/azure-monitor/app/ip-addresses).

- Write your own code to periodically test your internal server. Run the code as a background process on a test server behind your firewall. Your test process can send its results to Application Insights by using the [TrackAvailability](xref:Microsoft.ApplicationInsights.TelemetryClient.TrackAvailability%2A) API in the core SDK package. Your test server must have outgoing access to the Application Insights ingestion endpoint. However, that condition poses a much smaller security risk than the alternative of permitting incoming requests. The results will appear in the availability web tests blade. The experience will be slightly simpler than what's available for tests that are created through the portal. Custom availability tests will also appear as availability results in Analytics, Search, and Metrics.

## Next steps

- Use [TrackAvailability](xref:Microsoft.ApplicationInsights.TelemetryClient.TrackAvailability%2A) to submit [custom availability tests](/azure/azure-monitor/app/availability-azure-functions).

- Learn about [URL ping tests](/azure/azure-monitor/app/monitor-web-app-availability).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
