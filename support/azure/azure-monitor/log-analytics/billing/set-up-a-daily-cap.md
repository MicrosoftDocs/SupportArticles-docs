---
title: Set a daily cap limit for a Log Analytics workspace in Microsoft Azure
description: Learn how to set up a daily cap limit for a Log Analytics workspace to safeguard against unexpected surges in data ingestion and unexpected bill spikes.
ms.date: 07/01/2024
ms.author: neghuman
editor: neilghuman
ms.service: azure-monitor
keywords:
#Customer intent: I want to learn how to set up a daily cap limit for my Log Analytics workspace, thereby safeguarding against unexpected surges in data ingestion and unexpected bill spikes.
ms.custom: sap:Log Analytics Billing
---
# Set daily cap limit for Log Analytics workspace

This article helps you learn how to set up a daily cap limit for a Log Analytics workspace.

## Strategies for safeguarding against unexpected data ingestion surges

The daily cap on a Log Analytics workspace enables you to avoid unexpected increases in charges for data ingestion by stopping the collection of billable data for the rest of the day whenever a specified threshold is reached. Daily caps are typically used by organizations that are particularly cost-conscious. They shouldn't be used as a method to reduce costs but, instead, as a preventative measure to make sure that you don't exceed a particular budget.

When data collection stops, you effectively have no monitoring of features or resources that rely on that workspace. Instead of relying on the daily cap alone, you can create an alert rule to notify yourself when data collection reaches a specified level before the daily cap is reached. Notification enables you to address any increases before data collection shuts down, or even to temporarily disable collection for less critical resources.

> [!NOTE]
> You should use care when you set a daily cap. This is because when data collection stops, you lose the ability to observe and receive alerts about when the health conditions of your resources will be affected. A daily cap can also affect other Azure services and solutions whose functionality may depend on up-to-date data being available in the workspace. Your goal shouldn't be to regularly hit the daily limit but, instead, to avoid unplanned charges that might be caused by an unexpected increase in the volume of data that's collected.

## Configure daily cap

1. Sign in to the [Azure portal](https://portal.azure.com). 
1. Enter **log analytics** in the search bar.
1. Under **Services**, select **Log Analytics**.
1. Select your Log Analytics Workspace.  
1. In the **Settings** secton, select **Usage and estimated costs**.  
    :::image type="content" source="media/set-up-a-daily-cap/daily-cap-1.png" alt-text="Screenshot that shows how to open the Usage and estimated costs page":::

1. On the **Usage and estimated costs** page, select **Daily Cap** at the top of the page.
    :::image type="content" source="media/set-up-a-daily-cap/daily-cap-2.png" alt-text="Screenshot that shows how to open Daily Cap":::
1. Configure the Daily Cap settings:

    1. Select **ON** to enable the daily cap.
    1. Set the data volume limit (in GB per day). 
    Notice that security data types aren't affected by the daily cap.  
    :::image type="content" source="media/set-up-a-daily-cap/daily-cap-setting.png" alt-text="Screenshot that shows how to configure Daily Cap settings":::

When the daily cap is reached for a Log Analytics workspace, a banner is displayed in the Azure portal, and an event is written to the Operations table in the workspace. You should create an alert rule to proactively notify yourself when this occurs.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
