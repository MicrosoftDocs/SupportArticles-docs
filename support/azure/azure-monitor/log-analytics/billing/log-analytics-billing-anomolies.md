---
title: Understanding why costs associated with my Log Analytics Workspace increased or jumped unexpectedly.
description: Help me identify and investigate billing anomalies using detailed usage reports to pinpoint the source of excessive charges.
ms.date: 07/01/2024
ms.reviewer: neghuman
ms.author: neghuman
ms.service: azure-monitor
keywords:
#Customer intent: As an Azure Monitor user, I want to understand my Log Analytics workspace's bill including what's included in the cost and how to read the detailed usage reports.
ms.custom: sap:Log Analytics Billing
---
# Understanding why costs associated with my Log Analytics Workspace increased or jumped unexpectedly.

This article helps identify and investigate billing anomalies using detailed usage reports to pinpoint the source of excessive charges.

## Help me understand my Log Analytics workspace's bill, detailing the costs and how to read the detailed usage reports.

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
:::image type="content" source="media/log-analytics-billing-anomolies/log-analytics-workspaces.png" alt-text="select log analytics workspaces" lightbox="media/log-analytics-billing-anomolies/log-analytics-workspaces.png":::

1. Select **View Cost**  
:::image type="content" source="media/log-analytics-billing-anomolies/view-cost.png" alt-text="view cost step 1" lightbox="media/log-analytics-billing-anomolies/view-cost.png":::

1. Under the view dropdown, select **Services**.  
:::image type="content" source="media/log-analytics-billing-anomolies/high-cost-1.png" alt-text="high cost step 1" lightbox="media/log-analytics-billing-anomolies/high-cost-1.png":::

1. Select the '**+**' icon to open a new tab.  
:::image type="content" source="media/log-analytics-billing-anomolies/high-cost-2.png" alt-text="high cost step 2" lightbox="media/log-analytics-billing-anomolies/high-cost-2.png":::

1. Select the **Daily costs** tab.  
:::image type="content" source="media/log-analytics-billing-anomolies/high-cost-3.png" alt-text="high cost step 3" lightbox="media/log-analytics-billing-anomolies/high-cost-3.png":::

1. Select the date (1) dropdown and select **Last 3 months** (2) as the timeline.  
:::image type="content" source="media/log-analytics-billing-anomolies/high-cost-4.png" alt-text="high cost step 4" lightbox="media/log-analytics-billing-anomolies/high-cost-4.png":::

1. Select **Group by:** (1) dropdown and select the **Meter category** (2) from the list.  
:::image type="content" source="media/log-analytics-billing-anomolies/high-cost-4a.png" alt-text="high cost step 4a" lightbox="media/log-analytics-billing-anomolies/high-cost-4a.png":::

1. You're now ready to begin to analyze a cost spike, high usage, or anomaly.
    1. With the Meter category (1) selected and a three month timeline selected, you notice in our case study a few anomalous cost spikes. Scrolling over the second out of place stacked bar (2), we notice that the Azure Granana Service spiked the bill at the end of April.  
:::image type="content" source="media/log-analytics-billing-anomolies/high-cost-5.png" alt-text="high cost step 5" lightbox="media/log-analytics-billing-anomolies/high-cost-5.png":::

1. Our example bill was also higher during the late May period caused by a spike in the Azure Sentinel usage.  
:::image type="content" source="media/log-analytics-billing-anomolies/high-cost-6.png" alt-text="high cost step 6" lightbox="media/log-analytics-billing-anomolies/high-cost-6.png":::

Given the cost analysis tutorial, once should be able to identify cost or usage spikes with the specific services. Once identified, investigate those services further. If you need more help investigating the increase, open a support case with the Azure service provider.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
