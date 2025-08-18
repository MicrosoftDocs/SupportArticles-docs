---
title: Collect Performance Trace in New Outlook for Windows
description: Provides guidance to collect performance and network traces in new Outlook for Windows.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Errors, Crashes, and Performance
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: caithart
appliesto: 
  - New Outlook for Windows
search.appverid: MET150
ms.date: 08/18/2025
---
# Collect a performance trace in new Outlook for Windows

If you contact Microsoft Support to troubleshoot issues that affect new Outlook for Windows, you might be asked to collect a performance trace, a network trace or both. To collect these traces, use the Outlook icon in your system tray, and save the files to your local computer.

The Outlook icon provides the following options to collect a trace.

| Options | Description |
|--|--|
| Start Performance Trace | Start monitoring performance indicators, and continue until stopped manually.<br><br>After the trace collection starts, this option changes to **Stop Performance Tracing**. |
| Record Perf Trace for 1 min | Monitor performance indicators for one minute, and then stop automatically.<br><br>This option might be useful to troubleshoot an unresponsive application to make sure that the trace is saved automatically. |
| Start Network Trace | Start capturing network logs, and continue until stopped manually.<br><br>After the trace collection starts, this option changes to **Stop Network Tracing**. |

To collect and access a trace, follow these steps:

1. To start a trace, right-click the Outlook icon in the system tray, and then select the appropriate option.

2. After you reproduce the issue, right-click the Outlook icon again, and then select the appropriate option to stop the trace.

3. To access the trace files, open File Explorer, and then navigate to **%localappdata%\Microsoft\Olk\Feedback\Traces**.

   The file name of a trace uses the following format: **WebviewTrace_\<TraceType_n_yyyymmdd_hhmmSSss>.json**

   For example: **WebviewTrace_Performance_1_20250324_215740833.json**

If you're on the phone with Microsoft Support, and you're asked to share the trace files, navigate to **Help** > **Get Diagnostics**, and then select the **Send diagnostics** button. Provide the displayed Support ID so that the Support agent can access the trace information that you collected.
