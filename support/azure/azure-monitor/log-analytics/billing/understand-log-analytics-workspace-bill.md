---
title: Understand cost and usage in Log Analytics workspace in Microsoft Azure
description: Learn how to understand the costs associated with your Log Analytics workspace and identify causes of increased expense.
ms.date: 07/01/2024
ms.author: neghuman
ms.service: azure-monitor
ms.custom: sap:Log Analytics Billing
---
# Understand cost and usage in a Log Analytics workspace

This article helps you learn how to understand the costs that are associated with your Log Analytics workspace and identify the causes of expense increases.

## How to read the cost and usage reports

> [!NOTE]
> The prices that are shown in the following images are examples only. They do not reflect actual pricing.

### Open View cost for the Log Analytics workspace

1. Sign in to the [Azure portal](https://portal.azure.com). 
1. Enter **log analytics** in the search bar.
1. Under **Services**, select **Log Analytics**.
1. Select the Log Analytics workspace that you want to investigate.  
1. On the **Overview** page, select **View Cost** to open the **Cost analysis** page for the current log analytics service. If you don't see **View Cost**, switch to the [Azure preview portal](https://preview.portal.azure.com/).

1. On the **Cost analysis** page, select **View AccumulcatedCosts**, and then select **Resources**.

   :::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-2.png" alt-text="view cost step 1" lightbox="media/understand-log-analytics-workspace-bill/view-cost-2.png":::

## Read cost report on Invoice details tab

1. Select the plus sign (+) to open a new tab within the **Cost analysis** page.  
1. On the new tab, select **Invoice details**. The **Invoice details** page shows the cost for each service that sends data to the current Log Analytics workspace.
1. Update the date range to match the specific month that you're examining for this billing cycle.

The following is an example of the Invoice details:

:::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-9.png" alt-text="view cost step 9" lightbox="media/understand-log-analytics-workspace-bill/view-cost-9.png":::

This example shows that the Log Analytics meter displays lower usage compared to other services that send data to the Log Analytics workspace. This discrepancy suggests an area for further investigation or optimization of how these services use resources within the current Log Analytics workspace.

### Read cost report on Resource tab

1. Select **Resources** tab.  

1. Update the date range to match the specific month that you're examining for this billing cycle. The total should now match the invoice details.

1.  The default view of the **Resources** tab shows the total cost of the Log Analytics workspace, including the cost of data ingested from other services.

1. Select the name of the Log Analytics workspace to expand the details. You will see the cost of each service that sends data to this Log Analytics workspace. This view can help you to identify which service is causing the unexpected expense.

   :::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-11.png" alt-text="view cost step 3" lightbox="media/understand-log-analytics-workspace-bill/view-cost-11.png":::

## Read cost report on Services tab

1. Select the plus sign (+) to open a new tab within the Cost analysis page, and then select **Service**.  
2. Update the month that's selected to match the specific month that you're examining for this billing cycle. The total should now match the invoice details.
1. Expand each service to view the charge type per **Service**.  

   :::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-10.png" alt-text="view cost step 10" lightbox="media/understand-log-analytics-workspace-bill/view-cost-10.png":::

### Read cost report on Daily costs tab

1. Select the plus sign (+) to open a new tab within the Cost analysis page.
1. Select **Daily cost**.  
1. Update the month that's selected to match the specific month that you're examining for this billing cycle. The total should now match the invoice details.
1. The Service name pie chart displays an alternative view that shows that data injection services are primarily responsible for driving the overall cost.
1. The bar chart displays a cost increase at the end of the month. This can be further investigated to determine the root cause.

   :::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-12.png" alt-text="view cost step 12" lightbox="media/understand-log-analytics-workspace-bill/view-cost-12.png":::

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
