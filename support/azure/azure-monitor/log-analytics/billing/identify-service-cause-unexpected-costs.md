---
title: Why the Log Analytics workspace costs increased unexpectedly
description: Describes how to investigate daily billing anomalies and identify the source of excessive charges by using detailed usage reports.
ms.date: 07/01/2024
ms.reviewer: neghuman
ms.author: neghuman
ms.service: azure-monitor
keywords:
#Customer intent: As an Azure Monitor user, I want to understand my Log Analytics workspace's bill including what's included in the cost and how to read the detailed usage reports.
ms.custom: sap:Log Analytics Billing
---
# Why Log Analytics workspace costs increased unexpectedly

This article provides a cost analysis tutorial to investigate daily billing anomalies and identify the service that caused unexpected costs.

## Identify the service that caused unexpected costs

> [!NOTE]
> The prices shown in the following images are for example purposes only. They do not reflect actual pricing.

### Step 1: Open View cost for the Log Analytics workspace

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Type **Log Analytics** in the search bar.
1. Under **Services**, select **Log Analytics**.
1. Select the Log Analytics workspace that you want to investigate.  
1. On the **Overview** page, select **View Cost** to open the **Cost analysis** page for the current Log Analytics service. If you don't see **View Cost**, switch to the [Azure preview portal](https://preview.portal.azure.com/). 

    :::image type="content" source="media/identify-service-cause-unexpected-costs/view-cost.png" alt-text="view cost step 1" lightbox="media/identify-service-cause-unexpected-costs/view-cost.png":::

### Step 2: Open daily cost reports

1. In the **Cost analysis** page, select **View AccumulcatedCosts**, and then select **Services**.

    :::image type="content" source="media/identify-service-cause-unexpected-costs/high-cost-1.png" alt-text="high cost step 1" lightbox="media/identify-service-cause-unexpected-costs/high-cost-1.png":::

1. Select the **+** icon to open a new tab.  

    :::image type="content" source="media/identify-service-cause-unexpected-costs/high-cost-2.png" alt-text="high cost step 2" lightbox="media/identify-service-cause-unexpected-costs/high-cost-2.png":::

1. Select **Daily costs**.  

    :::image type="content" source="media/identify-service-cause-unexpected-costs/high-cost-3.png" alt-text="high cost step 3" lightbox="media/identify-service-cause-unexpected-costs/high-cost-3.png":::

1. In the date selection, select a date range such as **Last 3 months** as the timeline.  

    :::image type="content" source="media/identify-service-cause-unexpected-costs/high-cost-4.png" alt-text="high cost step 4" lightbox="media/identify-service-cause-unexpected-costs/high-cost-4.png":::

1. Select **Group by** option and then select the **Meter category**.  

    :::image type="content" source="media/identify-service-cause-unexpected-costs/high-cost-4a.png" alt-text="high cost step 4a" lightbox="media/identify-service-cause-unexpected-costs/high-cost-4a.png":::

### Step 3: Analyze the cost

You're now prepared to analyze a cost spike, high usage, or anomaly assessment. The following image displays cost data from a Log Analytics service over the last three months, group by **Meter category**. In the stacked bar chart, three anomalous cost spikes are evident on March 31, April 30, and May 31. Select the stacked bar for April 30. It indicates that the Azure Grafana Service that linked to this Log Analytics caused the cost spike.

:::image type="content" source="media/identify-service-cause-unexpected-costs/high-cost-5.png" alt-text="high cost step 5" lightbox="media/identify-service-cause-unexpected-costs/high-cost-5.png":::

Additionally, the example cost was higher during the late May period due to a spike in Azure Sentinel usage. This is indicated by the increased height of the respective segments within the stacked bar.

:::image type="content" source="media/identify-service-cause-unexpected-costs/high-cost-6.png" alt-text="high cost step 6" lightbox="media/identify-service-cause-unexpected-costs/high-cost-6.png":::

Given the cost analysis tutorial, you're able to identify the specific services causing the cost spike. Then, you may need to investigate those services to understand why the spike occurred. If you need further assistance investigating the service, open a support case with respective service type.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
