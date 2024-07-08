---
title: Help me set up Log Analytics Workspace recommended alerts for proactive daily cap and ingestion related notifications
description: Learn how to get notified when you hit the daily cap limit
ms.date: 07/01/2024
ms.author: neghuman
ms.service: azure-monitor
keywords:
#Customer intent: As an Azure Monitor user, I want to understand my Log Analytics workspace's bill including what's included in the cost and how to read the detailed usage reports.
ms.custom: sap:Log Analytics Billing
---
# Help me set up Log Analytics Workspace recommended alerts for proactive daily cap and ingestion related notifications.

This article helps you learn how to set up Log Analytics recommended alerts to get notified when you hit the daily cap limit.

> [!NOTE]
> The prices shown in these images are for example purposes only. They aren't intended to reflect actual pricing.

When the daily cap is reached for a Log Analytics workspace, a banner is displayed in the Azure portal, and an event is written to the Operations table in the workspace. You should create an alert rule to proactively notify you when this occurs.

<!-- Sign into the Azure portal to get started.

1. In the Azure portal, navigate to your Log Analytics resource. -->
### Sign in to Azure

Sign in to the [Azure portal](https://portal.azure.com).

### Select your Log Analytics Workspace

1. Enter *log analytics* in the search.
1. Under **Services**, select **Log Analytics**.

1. Select your specific Log Analytics Workspace.  
:::image type="content" source="media/workspace-recommended-alerts/log-analytics-workspaces.png" alt-text="select log analytics workspaces" lightbox="media/workspace-recommended-alerts/log-analytics-workspaces.png":::

1. Select **Alerts**.  
:::image type="content" source="media/workspace-recommended-alerts/log-analytics-alert-1.png" alt-text="log analytics alert step 1" lightbox="media/workspace-recommended-alerts/log-analytics-alert-1.png":::

1. With the Alerts (1) pane selected
    1. Select **Set up recommendations** (2)
    1. Toggle the radio buttons for which alerts rules you would like to configure. We recommend enabling all recommended alert rules(3).
    1. Fill out the **Notify me by** section.
    1. Select **Save**.  
    :::image type="content" source="media/workspace-recommended-alerts/log-analytics-alert-2.png" alt-text="log analytics alert step 2" lightbox="media/workspace-recommended-alerts/log-analytics-alert-2.png":::

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
