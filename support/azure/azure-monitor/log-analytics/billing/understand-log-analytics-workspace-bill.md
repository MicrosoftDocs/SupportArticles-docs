---
title: Understand cost and usage in Log Analytics workspace in Microsoft Azure
description: Learn how to understand the costs associated with your Log Analytics Workspace and identify causes for increased expense.
ms.date: 07/01/2024
ms.author: neghuman
ms.service: azure-monitor
keywords:
#Customer intent: As an Azure Monitor user, I want to understand my Log Analytics workspace's bill including what's included in the cost and how to read the detailed usage reports.
ms.custom: sap:Log Analytics Billing
---
# Understand cost and usage in Log Analytics workspace

This article helps you learn how to understand the costs associated with your Log Analytics Workspace and to identify cost of each service that connects to the Log Analytics workspace.

## How to read the cost and usage reports

> [!NOTE]
> The prices shown in the following images are for example purposes only. They do not reflect actual pricing.

### Open View cost for the Log Analytics Workspace

1. Sign in to the [Azure portal](https://portal.azure.com). 
1. Enter **log analytics** in the search.
1. Under **Services**, select **Log Analytics**.
1. Select the Log Analytics Workspace that you want to investigate.  
1. On the **Overview** page, select **View Cost** to open the **Cost analysis** page for the current log analytics service. If you don't see **View Cost**, switch to [Azure preview portal](https://preview.portal.azure.com/).

    :::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost.png" alt-text="view cost step 1" lightbox="media/understand-log-analytics-workspace-bill/view-cost.png":::
1. In the **Cost analysis** page, select **View AccumulcatedCosts**, and then select **Resources**.
    :::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-2.png" alt-text="view cost step 1" lightbox="media/understand-log-analytics-workspace-bill/view-cost-2.png":::

## Read cost data in Invocie details

1. Hover over the '**+**' symbol and select it to open a new tab within the Cost analysis pane.  
1. In the new tab, select **Invoice details**. The Invoice details page shows cost for each service that connects (sends data) to the current log ana Log Analytics workspace.
The following is the example of invoce detail.

:::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-9.png" alt-text="view cost step 9" lightbox="media/understand-log-analytics-workspace-bill/view-cost-9.png":::

It appears that the Log Analytics meter shows lower usage compared to other services that send data into the Log Analytics workspace. This discrepancy suggests an area for further investigation or optimization in how these services utilize resources within your analytics environment.

### Read cost data in Resource

1. Select **Resources** tab.  

1. Update the month selected to match the specific month being examined for this billing cycle.

1. Ensure the total matches your invoice details. The default view of the **Resources** tab shows the total cost of the Log Analytics workspace, including the cost of data ingested from other services.

1. Select the name of the Log Analytics workspace to expand the details. You will see the cost of each service that ingests data to this Log Analytics workspace. This view can help you to identify which service is causing the unexpected expense.

:::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-11.png" alt-text="view cost step 3" lightbox="media/understand-log-analytics-workspace-bill/view-cost-11.png":::

## Read cost data in Services

1. Hover over the '**+**' symbol and select it to open a new tab within the Cost analysis pane, and then select **Service**.  

2. Update the month selected to match the specific month being examined for this billing cycle.
3. Ensure the total matches your invoice details.
4. Expand each service to view the charge type per **Service**.  

:::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-10.png" alt-text="view cost step 10" lightbox="media/understand-log-analytics-workspace-bill/view-cost-10.png":::

### Read cost data in Daily costs

1. Hover over the '**+**' symbol and select it to open a new tab within the Cost analysis pane.  
1. Select **Dailly cost**.  
1. Update the month (2) selected to match the specific month being examined for this billing cycle.
1. You notice the Total (3) matches your invoice details.
1. The Service name (4) pie chart displays in an alternative view that data-injecting services that are primarily responsible for driving the overall cost.
1. The bar chart displays a cost increase at the end of the month (5) which can be further investigated to determine the root cause.


[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
