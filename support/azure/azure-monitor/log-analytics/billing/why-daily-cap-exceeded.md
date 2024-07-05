---
title: Help me identify why my daily cap was exceeded.
description: Learn how to manage data volume of your Azure Log Analytics workspace.
ms.date: 07/01/2024
ms.reviewer: neghuman
editor: neilghuman
ms.service: azure-monitor
keywords:
#Customer intent: Learn how to manage data volume of your Azure Log Analytics workspace.

ms.custom: sap:Log Analytics Billing
---
# Help me identify why my daily cap was exceeded.

This article helps you learn how to manage data volume of your Azure Log Analytics workspace.

## Check your current usage.

Learning to manage data volume is crucial for maintaining the health and performance of your Azure Log Analytics workspace. If you're experiencing daily cap issues, it could be due to a high volume of data ingestion or retention settings that need adjustment. This article provides guidance on how to control your data volume by setting up a daily cap and to identify potential root causes for daily cap issues.

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
:::image type="content" source="media/log-analytics-workspaces.png" alt-text="select log analytics workspaces" lightbox="media/log-analytics-workspaces.png":::

1. Select Insights (1)  
:::image type="content" source="media/check-your-current-usage-1.png" alt-text="check your current usage step 1" lightbox="media/check-your-current-usage-1.png":::

1. While on the Insights (1) tab, set the Time Range (2) to Last 24 hours.
    1. Make note of the Ingestion Volume (3)
    1. Make note of the Daily Usage / Cap (4) setting.
        1. If the daily cap setting exceeds the Ingestion Volume setting or is close to exceeding the daily cap limit, an investigation is warranted.  
        :::image type="content" source="media/check-your-current-usage-2.png" alt-text="check your current usage step 2" lightbox="media/check-your-current-usage-2.png":::

1. Use the scroll bar (1) to scroll down and make note of any Ingestion Anomalies (2). Anomalies should be investigated further with the appropriate resource provider to identify any problems or issues.  
:::image type="content" source="media/check-your-current-usage-3.png" alt-text="check your current usage step 3" lightbox="media/check-your-current-usage-3.png":::

1. While on the Insights tab, select the Usage (2) tab.
    1. Mouse over a row in the Workspace tables (3) and select a specific row to light up the Ingestion Statics by Resource.
    1. For our particular use case, the resource (4) was then identified causing the large amount of ingestion warranting a further investigation.  
    :::image type="content" source="media/check-your-current-usage-4.png" alt-text="check your current usage step 4" lightbox="media/check-your-current-usage-4.png":::
 
1. Another example in our particular scenario, select the AzureDiagnostics (1) table.
    1. This identifies which specific resources are sending data to this table (2) and now warrants an investigation as the specific resources are now displayed.  
    :::image type="content" source="media/check-your-current-usage-5.png" alt-text="check your current usage step 5" lightbox="media/check-your-current-usage-5.png":::

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
