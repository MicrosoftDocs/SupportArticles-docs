---
title: Troubleshoot processes and threads by using WPR and WPA
description: Discusses Windows Performance Recorder (WPR) and Windows Performance Analyzer (WPA) and how to apply them when you troubleshoot.
ms.date: 01/15/2025
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-tappelgate
ms.custom:
- sap:system performance\performance tools (task manager,perfmon,wsrm,and wpa)
- pcy:WinComm Performance
keywords: WPR, WPAm XPerf, XPerfview
---

# Troubleshoot processes and threads by using WPR and WPA

This article discusses the features of Windows Performance Recorder (WPR) and Windows Performance Analyzer (WPA) and provides examples of how to apply those features when you troubleshoot.

_Applies to:_ &nbsp;  All supported versions of Windows Server and Windows Client

## Summary

WPR and WPA are performance monitoring tools that produce in-depth performance profiles of Windows operating systems and applications. Windows includes a command-line version of WPR. To get WPA and a GUI version of WPR (that's shown in the examples in this article), download and install the [Windows Assessment and Deployment Kit (WADK)](/windows-hardware/get-started/adk-install).

> [!NOTE]  
> The previous command-line tool, Xperf, is still supported for collecting data and is included in the WADK. However, Xperfview is no longer supported. Use WPA to view Xperf recordings.
>
> For information about how to use Xperf, see [Xperf Command-Line Reference](/windows-hardware/test/wpt/xperf-command-line-reference).

## Prerequisites

To run the WPT tools, your system must meet the following requirements:

- WPR: Windows 8 or later.
- WPA: Windows 8 or later with the Microsoft .NET Framework 4.5 or later.

## Using WPR to record data

WPR is a powerful recording tool that creates Event Tracing for Windows (ETW) recordings of system and application behavior and resource usage. WPR provides built-in profiles that you can use to select the events that are to be recorded. Alternatively, you can author custom profiles in XML. For more information, see the following documentation.

| Topic | Link |
| --- | --- |
| Quick start of basic procedures | [WPR How-to Topics](/windows-hardware/test/wpt/wpr-how-to-topics) |
| Descriptions of the built-in recording profiles | [Built-in Recording Profiles](/windows-hardware/test/wpt/built-in-recording-profiles) |
| Complete documentation of the WPR user interface | [WPR Features](/windows-hardware/test/wpt/wpr-features) |
| Reference of command-line options | [WPR Command-Line Options](/windows-hardware/test/wpt/wpr-command-line-options) |
| Discussion of key scenarios | [WPR Scenarios](/windows-hardware/test/wpt/windows-performance-recorder-common-scenarios)<br/>[Performance&nbsp;Scenarios](/windows-hardware/test/wpt/performance-scenarios) |
| Descriptions of the logging modes (Memory mode or File mode) | [Logging Mode](/windows-hardware/test/wpt/logging-mode)<br/>[Change the Logging Mode](/windows-hardware/test/wpt/wpr-how-to-topics#change-the-logging-mode) |
| Complete reference material, including a recording profile XML reference and a legacy Xperf reference | [WPR Technical Reference](/windows-hardware/test/wpt/wpr-reference) |

You can run WPR from the user interface (WPRUI.exe) or the command line (WPR.exe). The WPR UI makes it simple to generate a recording by using built-in recording profiles to analyze CPU usage, power issues, poor system or application performance, and other performance issues. WPRUI.exe is available in the WADK. WPR.exe ships together with the Windows operating system (Windows 8.1 or a later version) and doesn't require additional installation.

To start a recording, follow these steps:

1. Select **Start**, enter *Windows Performance Recorder*, and then select **Windows Performance Recorder** in the search results.
1. Do one of the following:  

   - To record while using the default (**First-level triage**) profile, select **Start**.  

     :::image type="content" source="media/support-tools-xperf-wpa-wpr/wpr-record-simplified.png" alt-text="Screenshot that shows the condensed view of W.P.R.":::  

   - To select a different profile or set other options, select **More options**. Select the options that you want, and then select **Start**.

     :::image type="content" source="media/support-tools-xperf-wpa-wpr/wpr-record.png" alt-text="Screenshot that shows the expanded view of W.P.R.":::  

To stop a recording, follow these steps:

1. In WPR, select **Save**.
1. Browse to the location to which you want to save the recording file.
1. Enter a description of the problem for which you created the recording.
1. Select **Save**, and then select **Open in WPA** or **OK**.

## Using WPA to analyze data

WPA is a powerful analysis tool that combines a flexible UI with extensive graphing capabilities and data tables that can be pivoted and that have full text search capabilities. WPA provides an **Issues** window to explore the root cause of any identified issue. For more information, see the following documentation.

| Topic | Link |
| --- | --- |
| Basic procedures and a detailed walkthrough | [WPA Quick Start Guide](/windows-hardware/test/wpt/wpa-quick-start-guide) |
| Complete documentation of the WPA UI | [WPA Features](/windows-hardware/test/wpt/wpa-features) |
| Extended discussion of key scenarios | [WPA Scenarios](/windows-hardware/test/wpt/windows-performance-analyzer-common-scenarios) |

To open WPA, select **Start**, enter *Windows Performance Analyzer*, and then select **Windows Performance Analyzer** in the search results.

If you didn't open WPA directly from WPR after you saved a recording, you can use the WPA **File** menu to open a trace file.  

:::image type="content" source="media/support-tools-xperf-wpa-wpr/wpa-analysis-cpu.png" alt-text="Screenshot that shows W.P.A., showing tables and graphs in the Analysis tab." lightbox="media/support-tools-xperf-wpa-wpr/wpa-analysis-cpu.png":::  

> [!NOTE]  
> To load symbols for analysis, select **Trace**, and then select **Load Symbols**. For more information, see [Load Symbols or Configure Symbol Paths](/windows-hardware/test/wpt/load-symbols-or-configure-symbol-paths).

The WPA user interface (UI) includes docked windows that surround a central workspace. This workspace contains **Analysis** tabs. All windows can be docked in different locations. To open a closed window, select the window on the **Window** menu. WPA uses the following windows and tabs.

| Window or tab | Description |
| --- | --- |
| Graph Explorer | Contains thumbnails of all the graphs that apply to the current recording. The graphs are grouped into categories. To expand a category, select the triangle in the upper left corner of the thumbnail. For more information, see [Graph Explorer](/windows-hardware/test/wpt/graph-explorer). |
| Analysis | Displays detailed information and legends for trace recordings. You can drag graphs from the Graph Explorer to the **Analysis** tab. The tab displays the information in graph and pivot table format. In the tables, the vertical gold bar separates keys from data. The vertical blue bar separates pivot table data from graphing elements. For more information, see [Analysis Tab](/windows-hardware/test/wpt/analysis-tab). |
| Analysis Assistant | Displays information about the currently selected graph and table. For more information, see [Analysis Assistant](/windows-hardware/test/wpt/analysis-assistant). |
| Issues | Available for Assessment Platform recordings, and lists issues  that the assessment identifies. For more information, see [Issues Window](/windows-hardware/test/wpt/issues-window). |
| Details | Available for Assessment Platform recordings, and lists details and recommended solutions for the selected issue. For more information, see [Details Window](/windows-hardware/test/wpt/details-window). |
| Diagnostic Console | Provides a list of exceptions in the recording and details related to symbol loading and decoding. For more information, see [Diagnostic Console Window](/windows-hardware/test/wpt/diagnostic-console). |

## Examples

The following table describes several problem scenarios, the WPR profiles that you can use for recording data, and suggested graphs and pivot table fields to analyze the data.

| Scenario | WPR profile | Graph and parameters to analyze |
| --- | --- | --- |
| High CPU usage | Default profile (First Level Triage) and/or CPU Usage | Computation > CPU Usage (Sampled)<br />Key options:<ul><li>**Process** > **Stack** (list activities by process, then by all threads in that process)</li><li>**Process** > **Thread ID** > **Stack** (list activities by process on each thread individually)</li><li>**Process Name** > **Stack** (list activities by all threads in all processes associated with a given name</li></ul>Data: **Count (Sort by)** |
| Virtual allocation leak | VirtualAlloc usage | Memory > VirtualAlloc Commit LifeTimes<br/>Keys: **Type**, **Process**, **Stack**<br/>Data: **Count (Sort by)**, **Impacting Size (MB)** |
| Pool leak | Pool usage | Memory > Pool<br/>Keys: **Type**, **Paged**, **Pool Tag**, **Stack**<br/>Data: **Count (Sum)**, **Impacting Size (MB)** |
| Handle leak | Handle usage | Memory > Handles<br/>Keys: **Creating Process**, **Handle Type**, **Create Stack**<br/>Data: **Object Name**, **Object**, **Handle**<br/>Graph element (right of blue bar): **Count** |
| Heap leak | Heap usage<br/>Tracing flags\* | Memory > Heap Allocations<br/>Keys: **Type**, **Process**, **Stack**<br/>Data: **Count**, **Impacting Size (B) Sum** |
| Wait analysis | Default profile (First Level Triage) or CPU Usage | Computation > CPU Usage (Precise)<br />Keys: **New Process**, **New Thread**, **New Stack**, **Readying Process**, **Readying Thread**, **Readying Stack**<br/>Data: **Wait(Max)**, **Wait(Sum)**, **Count(Waits)** |

\* To set the Tracing flags, open an administrative Command Prompt window, and then run the following commands:

```console
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\<Process_Name>" /v TracingFlags /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\VirtMemTest64.exe" /v TracingFlags /t REG_DWORD /d 1 /f
```

> [!NOTE]  
> In the first command, \<*Process_Name*> represents the name of the service or process that you want to analyze.

After the commands run, restart the service or process.
