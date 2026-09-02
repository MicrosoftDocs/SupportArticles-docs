---
title: Examine firewall logs using Log Analytics
titleSuffix: Azure Application Gateway
description: Learn how to use Log Analytics to examine Azure Application Gateway firewall logs and uncover insights into traffic patterns and security events.
services: application-gateway
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: kaushika
ms.service: azure-application-gateway
ms.topic: troubleshooting
ms.date: 08/31/2026
ms.custom: sap:Monitoring and Logging,sfi-image-nochange
# Customer intent: As a security analyst, I want to analyze Web Application Firewall logs using Log Analytics, so that I can gain insights into traffic patterns and security events for the Application Gateway.
---

# Use Log Analytics to examine Azure Application Gateway firewall logs

## Summary

Use Log Analytics to examine Azure Application Gateway firewall logs and understand what Azure Web Application Firewall (WAF) evaluates, matches, and blocks. Analyzing these logs helps you identify traffic patterns and security events. For more information about log queries, see [Overview of log queries in Azure Monitor](/azure/azure-monitor/logs/log-query-overview).

In this article, you learn about the WAF logs. You can set up [other Application Gateway logs](/azure/application-gateway/application-gateway-diagnostics) in a similar way.

## Prerequisites

Make sure to have the following prerequisites:

- An Azure account with an active subscription. If you don't already have an account, you can [create an account for free](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).
- An Application Gateway WAF SKU. For more information, see [Azure Web Application Firewall on Azure Application Gateway](/azure/web-application-firewall/ag/ag-overview).
- A Log Analytics workspace. For more information about creating a Log Analytics workspace, see [Create a Log Analytics workspace in the Azure portal](/azure/azure-monitor/logs/quick-create-workspace).

## Send firewall logs to Log Analytics

To export your firewall logs into Log Analytics, see [Diagnostic logs for Application Gateway](/azure/application-gateway/application-gateway-diagnostics#firewall-log). When you have the firewall logs in your Log Analytics workspace, you can view data, write queries, create visualizations, and add them to your portal dashboard.

## Explore firewall log data with example queries

Use the **AzureDiagnostics** table to view the raw data in the firewall log by running the following query:

```
AzureDiagnostics 
| where ResourceProvider == "MICROSOFT.NETWORK" and Category == "ApplicationGatewayFirewallLog"
| limit 10
```

This query looks similar to the following query:

:::image type="content" source="media/log-analytics/log-query.png" alt-text="Screenshot of Log Analytics query." lightbox="media/log-analytics/log-query.png":::

Use the **Resource-specific** table to view the raw data in the firewall log by running the following query. 

```
AGWFirewallLogs
| limit 10
```

To learn about the resource-specific tables, see [Monitoring data reference](/azure/application-gateway/monitor-application-gateway-reference#supported-resource-log-categories-for-microsoftnetworkapplicationgateways).

You can drill down into the data, plot graphs, or create visualizations from here. The following examples show `AzureDiagnostics` queries that you can use.

### Matched or blocked requests by IP

```
AzureDiagnostics
| where ResourceProvider == "MICROSOFT.NETWORK" and Category == "ApplicationGatewayFirewallLog"
| summarize count() by clientIp_s, bin(TimeGenerated, 1m)
| render timechart
```

### Matched or blocked requests by URI

```
AzureDiagnostics
| where ResourceProvider == "MICROSOFT.NETWORK" and Category == "ApplicationGatewayFirewallLog"
| summarize count() by requestUri_s, bin(TimeGenerated, 1m)
| render timechart
```

### Top matched rules

```
AzureDiagnostics
| where ResourceProvider == "MICROSOFT.NETWORK" and Category == "ApplicationGatewayFirewallLog"
| summarize count() by ruleId_s, bin(TimeGenerated, 1m)
| where count_ > 10
| render timechart
```

### Top five matched rule groups

```
AzureDiagnostics
| where ResourceProvider == "MICROSOFT.NETWORK" and Category == "ApplicationGatewayFirewallLog"
| summarize Count=count() by details_file_s, action_s
| top 5 by Count desc
| render piechart
```

## Add firewall log queries to your dashboard

After you create a query, add it to your dashboard. Select **Pin to dashboard** in the Log Analytics workspace. When you pin the previous four queries to an example dashboard, you see something like the following illustration.

:::image type="content" source="media/log-analytics/dashboard.png" alt-text="Screenshot of an Azure dashboard where you can add your query." lightbox="media/log-analytics/dashboard.png":::

## References

[Backend health, diagnostic logs, and metrics for Application Gateway](/azure/application-gateway/application-gateway-diagnostics)
