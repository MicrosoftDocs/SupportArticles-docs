---
title: Help me configure data retention for my Log Analytics Workspace.
description: Learn how to configured data retention for your Log Analytics Workspace.
ms.date: 07/02/2024
ms.author:neghuman
ms.reviewer: neghuman
editor: neilghuman
ms.service: azure-monitor
keywords:
#Customer intent: Help me configure data retention for my Log Analytics Workspace.
ms.custom: sap:Log Analytics Billing
---
# Help me configure data retention for my Log Analytics Workspace.

This article helps you learn how to configured data retention for your Log Analytics Workspace.

You can set a Log Analytics workspace's default retention in the Azure portal to 30, 31, 60, 90, 120, 180, 270, 365, 550, and 730 days. You can apply a different setting to specific tables by configuring retention and archive at the table level. If you're on the free tier, you need to upgrade to the paid tier to change the data retention period.

### Set Retention for Log Analytics Workspace
To set the retention for your workspace:

**Note:** The prices shown in these images are for example purposes only. They are not intended to reflect actual pricing.

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
:::image type="content" source="media/configure-data-retention/log-analytics-workspaces.png" alt-text="select log analytics workspaces" lightbox="media/configure-data-retention/log-analytics-workspaces.png"::: 

1. From your workspace, select **Usage and estimated costs** from the left pane.  
:::image type="content" source="media/configure-data-retention/daily-cap-1.png" alt-text="daily cap step 1" lightbox="media/configure-data-retention/daily-cap-1.png":::


1. On the **Usage and estimated costs** page, select **Data Retention** from the top of the page.  
:::image type="content" source="media/configure-data-retention/data-retention.png" alt-text="Data retention step 1" lightbox="media/configure-data-retention/data-retention.png":::

1. On the pane, move the slider to increase or decrease the number of days, then select **OK**.  
:::image type="content" source="media/configure-data-retention/data-retention-2.png" alt-text="data retention step 2" lightbox="media/configure-data-retention/data-retention-2.png":::

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
