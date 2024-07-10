---
title: Configure data retention for Log Analytics workspace in Microsoft Azure
description: Learn how to configured data retention for your Log Analytics Workspace.
ms.date: 07/02/2024
ms.author: neghuman
ms.reviewer: neghuman
ms.service: azure-monitor
keywords:
#Customer intent: Help me configure data retention for my Log Analytics Workspace.
ms.custom: sap:Log Analytics Billing
---
# Set Retention for Log Analytics Workspace

This article helps you learn how to configure data retention for your Log Analytics Workspace.

You can set a Log Analytics workspace's default retention in the Azure portal to 30, 31, 60, 90, 120, 180, 270, 365, 550, and 730 days. You can apply a different setting to specific tables by [configuring retention and archive at the table level](/azure/azure-monitor/logs/data-retention-archive?tabs=portal-3%2Cportal-1%2Cportal-2#configure-retention-and-archive-at-the-table-level). If the Log Analytics workspace is on the free tier, you need to [upgrade to the paid tier](/azure/azure-monitor/logs/change-pricing-tier?tabs=azure-portal]) to change the data retention period.

## Configure the workspace retention

1. Sign in to the [Azure portal](https://portal.azure.com). 
1. Enter **log analytics** in the search.
1. Under **Services**, select **Log Analytics**.
1. Select your specific Log Analytics Workspace.  

:::image type="content" source="media/configure-data-retention/log-analytics-workspaces.png" alt-text="select log analytics workspaces" lightbox="media/configure-data-retention/log-analytics-workspaces.png":::

1. In the Settings secton, select **Usage and estimated costs**.
    
    :::image type="content" source="media/configure-data-retention/daily-cap-1.png" alt-text="daily cap step 1" lightbox="media/configure-data-retention/daily-cap-1.png":::
1. On the **Usage and estimated costs** page, select **Data Retention** from the top of the page.  
:::image type="content" source="media/configure-data-retention/data-retention.png" alt-text="Data retention step 1" lightbox="media/configure-data-retention/data-retention.png":::

1. On the pane, move the slider to increase or decrease the number of days, then select **OK**.  
:::image type="content" source="media/configure-data-retention/data-retention-2.png" alt-text="data retention step 2" lightbox="media/configure-data-retention/data-retention-2.png":::

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
