---
title: Set a daily cap limit for Log Analytics Workspace in Microsoft Azure
description: Learn how to set up a daily cap limit for the Log Analytics Workspace, thereby safeguarding against unexpected surges in data ingestion and unexpected bill spikes.
ms.date: 07/01/2024
ms.author: neghuman
editor: neilghuman
ms.service: azure-monitor
keywords:
#Customer intent: Learn how to set up a daily cap limit for my Log Analytics Workspace, thereby safeguarding against unexpected surges in data ingestion and an unexpected bill spike.
ms.custom: sap:Log Analytics Billing
---
# Set daily cap limit for Log Analytics workspace

This article helps you learn how to set up a daily cap limit for Log Analytics Workspace.

## Discover Strategies for safeguarding against unexpected data ingestion surges

The daily cap on a Log Analytics workspace allows you to avoid unexpected increases in charges for data ingestion by stopping the collection of billable data for the rest of the day whenever a specified threshold is reached. Daily caps are typically used by organizations that are particularly cost-conscious. They shouldn't be used as a method to reduce costs but rather as a preventative measure to ensure that you don't exceed a particular budget.

When data collection stops, you effectively have no monitoring of features and resources relying on that workspace. Instead of relying on the daily cap alone, you can create an alert rule to notify you when data collection reaches some level before the daily cap. Notification allows you to address any increases before data collection shuts down, or even to temporarily disable collection for less critical resources.

> [!NOTE]
> You should use care when setting a daily cap because when data collection stops, your ability to observe and receive alerts when the health conditions of your resources will be impacted. It can also impact other Azure services and solutions whose functionality may depend on up-to-date data being available in the workspace. Your goal shouldn't be to regularly hit the daily limit but rather use it as an infrequent method to avoid unplanned charges resulting from an unexpected increase in the volume of data collected.

## Configure daily cap

1. Sign in to the [Azure portal](https://portal.azure.com). 
1. Type **log analytics** in the search bar.
1. Under **Services**, select **Log Analytics**.
1. Select your Log Analytics Workspace.  
1. In the Settings secton, select **Usage and estimated costs**.  
    :::image type="content" source="media/set-up-a-daily-cap/daily-cap-1.png" alt-text="The image about how to open Usage and estimated costs":::

1. On the **Usage and estimated costs** page, select **Daily Cap** from the top of the page.
    :::image type="content" source="media/set-up-a-daily-cap/daily-cap-2.png" alt-text="The image about how to open Daily Cap":::
1. Confire the Daily Cap settings:

    1. Select **ON** to enable the daily cap.
    2. Set the data volume limit in GB/day. 
    Note that security data types don't impact by the daily cap.  
    :::image type="content" source="media/set-up-a-daily-cap/daily-cap-setting.png" alt-text="The image about how to configure Daily Cap settings":::

When the daily cap is reached for a Log Analytics workspace, a banner is displayed in the Azure portal, and an event is written to the Operations table in the workspace. You should create an alert rule to proactively notify you when this occurs.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
