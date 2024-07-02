---
title: Help me understand my Log Analytics workspace's bill, detailing the costs and how to read the detailed usage reports.
description: Learn how to understand the costs associated with your Log Analytics Workspace and identify causes for increased expense.
ms.date: 07/01/2024
ms.reviewer: neghuman
editor: neilghuman
ms.service: azure-monitor
keywords:
#Customer intent: As an Azure Monitor user, I want to understand my Log Analytics workspace's bill including what's included in the cost and how to read the detailed usage reports.
ms.custom: sap:Log Analytics Billing
---
# Help me understand my Log Analytics workspace's bill, detailing the costs and how to read the detailed usage reports.

This article helps you learn how to understand the costs associated with your Log Analytics Workspace and to identify causes for increased expense.

## How to steps

> [!NOTE]
> The prices shown in these images are for example purposes only. They aren't intended to reflect actual pricing.

<!-- Sign into the Azure portal to get started.

1. In the Azure portal, navigate to your Log Analytics resource. -->
1. Select the [Log Analytics workspace blade](button-link:https://portal.azure.com/#browse/Microsoft.OperationalInsights%2Fworkspaces) to get started, then select your specific Log Analytics Workspace.  
:::image type="content" source="media/log-analytics-workspaces.png" alt-text="select log analytics workspaces" lightbox="media/log-analytics-workspaces.png":::

1. Select **View Cost**  
:::image type="content" source="media/view-cost.png" alt-text="view cost" lightbox="media/view-cost.png":::

1. Under the view dropdown, select **Resources**.  
:::image type="content" source="media/view-cost-2.png" alt-text="view cost step 2" lightbox="media/view-cost-2.png":::

1. Hover over the '**+**' symbol and select it to open a new tab within the Cost analysis pane.  
:::image type="content" source="media/view-cost-3.png" alt-text="view cost step 3" lightbox="media/view-cost-3.png":::

1. Select the **Service** tab.  
[![view cost step 4](/media/view-cost-4.png)](/media/view-cost-4.png#lightbox)

1. Hover over the '**+**' symbol and select it to open a new tab within the Cost analysis pane.  
[![viewcost5.png](https://learn.microsoft.com/azure/azure-monitor/media/self-help/log-analytics/billing/high-res/view-cost-5.png)](https://learn.microsoft.com/azure/azure-monitor/media/self-help/log-analytics/billing/high-res/view-cost-5.png)

1. Select the **Daily costs** tab.  
[![viewcost6.png](https://learn.microsoft.com/azure/azure-monitor/media/self-help/log-analytics/billing/high-res/view-cost-6.png)](https://learn.microsoft.com/azure/azure-monitor/media/self-help/log-analytics/billing/high-res/view-cost-6.png)

1. Hover over the '**+**' symbol and select it to open a new tab within the Cost analysis pane.  
[![viewcost7.png](https://learn.microsoft.com/azure/azure-monitor/media/self-help/log-analytics/billing/high-res/view-cost-7.png)](https://learn.microsoft.com/azure/azure-monitor/media/self-help/log-analytics/billing/high-res/view-cost-7.png)

1. Select the **Invoice details** tab.  
[![viewcost8.png](https://learn.microsoft.com/azure/azure-monitor/media/self-help/log-analytics/billing/high-res/view-cost-8.png)](https://learn.microsoft.com/azure/azure-monitor/media/self-help/log-analytics/billing/high-res/view-cost-8.png)

1. You can now start reviewing and analyzing your bill for detailed assessment.  
    1. Ensure the appropriate resource group (1) is selected.
    1. Record the specific month (2) being examined for this billing cycle.
    1. Note the total actual cost for the month selected (3) which should match your invoice.
    1. For the Log Analytics workspace selected, note the highlighted cost (4) breakdown per meter.
    
     Looking at our case study, it's apparent that the Log Analytics meter reflects a smaller usage compared to the other services sending data directly into the Log Analytics workspace. This discrepancy suggests an area for further investigation or optimization in how those services utilize resources within your analytics environment.  
[![viewcost9.png](https://learn.microsoft.com/azure/azure-monitor/media/self-help/log-analytics/billing/high-res/view-cost-9.png)](https://learn.microsoft.com/azure/azure-monitor/media/self-help/log-analytics/billing/high-res/view-cost-9.png)

1. Jump to the **Services** tab (1).
    1. Update the month (2) selected to match the specific month being examined for this billing cycle.  
    1. You notice the Total (3) matches your invoice details.  
    1. Expand each service, (4,5,6) to view the charge type per **Service**.  
[![viewcost10.png](https://learn.microsoft.com/azure/azure-monitor/media/self-help/log-analytics/billing/high-res/view-cost-10.png)](https://learn.microsoft.com/azure/azure-monitor/media/self-help/log-analytics/billing/high-res/view-cost-10.png)

1. Jump to the **Resources** (1) tab.
    1. Update the month (2) selected to match the specific month being examined for this billing cycle. 
    1. You notice the Total (3) matches your invoice details.
    1. To gain a comprehensive view of the expenses associated with your Log Analytics workspace, simply select on the arrow (4) next to its name. Initially, without delving into the individual line items, one might incorrectly assume that the Log Analytics workspace incurs prohibitively high costs. However, upon expanding and examining each service's contribution within this workspace, you discover that it isn't the Log Analytics workspace itself but rather the data-injecting services that are primarily responsible for driving the overall cost.  
[![viewcost11.png](https://learn.microsoft.com/azure/azure-monitor/media/self-help/log-analytics/billing/high-res/view-cost-11.png)](https://learn.microsoft.com/azure/azure-monitor/media/self-help/log-analytics/billing/high-res/view-cost-11.png)

1. Hop over to the **Daily costs** tab.
    1. Update the month (2) selected to match the specific month being examined for this billing cycle. 
    1. You notice the Total (3) matches your invoice details.
    1. The **Service name** (4) pie chart displays in an alternative view that data-injecting services that are primarily responsible for driving the overall cost.
    1. The bar chart displays a cost increase at the end of the month (5) which can be further investigated to determine the root cause. This is covered in the next expandable section.  
[![viewcost12.png](https://learn.microsoft.com/azure/azure-monitor/media/self-help/log-analytics/billing/high-res/view-cost-12.png)](https://learn.microsoft.com/azure/azure-monitor/media/self-help/log-analytics/billing/high-res/view-cost-12.png)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
