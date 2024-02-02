---
title: Troubleshoot missing CPU Total and Committed Memory metrics
description: Troubleshoot missing CPU Total and Committed Memory metrics when you look at live metrics in Application Insights.
ms.date: 05/09/2022
ms.reviewer: vitalyg, toddfous, v-leedennis
ms.service: azure-monitor
ms.subservice: application-insights
#Customer intent: As an Application Insights user, I want to troubleshoot missing "CPU Total" and "Committed Memory" metrics so that I can view their respective live metric charts.
---
# Troubleshoot missing CPU Total and Committed Memory metrics in Application Insights

This article discusses how to troubleshoot a problem in [Application Insights](/azure/azure-monitor/app/app-insights-overview) that prevents you from viewing metrics that are related to CPU and memory performance.

## Symptoms

In the [Azure portal](https://portal.azure.com), if you go to your Application Insights resource's overview page and select **Live Metrics**, you don't see the metrics charts for **CPU Total** and **Committed Memory**. These two metrics are also missing if you select other items in the navigation pane, such as **Performance**, **Failures**, **Metrics**, or **Logs**.

## Cause

When you run the monitoring web application on a Windows computer or virtual machine, the instrumentation package (SDK) that you installed for your application doesn't have the correct permissions to read computer-level performance counter values. For the SDK to have access, the application pool identity under which your web application runs must be added as a member of the following local security groups:

- **Performance Log Users**
- **Performance Monitor Users**

## Solution

On the computer or virtual machine that hosts the application, add your user account to both the **Performance Log Users** group and the **Performance Monitor Users** group by following these steps:

1. Sign in to the computer or virtual machine as an administrator.

1. On the **Start** menu, search for and select **Computer Management** (*compmgmt.msc*), and then press Enter to open the **Computer Management** snap-in.

1. In the navigation pane, expand **System Tools**, expand **Local Users and Groups**, and then select **Groups**. In the list of groups, select **Performance Log Users**.

    :::image type="content" source="./media/missing-cpu-total-committed-memory-metrics/computer-management-snap-in.png" alt-text="Screenshot of the Computer Management snap-in, which shows the Performance Log Users group under System Tools > Local Users and Groups > Groups." lightbox="./media/missing-cpu-total-committed-memory-metrics/computer-management-snap-in.png" border="false":::

1. Select the **Properties** icon to display the property dialog box for the group. Then, select **Add** to display the **Select Users** dialog box.

1. In the **Enter the object names to select** box, type the name of the user account or group account that you want to add. Then, select **OK** and **OK** to save the changes and return to the snap-in window.

1. In the list of groups, select **Performance Monitor Users**, and then repeat the previous two steps.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
