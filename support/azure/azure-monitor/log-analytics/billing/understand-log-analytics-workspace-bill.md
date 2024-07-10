
---
title: Understand costs and usages in Microsoft Azure log analytics workspace
description: Explain how to view the costs associated with your Log Analytics Workspace and identify causes for increased expense.
ms.date: 07/01/2024
ms.author: neghuman
ms.service: azure-monitor
ms.custom: sap:Log Analytics Billing
---

# Understand costs and usages in Azure log analytics workspace

This article helps you learn how to view the costs associated with your log analytics workspace and to identify causes for increased expense.

##  view the costs in log analytics workspace

> [!NOTE]
> The prices shown in the following images are for example purposes only. They do not reflect actual pricing.

### Step 1: Open View cost in the Log Analytics workspace

1. Sign in to the [Azure portal](https://portal.azure.com). 
1. Enter **Log Analytics** in the search.
1. Under **Services**, select **Log Analytics**.
1. Select the Log Analytics workspace that you want to investigate.  
1. On the **Overview** page, select the **View Cost** link to open the **Cost analysis** page for the current Log Analytics service. If you don't see the **View Cost** link, switch to [Azure preview portal](https://preview.portal.azure.com/). 

    :::image type="content" source="media/identify-service-cause-unexpected-costs/view-cost.png" alt-text="view cost step 1" lightbox="media/identify-service-cause-unexpected-costs/view-cost.png":::


1. In the **Cost analysis** page, select **View AccumulcatedCosts**, and then **Resources**.  
:::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-2.png" alt-text="view cost step 2" lightbox="media/understand-log-analytics-workspace-bill/view-cost-2.png":::




1. Hover over the '**+**' symbol and select it to open a new tab within the Cost analysis pane.  
1. In the new tab, select **Invoice details**. The Invoice details page shows cost for each service that connects (sends data) to the current log ana Log Analytics workspace.
The following is the example of invoce detail.

:::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-9.png" alt-text="view cost step 9" lightbox="media/understand-log-analytics-workspace-bill/view-cost-9.png":::

1.  Select the **+** icon to open a new tab.
:::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-5.png" alt-text="view cost step 5" lightbox="media/understand-log-analytics-workspace-bill/view-cost-5.png":::

1. Select **Service** in the new tab.  
:::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-6.png" alt-text="view cost step 6" lightbox="media/understand-log-analytics-workspace-bill/view-cost-6.png":::

1. Select the **+** icon to open a new tab, and then select **Invoice details**.
:::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-7.png" alt-text="view cost step 7" lightbox="media/understand-log-analytics-workspace-bill/view-cost-7.png":::




1. You can now start reviewing and analyzing your bill for detailed assessment.  
    1. Ensure the appropriate resource group **(1)** is selected.
    1. Record the specific month **(2)** being examined for this billing cycle.
    1. Note the total actual cost for the month selected **(3)** which should match your invoice.
    1. For the Log Analytics workspace selected, note the highlighted cost **(4)** breakdown per meter.
    
     Looking at our case study, it's apparent that the Log Analytics meter reflects a smaller usage compared to the other services sending data directly into the Log Analytics workspace. This discrepancy suggests an area for further investigation or optimization in how those services utilize resources within your analytics environment.  

     :::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-9.png" alt-text="view cost step 9" lightbox="media/understand-log-analytics-workspace-bill/view-cost-9.png":::

1. Jump to the **Services** tab **(1)**.
    1. Update the month **(2)** selected to match the specific month being examined for this billing cycle.  
    1. You notice the Total **(3)** matches your invoice details.  
    1. Expand each service, **(4,5,6)** to view the charge type per **Service**.  
:::image type="content" source="media/understand-log-analytics-workspace-bill/view-cost-10.png" alt-text="view cost step 10" lsightbox="media/understand-log-analytics-workspace-bill/view-cost-10.png":::

### Read cost data in Daily costs

1. Hover over the '**+**' symbol and select it to open a new tab within the Cost analysis pane.  
1. Select **Dailly cost**.  
1. Update the month (2) selected to match the specific month being examined for this billing cycle.
1. You notice the Total (3) matches your invoice details.
1. The Service name (4) pie chart displays in an alternative view that data-injecting services that are primarily responsible for driving the overall cost.
1. The bar chart displays a cost increase at the end of the month (5) which can be further investigated to determine the root cause.


[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
