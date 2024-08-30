---
title: Microsoft Azure PaaS VM logs
description: Describes how to gather the most common log files and diagnostics information from an Azure PaaS VM.
ms.date: 08/14/2020
ms.service: azure-virtual-machines
ms.author: genli
author: genlin
ms.reviewer: 
ms.custom: sap:VM Admin - Windows (Guest OS)
---
# [SDP3][52ef8720-e3ee-4a12-a37e-cc3b0870f359] Microsoft Azure PaaS VM logs

**Applies to:** :heavy_check_mark: Windows VMs

_Original KB number:_ &nbsp; 2772488

## Summary

This article describes how to gather the most common log files and diagnostics information from an Azure PaaS VM to troubleshoot most of issues related to Microsoft Azure.

## More information

You will be prompted by IE to Add a trusted website.

- Select Add and add `https://*.support.microsoft.com`.
    > [!NOTE]
    > You must put a `*.` in front of `support.microsoft.com`.
- Or, save the following as a .reg file and import it:

    ```
    Windows Registry Editor Version 5.00
    [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\EscDomains\microsoft.com\*.support]
    ```

If you receive an IE Security Alert saying `Your current security settings do not allow this file to be downloaded.`, then you did not add `https://*.support.microsoft.com` to the list of trusted sites.

### Information collected

#### General information

| Description| File name |
|---|---|
|Basic System Information including machine name, service pack, computer model and processor name and speed<br/>|resultreport.xml<br/>|
  
#### LogFiles in System32 and Azure logs

| Description| File name |
|---|---|
|Log files from %windir%\System32\LogFiles\*.*<br/>|{ComputerName}_LogFiles(SubfolderName).zip<br/>|
|Guest Agent Collected Perf Counters, Contents of D:\OSdiagnostics<br/>|{ComputerName}_OSdiagnostics.Zip<br/>|
|Role Configuration Files from c:\config<br/>|{ComputerName}_config.Zip<br/>|
|Role Host Log Files from C:\Resources\temp\{GUID}.{roleName}\RoleTemp<br/>|{ComputerName}_RoleTemp.Zip<br/>|
|IIS Failed Request Log Files from C:\Resources\Directory\{guid}.DiagnosticStore\FailedReqLogFiles<br/>|{ComputerName}_FailedReqLogFiles.Zip<br/>|
|IIS Log Files from c:\Resources\directory\{guid}.Diagnosticstore\LogFiles<br/>|{ComputerName}_IISLogFiles.Zip<br/>|
|Microsoft Azure Diagnostics Tables and Configuration from C:\Resources\directory\{guid}.Diagnosticstore\Monitor<br/>|{ComputerName}_Monitor.Zip<br/>|
|Host Bootstrapper Log Files from C:\Resources\directory\{guid}.Diagnosticstore<br/>|{ComputerName}_DiagnosticStore.Zip<br/>|
|Microsoft Azure Caching Log Files from C:\Resources\temp\{guid}.{rolename}\RoleTemp<br/>|{ComputerName}_CachingLogFiles.zip<br/>|
|Service Model Definition Files from E:\__entrypoint.txt, E:\*.cssx.tag, E:\*.csman, E:\RoleModel.xml<br/>|{ComputerName}_ServiceModel.zip<br/>|
|IIS web.config from {RoleRoot}\approot\web.config<br/>|{ComputerName}_web.config<br/>|
|Startup Task Files from {RoleRoot}\{startup tasks=""}(get the filename from {RoleRoot}\rolemodel.xml)<br/>|{ComputerName}_StartupTaskModules.Zip<br/>|
|Role Entry Point Binary from {RoleRoot}\{entrypoint DLL=""} (the file name obtained from {RoleRoot}\__entrypoint.txt content)<br/>|{ComputerName}_EntryPointDLL.Zip<br/>|
|Log files from C:\Logs<br/>|{ComputerName}_Logs.Zip<br/>|
  
#### Event logs

| Description| File name |
|---|---|
|System Log<br/>|{ComputerName}_evt_System.*<br/>|
|Application Log<br/>|{ComputerName}_evt_Application.*<br/>|
|Microsoft Azure<br/>|{ComputerName}_evt_WindowsAzure.*<br/>|
|All other event logs in evtx format<br/>|{ComputerName}_*evt_*.evtx<br/>|
  
#### File version information (Chksym)

| Description| File name |
|---|---|
|File version information from processes currently running on the machine<br/>|{ComputerName}_sym_Process.*<br/>|
|File version information from processes currently running on the machine<br/>|{ComputerName}_sym_Process.*<br/>|
  
In addition to collecting the information that is described earlier, this diagnostic package can detect one or more of the following symptoms:

- Check if IntelliTrace enabled causes roles to not automatically recycle
- Check if WebDeploy is enabled in production environments
- Check if OverallQuotaInMB value is within 500 of DiagnosticStore value
- Event Logs Messages

### References

For more information about the Microsoft Automated Troubleshooting Services and about the Support Diagnostics Platform, please open the following Microsoft Knowledge Base article:

[2598970](https://support.microsoft.com/help/2598970) Information about Microsoft Automated Troubleshooting Services and Support Diagnostic Platform

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
