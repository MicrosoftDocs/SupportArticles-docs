---
title: Microsoft Dynamics CRM Client Performance diagnostic tool
description: This article describes the data that is collected by the Microsoft Dynamics CRM Client Performance diagnostic tool.
ms.reviewer: aaronric
ms.topic: article
ms.date: 3/31/2021
---
# [SDP 3][f4af120f-5d6c-46ec-b616-694b6600675c]The Microsoft Dynamics CRM Client Performance diagnostic tool

The Microsoft Dynamics CRM Client Performance diagnostic tool collects information that is related to Internet Explorer and network configuration for a computer that is experiencing performance issues. This article describes the data that is collected by the Microsoft Dynamics CRM Client Performance diagnostic tool.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2684582

## Information that is collected

The following data can be collected by the Dynamics CRM Client Performance diagnostic tool. (This tool is part of the Microsoft Support Diagnostic Tool.)

> [!NOTE]
>
> - All file names in the data collection are prefaced with the name of the computer on which the Microsoft Support Diagnostic Tool is run.
> - The diagnostic tool uses the Fiddler tool to collect network latency and Internet Explorer information. For more information about the Fiddler tool, see [Download Fiddler Classic/](https://www.telerik.com/download/fiddler).
> - The diagnostic tool uses the AutoRuns tool to collect information that is related to Internet Explorer add-zns. For more information about the AutoRuns tool, see [Autoruns for Windows v13.98](/sysinternals/downloads/autoruns).

### Operating system information

|Description|File name|
|---|---|
|Operating system version information|<*ComputerName*>_<*DateRun*>.htm|

### Internet Explorer version information

|Description|File name|
|---|---|
|Lists the version of Internet Explorer that is currently installed on the computer.|<*ComputerName*>_<*DateRun*>.htm|

### Internet Explorer option settings

|Description|File name|
|---|---|
|Lists various settings from the HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings registry hive such as temporary Internet files cache size and Stored Pages option settings.|<*ComputerName*>_<*DateRun*>.htm|

### Internet Explorer trusted site and proxy settings

|Description|File name|
|---|---|
|Lists registry keys and values that are stored under the HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zonemap\Domains registry hive. Additionally, this file lists the registry keys and values under the HKCU:\Software\Microsoft\CurrentVersion\Internet Settings hive.|<*ComputerName*>_<*DateRun*>.htm|

### Internet Explorer zone security information

|Description|File name|
|---|---|
|Lists the values from the HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones registry hive.|<*ComputerName*>_<*DateRun*>.htm|

### Network adapter binding information

|Description|File name|
|---|---|
|Provides information about the binding order of the installed network adapters on the computer.|<*ComputerName*>_<*DateRun*>.htm|

### TCP/IP configuration

|Description|File name|
|---|---|
|Lists TCP/IP registry keys and their values.|<*ComputerName*>_<*DateRun*>.htm|

### MaxConnectionsPerServer settings

|Description|File name|
|---|---|
|Lists the values of the registry keys that relate to the MaxConnectionsPerServer settings.|<*ComputerName*>_<*DateRun*>.htm|

### Port counts per IP address information

|Description|File name|
|---|---|
|Provides information that is related to possible ephemeral port exhaustion.|<*ComputerName*>_<*DateRun*>.htm|

### Microsoft Dynamics CRM diagnostics information

|Description|File name|
|---|---|
|Lists the information that is collected from the Microsoft Dynamics CRM 2011 \Tools\Diag.aspx page. This page details network latency information between the computer that is running the diagnostic and the Microsoft Dynamics CRM server.|<*ComputerName*>_<*DateRun*>.htm|

### Additional information

The following files are collected as part of the Dynamics CRM Client Performance diagnostic tool.

|Description|File name|
|---|---|
|A text file that contains the output from the Fiddler tool|Fiddler.saz|
|Text files in both XML and CSV format from the AutoRuns tool that detail the add-ins that are installed in Internet Explorer and the Windows Shell.|<*ComputerName*>_AutoRuns_IE_Addons.xml</br><*ComputerName*>_AutoRuns_Shell_Addons.xml</br><*ComputerName*>_AutoRuns_IE_Addons.csv|
