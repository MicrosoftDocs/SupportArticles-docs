---
title: Set recommended alerts for proactive daily cap and ingestion notifications
description: Learn how to get notified when you reach the daily cap limit.
ms.date: 07/01/2024
ms.author: neghuman
ms.service: azure-monitor
keywords:
#Customer intent: As an Azure Monitor user, I want to understand my Log Analytics workspace bill including what's included in the cost and how to read the detailed usage reports.
ms.custom: sap:Log Analytics Billing
---
# Set recommended alerts for proactive daily cap and ingestion notifications

When the daily cap is reached in a Log Analytics workspace, a banner appears in the Azure portal, and an event is logged in the **Operations** table within the Log Analytics workspace. This article guides you through setting up Log Analytics recommended alerts to receive notifications when the daily cap is reached.

### Select your Log Analytics workspace

1. Sign in to the [Azure portal](https://portal.azure.com). 
1. Enter **Log Analytics** in the search bar.
1. Under **Services**, select **Log Analytics**, and then select your Log Analytics workspace.  
    :::image type="content" source="media/workspace-recommended-alerts/log-analytics-workspaces.png" alt-text="Screenshot that shows how to open Insights" lightbox="media/workspace-recommended-alerts/log-analytics-workspaces.png":::

1. In the **Monitoring** section, select **Alerts**.  
:::image type="content" source="media/workspace-recommended-alerts/log-analytics-alert-1.png" alt-text="Screenshot that shows how to open the Alerts page" lightbox="media/workspace-recommended-alerts/log-analytics-alert-1.png":::

1. On the **Alerts** page, select **Set up recommendations**, and then configure the alert rules:
   
    1. Turn on the alert rules that you want to receive notifications for. We recommend that you enable all alert rules.
    1. In the **Notify me** section, specify an email address to receive the notifications.
    1. Select **Save**.  

    :::image type="content" source="media/workspace-recommended-alerts/log-analytics-alert-2.png" alt-text="Screenshot that shows how to configure recommended alerts" lightbox="media/workspace-recommended-alerts/log-analytics-alert-2.png":::

> [!div class="nextstepaction"]
> [Identify why daily cap exceeded](./why-daily-cap-exceeded.md)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
