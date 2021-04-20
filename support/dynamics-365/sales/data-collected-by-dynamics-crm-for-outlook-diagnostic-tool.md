---
title: Microsoft Dynamics CRM client for Outlook diagnostic tool
description: Describes the data that is collected by the Memory Dump diagnostic tool in Microsoft Dynamics CRM Client for Outlook.
ms.reviewer: 
ms.topic: article
ms.date: 3/31/2021
---
# [SDP 3][61593d1b-21b0-43e3-9088-74e77dec12f4] Microsoft Dynamics CRM client for Outlook diagnostic tool

The Microsoft Dynamics CRM client for Microsoft Office Outlook diagnostic tool collects crash or dump files for the CRMAppPool account that is configured on the Microsoft Dynamics CRM Internet Information Services (IIS) computer. This article describes the data that is collected by the Memory Dump diagnostic tool.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2620926

The diagnostic tool that described in this article can be used on the following versions of Windows:

- Windows 7
- Windows 2008 R2

## Information that is collected

The following data can be collected by the Memory Dump diagnostic tool of the Microsoft Support Diagnostic Tool.

> [!NOTE]
>
> - All file names in the data collection are prefaced with the *ComputerName* on which the Microsoft Support Diagnostic Tool is run.
> - The diagnostic tool uses the ProcDump tool to generate one or more .dmp files when the selected application either stops responding or ends unexpectedly. For more information about the ProcDump tool, see [ProcDump v10.0](/sysinternals/downloads/procdump).

### Operating system information

| Description| File name |
|---|---|
|Operating system version information| *ComputerName*_*DateRan**.htm|

### Installed applications

| Description| File name |
|---|---|
|Lists the applications that are installed on the Microsoft Dynamics CRM Client for Outlook computer| *ComputerName*_*DateRan*.htm|

### Internet Explorer and Microsoft Office version information

| Description| File name |
|---|---|
|Lists the versions of Internet Explorer and Office| *ComputerName*_*DateRan*.htm|

### Microsoft Outlook add-in information

| Description| File name |
|---|---|
|Lists the add-ins that are installed for use with Microsoft Outlook| *ComputerName*_*DateRan*.htm|

### Internet Explorer trusted sites and proxy settings

| Description| File name |
|---|---|
|The file lists registry keys and values that are stored under the HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains registry hive. Additionally, this file also lists the registry keys and values under the HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings hive. | *ComputerName*_*DateRan*.htm|

### Microsoft Dynamics CRM registry key values

| Description| File name |
|---|---|
|Lists registry keys and values that are stored that are under HKEY_LocalMachine\Software\Microsoft\MSCRMClient registry hive. | *ComputerName*_*DateRan*.htm|

### Microsoft Dynamics CRM registry user values

| Description| File name |
|---|---|
|Lists registry keys and values that are stored under HKEY_CurrentUser\Software\Microsoft\MSCRMClient registry hive.| *ComputerName*_*DateRan*.htm|

### Installed Microsoft Dynamics CRM hotfixes

| Description| File name |
|---|---|
|Lists all applied Microsoft Dynamics CRM hotfixes. | *ComputerName*_*DateRan*.htm|

### Microsoft Dynamics CRM files

| Description| File name |
|---|---|
|Lists all files from the InstallPath registry key value, including dates and file versions. | *ComputerName*_*DateRan*.htm|

### Microsoft Dynamics CRM files that are installed in the assembly cache

| Description| File name |
|---|---|
|Lists all Microsoft Dynamics CRM files that are installed in the global assembly cache on the CRM server. | *ComputerName*_*DateRan*.htm|

### TCP/IP configuration

| Description| File name |
|---|---|
|Lists TCP/IP registry keys and their values. | *ComputerName*_*DateRan*.htm|

### Application logs

| Description| File name |
|---|---|
|Event log - Application - all Microsoft Dynamics CRM events in the last seven days Event log - Application - all ASP.NET events in the last seven days | *ComputerName*_*DateRan*.htm|

### Installed .NET Framework information

| Description| File name |
|---|---|
|Lists all .NET Framework versions that are installed on the client computer.| *ComputerName*_*DateRan*.htm|

### Group Policy information

| Description| File name |
|---|---|
|Lists information about the applied Group Policy settings by using the gpresult utility. | *ComputerName*_*DateRan*.htm|

### Mail profile information

| Description| File name |
|---|---|
|Lists the keys and values under the HKCU: Software\Microsoft\Windows NT\CurrentVersion\Windows Messaging Subsystem\Profiles registry hive. | *ComputerName*_*DateRan*.htm|

> [!NOTE]
> The setup and client configuration log files from the %APPDATA%\Microsoft\MSCRM\Logs file directory are also collected by this diagnostic tool.

### Unresponsive application data dump

The following files are generated and collected if you select the **The application has become unresponsive** option when you are prompted by the diagnostic tool.

For this scenario, as many as three .dmp files are generated, 10 seconds apart, to capture memory details while the selected application is in an unresponsive state. Because these files are typically very large, the diagnostic tool may take several minutes to finish.

| Description| File name |
|---|---|
|A text file lists the .zip files generated by the diagnostic. The .zip file names and parent folder location are provided.| *ComputerName*_DumpFile_Information.txt|
|A .zip file that contains a compressed .dmp file.| *ComputerName*_w3wp.zip|
|A text file contains output information from the ProcDump tool. For example, the location and name of the uncompressed .dmp file are listed in the file.| *ComputerName*_w3wp.out|

### Crash dump data

The following files are generated and collected when you select the **The application is crashing or terminating unexpectedly** option when you are prompted by the diagnostic tool. For crash scenarios, the diagnostic tool waits for any second chance exceptions to occur and then creates a .dmp file for that process.

| Description| File name |
|---|---|
|A text file contains the name of the .zip file that is generated by the diagnostic tool. The .zip file name and parent folder location are provided.| *ComputerName*_DumpFile_Information.txt|
|A .zip file contains a compressed .dmp file.| *ComputerName*_w3wp.zip|
|A text file contains output information from the ProcDump tool. For example, the location and name of the uncompressed .dmp file are listed in the file.| *ComputerName*_w3wp.out|
