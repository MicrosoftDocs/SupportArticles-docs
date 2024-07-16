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

## Understand and analyze the cost reports

> [!NOTE]
> The prices that are shown in the following images are examples only. They do not reflect actual pricing.

1. Sign in to the [Azure portal](https://portal.azure.com). 
1. Enter **log analytics** in the search bar.
1. Under **Services**, select **Log Analytics**.
1. Select the Log Analytics workspace that you want to investigate.
    :::image type="content" source="media/understand-log-analytics-workspace-bill/log-analytics-workspaces.png" alt-text="Screenshot of a specific Log Analytics workspace." lightbox="media/understand-log-analytics-workspace-bill/log-analytics-workspaces.png":::
1. On the **Overview** page, select **View Cost** to open the **Cost analysis** page for the current log analytics service.
     :::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost.png" alt-text="Screenshot that shows how to open the View Cost page." lightbox="media/understand-log-analytics-workspace-bill/view-cost.png":::
1. On the **Cost analysis** page, select **View AccumulatedCosts**, and then select **Resources**.

   :::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-2.png" alt-text="Screenshot that shows how to open Resources page." lightbox="media/understand-log-analytics-workspace-bill/view-cost-2.png":::

1. Select the plus sign (+) to open a new tab.
   :::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-3.png" alt-text="Screenshot that shows how to a new tab." lightbox="media/understand-log-analytics-workspace-bill/view-cost-3.png":::
1. In the new tab, select **Services**.  
   :::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-4.png" alt-text="Screenshot that shows how to open Services view in the new tab." lightbox="media/understand-log-analytics-workspace-bill/view-cost-4.png":::
1. Select the plus sign (+) to open a new tab, and then select **Daily costs**.
      :::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-6.png" alt-text="Screenshot that shows how to open Daily costs view in the new tab." lightbox="media/understand-log-analytics-workspace-bill/view-cost-5.png":::
1. Select the plus sign (+) to open a new tab, and then select **Invoice details**.
         :::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-8.png" alt-text="Screenshot that shows how to open Invoice details view in the new tab." lightbox="media/understand-log-analytics-workspace-bill/view-cost-5.png":::

1. You can now start reviewing and analyzing your cost for detailed assessment. 

   1. Ensure that the appropriate resource group (1) is selected.
   2. Record the specific month (2) being examined for this billing cycle.
   3. Note the total actual cost (3) for the selected month, ensuring it matches your invoice.
   4. Sort in descending order by cost (4), paying attention to the services with the highest cost.

   In the following example of the Invoice details, it shows that the Log Analytics meter displays lower usage compared to other services that send data to the Log Analytics workspace. This discrepancy suggests an area for further investigation or optimization of how these services use resources within the current Log Analytics workspace.

   :::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-9.png" alt-text="Screenshot of a sample Invoice details page." lightbox="media/understand-log-analytics-workspace-bill/view-cost-9.png":::

1. Switch to the **Services** tab (1), and then:
   1. Update the date range (2) to match the specific month that you're examining for this billing cycle.
   1. Ensure that the total cost (3) matches your invoice details.
   1. Expand each service to view the charge type per service (4)(5)(6).
   :::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-10.png" alt-text="Screenshot of the example of view in the Services page." lightbox="media/understand-log-analytics-workspace-bill/view-cost-10.png":::
1. Switch to the **Resources** tab (1), and then:
   1. Update the date range (2) to match the specific month that you're examining for this billing cycle. The total should now match the invoice details.

   1.  The default view of the **Resources** tab shows the total cost (3) of the Log Analytics workspace, including the cost of data ingested from other services.

   1. To gain a comprehensive view of expenses associated with your Log Analytics workspace, select on the arrow (4) next to the Log Analytics workspace name. Initially, without delving into individual line items, one might incorrectly assume that the Log Analytics workspace incurs prohibitively high costs. However, upon expanding and examining each service's contribution within this workspace, you discover that it is not the Log Analytics workspace itself but rather the data-injecting services that primarily drive the overall cost.

   :::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-11.png" alt-text="Screenshot of the cost of each service." lightbox="media/understand-log-analytics-workspace-bill/view-cost-11.png":::

1. Switch to the **Daily costs** tab (1), and then:

   1. Update the date range (2) to match the specific month that you're examining for this billing cycle.
   1. Ensure that the total cost (3) matches your invoice details.
   1. The Service name pie (4) chart displays an alternative view that shows that data injection services are primarily responsible for driving the overall cost.
   1. The bar chart displays a cost increase at the end of the month (5). This can be further investigated to determine the root cause.
   :::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-12.png" alt-text="Screenshot of the example of view in the Daily costs tab." lightbox="media/understand-log-analytics-workspace-bill/view-cost-12.png":::

## Next steps

> [!div class="nextstepaction"]
> [Investigate unexpected cost increases in the Log Analytics workspace](./identify-service-cause-unexpected-costs.md)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
