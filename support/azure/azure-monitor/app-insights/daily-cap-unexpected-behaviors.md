---
title: Daily cap unexpected behaviors in Application Insights
description: Learn about daily cap unexpected behaviors in Azure Monitor Application Insights. Review why actual ingested data differs from the specified daily cap limit.
ms.date: 05/18/2023
editor: v-jsitser
ms.reviewer: toddfous, v-leedennis
ms.service: azure-monitor
ms.subservice: application-insights
---
# Daily cap unexpected behaviors in Application Insights

This article covers how to resolve issues in Microsoft Azure Application Insights that involve the mismatch between the daily cap settings and the actual volume of ingested telemetry data.

## Symptoms

In Application Insights, you set the daily cap amount to control the volume of telemetry data that your service can ingest. However, you encounter situations in which the amount of actual ingested data exceeds or never reaches the specified daily cap.

## Cause 1: Application Insights and Log Analytics now have separate daily cap implementations

Starting in March 2023, the Application Insights and Azure Log Analytics daily caps must be set independently. This is because the two services have distinct and separate daily cap implementations. The implementation rules are outlined in the following table.

| How data is sent to Application Insights | Connection method | Daily cap implementations |
|--|--|--|
| Regional ingestion endpoints | Connection strings | Application Insights and Log Analytics daily cap settings are effective per region. |
| Global ingestion endpoint | Instrumentation key (`ikey`) | The Application Insights daily cap setting might not be effective across regions, but the Log Analytics daily cap setting still applies. |

For more information about regional and global ingestion endpoints, see the [Outgoing ports](/azure/azure-monitor/app/ip-addresses#outgoing-ports) section of the "IP addresses used by Azure Monitor" article.

> [!NOTE]  
> The daily cap can't stop data collection at precisely the specified cap level. Some excess data is expected, particularly if the Application Insights instance is receiving high volumes of data. If the amount of data that's collected exceeds the cap, that data amount is still billed. To learn about a query that's helpful in studying the daily cap behavior in a Log Analytics workspace, see [View the effect of the daily cap](/azure/azure-monitor/logs/daily-cap#view-the-effect-of-the-daily-cap).

### Solution 1: Configure the daily caps for Application Insights and Log Analytics separately

Set the daily cap amount for both Application Insights and Log Analytics to limit how much telemetry data your service ingests. For Log Analytics workspace-based Application Insights resources, the effective daily cap is the lesser of the two settings. For classic Application Insights resources, only the Application Insights daily cap applies. This is because that data doesn't reside in a Log Analytics workspace.

#### Set the daily cap for Application Insights

To set the daily cap for your telemetry in Application Insights, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Application Insights**.

1. In the list of Application Insights resources, select the name of your Application Insights resource.

1. In the navigation pane of your Application Insights resource, locate the **Configure** heading, and then select **Usage and estimated costs**.

1. In the resource menu, select **Daily cap**.

1. In the **Daily volume cap** pane, under **The daily volume cap is** label, set the Application Insights daily cap in gigabytes (GB) per day.

#### Set the daily cap for Log Analytics

To set the daily cap for all the data (including Application Insights logs and metrics) that you're sending to a Log Analytics workspace, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Log Analytics workspaces**.

1. In the list of Log Analytics workspaces, select the name of your Log Analytics workspace.

1. In the navigation pane of your Log Analytics workspace, locate the **Settings** heading, and then select **Usage and estimated costs**.

1. In the workspace menu, select **Daily cap**.

1. In the **Daily volume cap** pane, select **On**, and then under **The daily volume cap is** label, set the amount of data that the Log Analytics workspace is allowed to ingest, in GB per day.

   > [!NOTE]  
   > By default, Log Analytics doesn't enable a daily cap on ingested data. Therefore, you have to enable the daily cap before you can adjust the cap limit.

## Cause 2: A data collection rule reduces the volume of telemetry data to Log Analytics

If you apply a data collection rule (DCR) in Azure Monitor, the DCR can reduce the volume of telemetry data that Application Insights sends to a Log Analytics workspace. Because of a DCR, the volume that the Log Analytics workspace receives can be smaller than the daily volume cap for the workspace.

### Solution 2: Change or delete the data collection rule

Change or delete the DCR so that the Log Analytics workspace can receive a larger volume of telemetry data. For more information about how to edit or delete a DCR, see [Data collection rules in Azure Monitor](/azure/azure-monitor/essentials/data-collection-rule-overview).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
