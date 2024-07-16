---
title: Why did the Azure Log Analytics Workspace costs increase unexpectedly
description: Describes how to investigate daily billing anomalies and identify the source of excessive charges by using detailed usage reports.
ms.date: 07/01/2024
ms.reviewer: neghuman
ms.author: neghuman
ms.service: azure-monitor
keywords:
#Customer intent: As an Azure Monitor user, I want to understand my Log Analytics workspace bill, including what the cost includes and how to read the detailed usage reports.
ms.custom: sap:Log Analytics Billing
---
# Investigate unexpected cost increases in a Log Analytics workspace

This article provides a cost analysis tutorial to investigate daily billing anomalies and identify the services that cause unexpected costs.

## Identify the services that cause unexpected costs

> [!NOTE]
> The prices that are shown in the following images are for example only. They do not reflect actual pricing.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Enter **Log Analytics** in the search bar.
1. Under **Services**, select **Log Analytics**.
1. Select the Log Analytics workspace that you want to investigate.  
    :::image type="content" source="media/identify-service-cause-unexpected-costs/log-analytics-workspaces.png" alt-text="Screenshot of selecting Log Analytics workspace." lightbox="media/identify-service-cause-unexpected-costs/log-analytics-workspaces.png":::
1. On the **Overview** page, select **View Cost** to open the **Cost analysis** page for the current Log Analytics service. 

    :::image type="content" source="media/identify-service-cause-unexpected-costs/view-cost.png" alt-text="Screenshot of opening view cost" lightbox="media/identify-service-cause-unexpected-costs/view-cost.png":::

1. On the **Cost analysis** page, select **View AccumulatedCosts**, and then select **Services**.

    :::image type="content" source="media/identify-service-cause-unexpected-costs/high-cost-1.png" alt-text="Screenshot of opening services view" lightbox="media/identify-service-cause-unexpected-costs/high-cost-1.png":::

1. Select the plus sign (+) icon to open a new tab.  

    :::image type="content" source="media/identify-service-cause-unexpected-costs/high-cost-2.png" alt-text="Screenshot of adding a new tab" lightbox="media/identify-service-cause-unexpected-costs/high-cost-2.png":::

1. Select **Daily costs**.  

    :::image type="content" source="media/identify-service-cause-unexpected-costs/high-cost-3.png" alt-text="Screenshot of Daily costs" lightbox="media/identify-service-cause-unexpected-costs/high-cost-3.png":::

1. In the date selection, select a date range such as **Last 3 months** as the timeline.  

    :::image type="content" source="media/identify-service-cause-unexpected-costs/high-cost-4.png" alt-text="Screenshot of the date selection" lightbox="media/identify-service-cause-unexpected-costs/high-cost-4.png":::

1. Select the **Group by** option, and then select **Meter category**.  

    :::image type="content" source="media/identify-service-cause-unexpected-costs/high-cost-4a.png" alt-text="Screenshot of the Meter category view" lightbox="media/identify-service-cause-unexpected-costs/high-cost-4a.png":::

1. You're now prepared to analyze an assessment of a cost spike, high usage, or other anomaly. The following example shows cost data from a Log Analytics service over the previous three months, grouped by the **Meter category** selection. In the stacked bar chart, three anomalous cost spikes are evident on March 31, April 30, and May 31. Select the stacked bar for April 30. It indicates that the Azure Grafana service that's linked to this Log Analytics workspace caused the cost spike.

    :::image type="content" source="media/identify-service-cause-unexpected-costs/high-cost-5.png" alt-text="Screenshot of grouping by the **Meter category** selection" lightbox="media/identify-service-cause-unexpected-costs/high-cost-5.png":::

    Additionally, the example cost is higher during the late May period because of a spike in Azure Sentinel usage. This is indicated by the increased height of the respective segments within the stacked bar.

    :::image type="content" source="media/identify-service-cause-unexpected-costs/high-cost-6.png" alt-text="Screenshot of the example cost" lightbox="media/identify-service-cause-unexpected-costs/high-cost-6.png":::

After you identify the specific services that are causing the cost spike, you might have to investigate those services to understand why the spike occurred. If you need further assistance to investigate the services, open a support case for the respective service type.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
