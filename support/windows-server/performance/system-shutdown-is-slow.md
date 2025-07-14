---
title: System shutdown is slow
description: Provides guidance to troubleshoot performance problems that occur when Windows shuts down.
ms.date: 01/15/2025
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-tappelgate
ms.custom:
- sap:system performance\shutdown performance (slow,unresponsive)
- pcy:WinComm Performance
keywords: 
---

# Troubleshooting a slow system shutdown

This article provides guidance to troubleshoot performance problems that occur when Windows shuts down.

_Applies to:_ &nbsp; All supported versions of Windows Server and Windows Client

## Summary

Multiple factors can cause Windows to shut down more slowly than usual. You can use Windows Performance Recorder (WPR) and Windows Performance Analyzer (WPA) to collect and analyze diagnostic data.

## Before you begin

The command-line version of WPR is part of Windows, but you have to install WPA and the graphical user interface of WPR (WPRUI) separately. Both tools are part of the Windows Assessment and Deployment Toolkit (Windows ADK). The procedures in this article use WPRUI. You have to install WPRUI on the computer that you're troubleshooting. You don't have to install WPA on the same computer. For information about how to download and install the tools, see [Download and install the Windows ADK](/windows-hardware/get-started/adk-install).

For an overview of the tools and how to use them, see [Troubleshoot processes and threads by using WPR and WPA](../support-tools/support-tools-xperf-wpa-wpr.md).

## Gather data

To record data during a system shutdown, follow these steps:

1. On the affected computer, select **Start**, enter *Windows Performance Recorder*, and then select **Windows Performance Recorder** in the search results.

1. Select **More options**, if it's necessary.

1. On the **Record system information** page, locate the profiles list, and then select the profiles that you want to use.

1. Select the following settings:

   | Setting | Value |
   | --- | --- |
   | **Performance scenario** | Shutdown |
   | **Detail level** | Verbose |
   | **Logging mode** | File |
   | **Number of iterations** | 1 |

   :::image type="content" source="media/troubleshooting-system-shutdown-is-slow-scenario/wprui-settings-record-shutdown-perf.png" alt-text="Screenshot that shows the Record system information page of W.P.R., showing the appropriate options selected for recording a shutdown scenario.":::  

1. Select **Start**.

1. In **Results Path**, enter the filename and path for the recorded data file.

   :::image type="content" source="media/troubleshooting-system-shutdown-is-slow-scenario/wprui-saveas-shutdown-perf.png" alt-text="Screenshot that shows the Save as page of W.P.R.":::  

1. Enter a description of the data file, and then select **Save**.

1. When you're prompted to start the shutdown, select **OK**, and then select **Close**.

   > [!NOTE]  
   > Windows shuts down, and then restarts. After you sign in again, WPR starts compiling and saving the recorded data.

1. Do one of the following:

   - If you installed WPA on the same computer, select **Open in WPA**. This action starts WPA and loads the recorded file.
   - If you installed WPA on a different computer, transfer the saved trace file to the computer on which you installed WPA.

## Analyze data

If you didn't open WPA directly from WPR after you saved a recording, follow these steps:

1. Select **Search**, enter *Windows Performance Analyzer*, and then select **Windows Performance Analyzer** in the search results.
1. Use the WPA **File** menu to open the trace file that you recorded previously.  

> [!NOTE]  
> To load symbols for analysis, select **Trace**, and then select **Load Symbols**. For more information, see [Load Symbols or Configure Symbol Paths](/windows-hardware/test/wpt/load-symbols-or-configure-symbol-paths).

WPA loads thumbnails of the various categories of recorded data in the Graph Explorer. To analyze the data, expand a category, and then drag a thumbnail to the **Analysis** tab. For more information about how to use WPA, see [Troubleshoot processes and threads by using WPR and WPA: Using WPA to analyze data](../support-tools/support-tools-xperf-wpa-wpr.md#using-wpa-to-analyze-data).

For more information about system shutdown processes and options, see [System Shutdown](/windows/win32/shutdown/system-shutdown).
