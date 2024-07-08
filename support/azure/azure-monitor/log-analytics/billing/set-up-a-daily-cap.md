---
title: Help me set up a daily cap limit for my Log Analytics Workspace
description: Learn how to set up a daily cap limit for my Log Analytics Workspace, thereby safeguarding against unexpected surges in data ingestion and an unexpected bill spike.
ms.date: 07/01/2024
ms.author: neghuman
editor: neilghuman
ms.service: azure-monitor
keywords:
#Customer intent: Learn how to set up a daily cap limit for my Log Analytics Workspace, thereby safeguarding against unexpected surges in data ingestion and an unexpected bill spike.
ms.custom: sap:Log Analytics Billing
---
# Help me set up a daily cap limit for my Log Analytics Workspace

This article helps you learn how to set up a daily cap limit for my Log Analytics Workspace, thereby safeguarding against unexpected surges in data ingestion and an unexpected bill spike.

### Discover strategies for safeguarding against unexpected sudden, significant increases in data ingestion volume by implementing a daily cap limit on your Log Analytics workspace.

A daily cap on a Log Analytics workspace allows you to avoid unexpected increases in charges for data ingestion by stopping collection of billable data for the rest of the day whenever a specified threshold is reached. Daily caps are typically used by organizations that are particularly cost conscious. They shouldn't be used as a method to reduce costs, but rather as a preventative measure to ensure that you don't exceed a particular budget.

When data collection stops, you effectively have no monitoring of features and resources relying on that workspace. Instead of relying on the daily cap alone, you can create an alert rule to notify you when data collection reaches some level before the daily cap. Notification allows you to address any increases before data collection shuts down, or even to temporarily disable collection for less critical resources.

> [!NOTE]
> You should use care when setting a daily cap because when data collection stops, your ability to observe and receive alerts when the health conditions of your resources will be impacted. It can also impact other Azure services and solutions whose functionality may depend on up-to-date data being available in the workspace. Your goal shouldn't be to regularly hit the daily limit but rather use it as an infrequent method to avoid unplanned charges resulting from an unexpected increase in the volume of data collected.
Use the following procedure to configure a limit to manage the volume of data that Log Analytics workspace ingests per day.

## Set the daily cap

> [!NOTE]
> The prices shown in these images are for example purposes only. They aren't intended to reflect actual pricing.

<!-- Sign into the Azure portal to get started.

1. In the Azure portal, navigate to your Log Analytics resource. -->
### Sign in to Azure

Sign in to the [Azure portal](https://portal.azure.com).

### Select your Log Analytics Workspace

1. Enter *log analytics* in the search.
1. Under **Services**, select **Log Analytics**.

1. Select your specific Log Analytics Workspace.  
:::image type="content" source="media/set-up-a-daily-cap/log-analytics-workspaces.png" alt-text="select log analytics workspaces" lightbox="media/set-up-a-daily-cap/log-analytics-workspaces.png":::

1. Select **Usage and estimated costs** from the left pane in your workspace.  
    :::image type="content" source="media/set-up-a-daily-cap/daily-cap-1.png" alt-text="set daily cap step 1" lightbox="media/set-up-a-daily-cap/daily-cap-1.png":::

1. On the **Usage and estimated costs** page (1) for the selected workspace, 
    1. select **Daily Cap** (2) from the top of the page. 
    1. Select **ON** (3) to enable the daily cap.
    1. Set the data volume limit in GB/day (4). 
    1. Security data types don't impact the daily cap.  
    :::image type="content" source="media/set-up-a-daily-cap/daily-cap-2.png" alt-text="set daily cap step 2" lightbox="media/set-up-a-daily-cap/daily-cap-2.png":::

When the daily cap is reached for a Log Analytics workspace, a banner is displayed in the Azure portal, and an event is written to the Operations table in the workspace. You should create an alert rule to proactively notify you when this occurs.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
