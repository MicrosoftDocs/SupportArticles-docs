---
title: Set recommended alerts in Microsoft Azure Log Analytics workspace 
description: Learn how to get notified when you reach the daily cap limit.
ms.date: 07/01/2024
ms.author: neghuman
ms.service: azure-monitor
keywords:
#Customer intent: As an Azure Monitor user, I want to understand my Log Analytics workspace's bill including what's included in the cost and how to read the detailed usage reports.
ms.custom: sap:Log Analytics Billing
---
# Set recommended alerts in Microsoft Azure Log

When the daily cap is reached in a Log Analytics workspace, a banner displays in the Azure portal, and an event is logged in the **Operations** table within the Log Analytics workspace. This article guides you through setting up Log Analytics recommended alerts to receive notifications when the daily cap is reached.

### Select your Log Analytics Workspace

1. Sign in to the [Azure portal](https://portal.azure.com). 
1. Enter **log analytics** in the search bar.
1. Under **Services**, select **Log Analytics**.
1. Select your Log Analytics Workspace.  
1. In the **Monitoring** section, select **Alerts**.  
:::image type="content" source="media/workspace-recommended-alerts/log-analytics-alert-1.png" alt-text="log analytics alert step 1" lightbox="media/workspace-recommended-alerts/log-analytics-alert-1.png":::

1. In the **Alerts** page selected, **Set up recommendations**, and then configure the alert rules:
   
    1. Turn on the alert rules that you would like to receive notifications. It's recommended to enable all recommended alert rules.
    1. In the **Notify me** by section, specify an email address to receive the notification.
    1. Select **Save**.  

    :::image type="content" source="media/workspace-recommended-alerts/log-analytics-alert-2.png" alt-text="log analytics alert step 2" lightbox="media/workspace-recommended-alerts/log-analytics-alert-2.png":::

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
