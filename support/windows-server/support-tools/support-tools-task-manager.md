---
title: Troubleshoot processess using Task Manager
description: Describes the features of Task Manager and provides examples of how to apply those features when troubleshooting.
ms.date: 04/29/2024
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:System Performance\Performance tools (Task Manager, Perfmon, WSRM, and WPA), csstroubleshoot
keywords: Task Manager
---

# Troubleshoot processess using Task Manager

This article describes the features of Task Manager and provides examples of how to apply those features when troubleshooting.

_Applies to:_ &nbsp;  All supported versions of Windows Server and Windows Client

## Summary

Task Manager is the Windows in-box solution for monitoring application and process performance and resource usage.

## More information

Task Manager consists of live data tables and charts that're populated from different data sources in Windows and in private APIs. Task Manager's appearance varies slightly depending on the Windows or Windows Server version, but the data comes from the same sources. Task Manager displays data on the following tabs:

| Tab | Data types |
| --- | --- |
| **Processes** | List of apps and background processes, and the resource usage of each. |
| **Performance** | Lists and graphs of performance data. Separate views are available for CPU performance and memory performance, and other performance categories (depending on the computer's configuration). |
| **Users** | List of signed-in users, and the processes that run under that user's context. Additional data, such as resource usage for each process, is available. |
| **Details** | List of the processes running on the computer, regardless of whether they're apps or background processes. Additional data, such as user context, resource usage, and description is available. |
| **Services** | List of the services running on the computer. The list format resembles that of the Services MMC console (*services.msc*). You can stop and start services from this page, or go from this page to the Services console. |

> [!NOTE]  
> The first time that you open Task Manager, you might see its condensed view. This view resembles the following:
>
>:::image type="content" source="media/support-tools-task-manager/task-mgr-minimized.png" alt-text="Screenshot that shows the condensed view of Task Manager.":::
>
> To get the full view, at the bottom of the Task Manager window, select **More details**.

For a general introduction to Task Manager, see [Task Manager](/shows/inside/task-manager).

### Examples of how to use Task Manager to troubleshoot

#### Examining CPU load

When you use the default view, the **Performance** tab shows the overall CPU load for the computer, regardless of the number of physical or logical processors.

:::image type="content" source="media/support-tools-task-manager/task-mgr-cpu.png" alt-text="Screenshot that shows the overall CPU display on the Performance tab of Task Manager.":::

You can break down this data in terms of the load produced by kernel processes and the load produced by user processes. To do this, right-click the graph, and then select **Show kernel times**. The trace on the graph splits into two colors, one for kernel processes and one for user processes.

:::image type="content" source="media/support-tools-task-manager/task-mgr-cpu-kernel-detail.png" alt-text="Screenshot that shows the overall CPU display on the Performance tab of Task Manager, using the Show kernel times feature.":::

You can also break down the data in terms of the load on each logical processor. When you look at the overall (default) graph, you can calculate the approximate load per processor by dividing the load by the number of processors. For example, on a computer that has eight logical processors, you can calculate the load per processor (at 100% capacity) as follows:

> 100%/8=12.5%

Each processor carries 12.5% of the CPU load. Conversely, if a process uses 12.5% of the CPU capacity, the process is using the equivalent of one full CPU.

To view more precise load information, right-click the graph, and then select **Change graph to** > **Logical processors**. The graph splits into multiple graphs, one for each processor.

:::image type="content" source="media/support-tools-task-manager/task-mgr-cpu-logical-detail.png" alt-text="Screenshot that shows the logical CPU display on the Performance tab of Task Manager.":::

As you can see here, different logical processors carry different loads.

#### Examining process details

You can use the **Processes**, **Users**, and **Details** tabs to view the active processes on the computer. The lists differ in how they sort and group the process information. This example uses the **Details** tab.

You can change the displayed columns by right-clicking one of the column heads and then selecting **Select columns**. In the following image, the **Threads** column has been added:

:::image type="content" source="media/support-tools-task-manager/task-mgr-process-detail.png" alt-text="Screenshot that shows the process list on the Details tab of Task Manager.":::

Task Manager doesn't provide details about the individual threads. However, you can dump detailed information about a process to analyze or to provide to your support vendor.

To do this, in any of the process list tabs, right-click the process and then select **Create memory dump file**.

:::image type="content" source="media/support-tools-task-manager/task-mgr-create-mem-dump.png" alt-text="Screenshot that shows the Create memory dump file command on the context menu of a process in Task Manager.":::

#### Examining Wait chain Analyzer

Applications that are not responding might be waiting for other processes to finish, or for system resources to become available, before they can continue. You can also use Task Manager to analyze the wait chain of a process.

1. Right-click the executable name of the process you want to analyze, and then click **Analyze Wait Chain**.
2. If the process is running normally and is not waiting for any other processes, no wait chain information will be displayed.
    
    If the process is waiting for another process, a tree organized by dependency on other processes will be displayed.
    
> [!NOTE]
> Many system processes depend on other processes and services for normal operation. Resource Monitor will display wait chain information for any process. If a process entry in the table is not red, if the process status is <STRONG>Running</STRONG>, and if the program is operating normally, no user action should be required. 

3.  If a wait chain tree is displayed, you can end one or more of the processes in the tree by selecting the check boxes next to the process names and clicking **End process**.
