---
title: Configure data retention for a Log Analytics workspace in Microsoft Azure
description: Learn how to configured data retention for your Log Analytics Workspace.
ms.date: 07/02/2024
ms.author: neghuman
ms.reviewer: neghuman
ms.service: azure-monitor
keywords:
#Customer intent: As an Azure Monitor user, I want to learn how to configure data retention for my Log Analytics workspace.
ms.custom: sap:Log Analytics Billing
---
# Set Retention for Log Analytics Workspace

This article helps you learn how to configure data retention for your Log Analytics workspace in Microsoft Azure.

You can set the default retention for a Log Analytics workspace in the Azure portal to any of the following number of days:

- 30
- 31
- 60
- 90
- 120
- 180
- 270
- 365
- 550
- 730

You can apply a different setting to specific tables by [configuring the retention and archive settings at the table level](/azure/azure-monitor/logs/data-retention-archive?tabs=portal-3%2Cportal-1%2Cportal-2#configure-retention-and-archive-at-the-table-level). If the Log Analytics workspace is on the free tier, you must [upgrade to the paid tier](/azure/azure-monitor/logs/change-pricing-tier?tabs=azure-portal]) to be able to change the data retention period.

## Configure the workspace retention

1. Sign in to the [Azure portal](https://portal.azure.com). 
1. Enter **log analytics** in the search bar.
1. Under **Services**, select **Log Analytics**.
1. Select your Log Analytics workspace.  
    :::image type="content" source="media/identify-service-cause-unexpected-costs/log-analytics-workspaces.png" alt-text="Screenshot of selecting a log Analytics workspace" lightbox="media/configure-data-retention/log-analytics-workspaces.png":::
1. In the **Settings** section, select **Usage and estimated costs**.
    
    :::image type="content" source="media/configure-data-retention/data-retention-1.png" alt-text="Screenshot of Usage and estimated costs" lightbox="media/identify-service-cause-unexpected-costs/data-retention-1.png":::
1. At the top of the **Usage and estimated costs** page, select **Data Retention**.
    :::image type="content" source="media/configure-data-retention/data-retention.png" alt-text="Screenshot that shows how to open the Data Retention pane" lightbox="media/configure-data-retention/data-retention.png"::::::

1. On the **Data Retention** pane, move the slider to increase or decrease the number of days, and then select **OK**.  
:::image type="content" source="media/configure-data-retention/data-retention-2.png" alt-text="SCreenshot that shows how to configure Data Retention settings"lightbox="media/configure-data-retention/data-retention-2.png"::::::
[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
