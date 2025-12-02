---
title: Troubleshoot High CPU Usage in an IIS Application Pool
description: Helps you to identify the cause of sustained high CPU usage in an IIS app pool by using Debug Diagnostics and Performance Monitor.
ms.date: 04/17/2025
ms.author: aartigoyle
author: aartig13
ms.reviewer: johnhart, riande, jamesche
ms.custom: sap:Site Behavior and Performance\High CPU usage
---
# Troubleshooting High CPU in an IIS application pool

_Applies to:_ &nbsp; Internet Information Services

This troubleshooter will help you to identify the cause of sustained high CPU in an Internet Information Services (IIS) application pool. It's important to keep in mind that CPU usage typically increases when a web application serves requests. However, if you consistently see CPU remain at a high level for a prolonged period (approximately 80 percent or greater), you can expect the performance of your application to suffer. Therefore, it's important to understand the cause of sustained high CPU to be able to diagnose and correct it.

## Scenario

An application pool in IIS experiences a prolonged period of high CPU that exceeds 90 percent of the time. When the application is tested, no problems occur. However, after the application experiences actual user load, CPU usage climbs to a high percentage and remains there. To recover the application pool, must be restarted, but after doing so, CPU again climbs to a high level.

## Tools

- [Debug Diagnostics (DebugDiag)](https://www.microsoft.com/download/details.aspx?id=103453)
- Performance Monitor (Perfmon)
- [Perfview](https://github.com/microsoft/perfview/releases)

## Data collection

In a high CPU scenario, begin by determining the process that is consuming CPU. You can use the **Processes** tab in Task Manager. Make sure that you select the **Show processes from all users** checkbox. The following image shows this box selected, and the `w3wp.exe` process (the process that hosts an IIS application pool) consuming a high level of CPU.

:::image type="content" source="media/troubleshoot-high-cpu-in-iis-app-pool/windows-task-manager-w3wp.png" alt-text="Windows Task Manager showing the C P U column in which 85 is highlighted on the w 3 w p executable row. The show processes from all users option is selected.":::

You can also use Performance Monitor to determine which process is using CPU. For more information about how to use Performance Monitor, see [Analyzing performance data](#analyzing-performance-data).

> [!TIP]
> If you have to identify which application pool is associated with a particular w3wp.exe process, open an administrative Command Prompt window, switch into the `%windir%\System32\inetsrv` folder (`cd %windir%\System32\inetsrv`), and then run `appcmd list wp`. This command shows the process identifier (PID) of the w3wp.exe process in quotation marks. You can match that PID to the PID that's available in Task Manager.

After you verify that a w3wp.exe process is experiencing high CPU, you have to collect the following information in order to determine what is causing the problem:

- A Performance Monitor data collector set
- A user-mode memory dump file of the w3wp.exe process or a ETW trace

In general, ETW tracing does not affect performance. This feature makes it useful in production scenarios where the primary concern is the period during which logs are collected. For example, threads are paused during memory dump file collection. This condition makes ETW traces a good alternative method.

In most cases during a high CPU event that has standard memory consumption, you can collect either an ETW trace or memory dump files. An ETW trace file can hold more information that's related to CPU consumption over time. However, it doesn't provide the in-depth view of objects, their values, and their roots that a memory dump file does.  Therefore, you might want to consider using both methods. 

The goal is to gather data that enables a view of operations on the same non-waiting threads over the portion time when w3wp.exe CPU is highest as possible. Follow these guidelines for dump files:
- Multiple files are necessary (three is usually sufficient).
- Files should be collected during the high CPU event from the same process ID. 
- Files should be taken close enough to one another (typically, 10 seconds apart) that these threads are still alive, and a thread in each file might still carry related operations.
- Files should be collected within a CPU usage that is considered high and abnormal. The activity that you're measuring is the w3wp.exe consumption of CPU, not the total server CPU usage.

### Collecting a Performance Monitor data collector set

Performance Monitor data is often critical in determining the cause of high CPU issues. It can also be helpful to form a "big picture" view of how your application performs.

Perfmon data can be viewed in real time or it can be collected in a data collector set for later review. Troubleshooting a high CPU situation requires a data collector set. To create a data collector set, follow these steps:

1. In Control Panel, open Administrative Tools.
1. Double-click **Performance Monitor**.
1. Expand the **Data Collector Sets** node.
1. Right-click **User Defined**, and select **New** > **Data Collector Set**.
1. Name the data collector set _High CPU_.
1. Select **Create Manually (Advanced)**.
1. Select **Next**.
1. Select **Create Data Logs**.
1. Select the **Performance Counter** checkbox.
1. Select **Next**.
1. Select **Add**. If your application is not an ASP.NET application, go to step 19.
1. Scroll to the top of the list of counters, and select **.NET CLR Memory**.
1. In the list of instances, select **\<all instances\>**.
1. To add the counters to the list of added counters, select **Add**.
1. Select **ASP.NET** from the list of counters, and then select **Add**.
1. In the list of counters, select **ASP.NET Applications**.
1. In the list of instances, select **\<all instances\>**.
1. Select **Add**.
1. In the list of counters, expand **Process**. (Make sure that you expand **Process** and not **Processor**.)
1. In the **Process** object, select **% Processor Time**.
1. In the list of instances, select **\<all instances\>**.
1. Select **Add**.
1. In the list of counters, expand **Thread**.
1. In the **Thread** object, select **% Processor Time**.
1. In the list of instances, select **\<all instances\>**.
1. Select **Add**.
1. In the list of instances, select **ID Thread**.
1. Select **Add**.

The dialog box should now resemble the following image.

:::image type="content" source="media/troubleshoot-high-cpu-in-iis-app-pool/data-collection-properties-dialog.png" alt-text="The Data Collection 0 1 Properties dialog box. I D Thread is selected on the Performance Counters tab.":::

Select **OK** > **Next**. Note where the data collector set is being saved. (You can change this location if you have to.) Then, select **Finish**.

The data collector set is not yet running. To start it, go to under the **User Defined** node, locate and right-click **High CPU**, and then select **Start** on the menu.

### Creating a Debug Diagnostics rule

The easiest way to collect user-mode process dump files when a high CPU condition occurs is to use Debug Diagnostics.

[Download DebugDiag](https://www.microsoft.com/download/details.aspx?id=103453), install and run it on your server. When you run DebugDiag, the tool displays the **Select Rule Type** dialog box. To create a crash rule for your application pool, follow these steps:

1. Select **Performance** > **Next**.
1. Select **Performance Counters** > **Next**.
1. Select **Add Perf Triggers**.
1. Expand the **Processor** (not the **Process**) object, and then select **% Processor Time**.
1. In the list of instances, select **\_Total**.
1. Select **Add** > **OK**.
1. Select the newly added trigger, and then select **Edit Thresholds**.
    :::image type="content" source="media/troubleshoot-high-cpu-in-iis-app-pool/select-performance-counters-dialog.png" alt-text="The Select Performance Counters dialog box.":::  
1. On the drop-down list, select **Above**.
1. Change the threshold to **80**.
1. Enter **20** for the number of seconds. (You can adjust this value if it's necessary. But to prevent false triggers, be careful not to specify a small number of seconds.)
1. Select **OK**.
1. Select **Next**.
1. Select **Add Dump Target**.
1. On the drop-down list, select **Web Application Pool**.
1. In the list of application pools, select your application pool.
1. Select **OK**.
1. Select **Next** two times.
1. Enter a name for your rule if you want, and note the location in which to save the dump files. You can change this location later.
1. Select **Next**.
1. Select **Activate the Rule Now**, and then select **Finish**.

> [!TIP]
> You can create dump files of multiple application pools by adding multiple dump file targets by using the same technique that you used in steps 13-15.

This rule creates 11 dump files. The first 10 are "mini dumps". The final dump file has full memory and is much larger.

After the high CPU problem occurs, stop the Perfmon data collector set from collecting data. To take this step, right-click the **High CPU** data collector set that's listed under the **User Defined** node, and then select **Stop**.

### Collecting ETW Tracing by using Perfview

- Download [Perfview](https://github.com/microsoft/perfview/releases), and run it as administrator.
- Open the **Collect** menu, and select the **Collect** command (shortcut: ALT+C).
- Select the **Zip**, **Merge**, and **Thread Time** checkboxes.
- Expand the **Advanced Options** tab, and select the **IIS** checkbox.
- Press the **Start Collection** button. 
- PerfView starts collecting the data. After that process finishes, select **Stop collection**. PerfView merges various ETL files into a compressed file that will be stored in the same folder as PerfView.exe. This is the file to be shared for analysis.

## Data analysis

After the high CPU event, you will have two sets of data to review: The Perfmon data collector set and the memory dump files. Begin by reviewing the Perfmon data.

### Analyzing performance data

To review the Perfmon data for your issue, right-click the **High CPU** data collector set that's listed under the **User Defined** node, and then select **Latest Report**. You'll see a report that resembles the following screenshot.

:::image type="content" source="media/troubleshoot-high-cpu-in-iis-app-pool/performance-monitor-window.png" alt-text="The Performance Monitor window.":::

Remove all the current counters so that you can add explicit ones that you want to review. Select the first counter in the list, press and hold Shift, scroll to the bottom of the list, select the last counter, and then press Delete.

Now add the **Process** / **% Processor Time counter**. Follow these steps:

1. Right-click anywhere in the right pane of Perfmon, and select **Add Counters**.
1. Expand the **Process** object.
1. On the list, select **% Processor Time**.
1. On the instance list, select **\<all instances\>**.
1. Select **Add**.
1. Select **OK**.

You will now have a display that shows a graph of processor time used by each process on the computer during the time that the data collector set was running. The easiest way to isolate which process was using the highest level of CPU is to enable the highlight feature of Perfmon.

To do that, select the first counter in the list and then press Ctrl + H. After you've done this, the selected process will show as a bolded black line on the graph.

Use the down arrow on your keyboard to move down through the list of processes until you find the process that shows the most CPU usage. In the following screenshot, you can clearly see that the w3wp.exe process was using a large amount of CPU on the machine. This confirms that the IIS application pool is causing high CPU utilization on the computer.

:::image type="content" source="media/troubleshoot-high-cpu-in-iis-app-pool/perf-monitor-w3wp-cpu-usage.png" alt-text="Screenshot that shows the Performance Monitor window. Perfmon shows the C P U usage of the w 3 w p executable.":::

> [!TIP]
> Perfmon can be useful to help determine performance problems in your application. The data that's collected in the Perfmon log can show you how many requests are running (by using the ASP.NET and ASP.NET Applications objects). It can also show you other important performance data about how your application is performing.

To determine the cause of the high CPU issue, review the dump files that were created by using DebugDiag.

### Dump file analysis in DebugDiag

DebugDiag can recognize many issues by doing an automated dump file analysis. For this particular issue, DebugDiag's Performance Analyzers are well-suited to help identify the root cause of the high CPU issue. To use the analyzer, follow these steps:

1. Select the **Advanced Analysis** tab in DebugDiag.
1. Select the **Performance Analyzers**.
1. Select **Add Data Files**.
1. Navigate to the location where the dump files were created. By default, this will be a subfolder of the _C:\Program Files\DebugDiag\Logs_ folder.
1. Select one of the dump files, and then press Ctrl + A to select all the files in that folder.
1. Select **Open**.
1. Select **Start Analysis**.

DebugDiag takes a few minutes to parse through the files and provide an analysis. Ater this process finishes, you see a page that resembles the following image.

:::image type="content" source="media/troubleshoot-high-cpu-in-iis-app-pool/ie-debug-diag-analysis-report.png" alt-text="Internet Explorer window that displayes the Debug Diag analysis report.":::

Notice that the top of the report indicates that high CPU is detected. The right column contains recommendations that include a link to the top seven threads by average CPU time. Select that link to see information about what those top CPU consumers were doing, as in the following example.

:::image type="content" source="media/troubleshoot-high-cpu-in-iis-app-pool/function-stats-page.png" alt-text="The Functions Stats page as viewed in a browser.":::

In this example, the _default.aspx_ page in the FastApp application is running. If you look further down the call stack (at the bottom of the page), you can see that this thread is doing string concatenation. (Notice the call to `System.String.Concat` on the call stack.) If you analyze the other top CPU threads, you see the same pattern.

The next step is to review the `Page_Load` event in the _default.aspx_ page of the FastApp application. There, you find the following code:

```html
htmlTable += "<table>";
for (int x = 0; x < 5000; x++)
{
htmlTable += "<tr>" + "<td>" + "Cell A" + x.ToString() + "</td>";
    htmlTable += "<td>" + "Cell B" + x.ToString() + "</td>" + "</tr>";
}
htmlTable += "</table>";
```

This kind of code definitely causes high CPU.

## Conclusion

By using Perfmon and DebugDiag, you can easily collect helpful data to determine the cause of high CPU in application pools. If you can't find the root cause by using these techniques, contact Microsoft Support for more assistance. By having the Perfmon data and dump files ready when you open a case, you can dramatically reduce the time that's required for Microsoft support engineers to assist you.

### Other resources

- [Troubleshooting High CPU Utilization](/previous-versions/windows/it-pro/windows-2000-server/bb742546(v=technet.10))
- [What to Gather to Troubleshoot High CPU or Hang](https://blogs.iis.net/tomchris/asp-net-tips-what-to-gather-to-troubleshoot-part-1-high-cpu)
- [.NET Debugging Demos](https://www.tessferrandez.com/blog/2008/02/04/debugging-demos-setup-instructions.html)
