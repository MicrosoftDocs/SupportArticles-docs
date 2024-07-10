---
title: Why daily cap was exceeded in Microsoft Azure Log Analytics workspace
description: Learn how to manage data volume of your Azure Log Analytics workspace
ms.date: 07/01/2024
ms.author: neghuman
ms.service: azure-monitor
keywords:
#Customer intent: Learn how to manage data volume of your Azure Log Analytics workspace.

ms.custom: sap:Log Analytics Billing
---
# Why daily cap was exceeded in Log Analytics workspace

This article helps you learn how to manage data volume of your Azure Log Analytics workspace.

## Check your current usage

Learning to manage data volume is crucial for maintaining the health and performance of your Azure Log Analytics workspace. If you're experiencing daily cap issues, it could be due to a high volume of data ingestion or retention settings that need adjustment. This article provides guidance on how to control your data volume by setting up a daily cap and to identify potential root causes for daily cap issues.

### Select your Log Analytics Workspace

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Enter **log analytics** in the search bar.
1. Under **Services**, select **Log Analytics**.
1. Select your specific Log Analytics Workspace.
1. In the **Monitoring** section, select **Insights**  

    :::image type="content" source="media/why-daily-cap-exceeded/check-your-current-usage-1.png" alt-text="check your current usage step 1" lightbox="media/why-daily-cap-exceeded/check-your-current-usage-1.png":::

1. On the **Overview** tab, set the **Time Range** to Last 24 hours.
1. check the following data:
    1. Ingestion Volume
    1. Daily Usage / Cap setting.
    
    If the ingestion Volume exceeds the daily cap setting is close to exceeding the daily cap limit, you might consider investigating which service is causing this issue or increasing the daily cap.

    :::image type="content" source="media/why-daily-cap-exceeded/check-your-current-usage-2.png" alt-text="check your current usage step 2" lightbox="media/why-daily-cap-exceeded/check-your-current-usage-2.png":::

1. Scroll down to the **Ingestion Anomalies** section. Anomalies should be investigated further with the appropriate resource provider to identify issues.

    :::image type="content" source="media/why-daily-cap-exceeded/check-your-current-usage-3.png" alt-text="check your current usage step 3" lightbox="media/why-daily-cap-exceeded/check-your-current-usage-3.png":::

1. Select the **Usage** tab on the **Insights** page.This tab provides information on the workspace's usage. The dashboard subtab shows ingestion data displayed in tables. It defaults to the five most-ingested tables in the selected time range.
1. In the Usage table, select a specific row to show the **Ingestion Statics by Resource** subtable.
1. In the example below, the **AVSSyslog** and **AzureDiagnostic** tables contain a significant volume of ingestion. To identify the resource or application responsible for sending data to these tables, select the row in VSSyslog. It was discovered that the resource 'ch1-avs' is causing the notable ingestion.
    
    :::image type="content" source="media/why-daily-cap-exceeded/check-your-current-usage-4.png" alt-text="check your current usage step 4" lightbox="media/why-daily-cap-exceeded/check-your-current-usage-4.png":::
 
    Select the **AzureDiagnostic** row and observe that most of the data originates from two Kubernetes services called KS1 and KS2. Further investigation is needed to understand why these Kubernetes services are generating high-volume log data.
    
    :::image type="content" source="media/why-daily-cap-exceeded/check-your-current-usage-5.png" alt-text="check your current usage step 5" lightbox="media/why-daily-cap-exceeded/check-your-current-usage-5.png":::

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
