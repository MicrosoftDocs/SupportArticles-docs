---
title: Microsoft Azure PaaS VM logs
description: Gather Azure PaaS VM logs quickly by collecting event logs, IIS logs, and diagnostics data. Discover which files to capture and how to troubleshoot common issues.
ms.date: 08/14/2020
ms.service: azure-virtual-machines
ms.author: kaushika
author: kaushika-msft
ms.custom: sap:VM Admin - Windows (Guest OS)
---
# [SDP3][52ef8720-e3ee-4a12-a37e-cc3b0870f359] Microsoft Azure PaaS VM logs

**Applies to:** :heavy_check_mark: Windows VMs

_Original KB number:_ &nbsp; 2772488

## Summary

This article describes how to gather the most common log files and diagnostics information from an Azure PaaS VM to troubleshoot most issues related to Microsoft Azure.

## More information

Internet Explorer prompts you to add a trusted website.

- Select **Add** and add `https://*.support.microsoft.com`.
    > [!NOTE]
    > You must put a `*.` in front of `support.microsoft.com`.
- Or, save the following as a .reg file and import it:

    ```
    Windows Registry Editor Version 5.00
    [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\EscDomains\microsoft.com\*.support]
    ```

If you receive an Internet Explorer Security Alert saying `Your current security settings do not allow this file to be downloaded.`, you didn't add `https://*.support.microsoft.com` to the list of trusted sites.

### Information collected

#### General information

| Description| File name |
|---|---|
|Basic system information, including machine name, service pack, computer model, and processor name and speed.<br/>|resultreport.xml<br/>|
  
#### Log files in System32 and Azure logs

| Description| File name |
|---|---|
|Log files from %windir%\System32\LogFiles\*.*<br/>|{ComputerName}_LogFiles(SubfolderName).zip<br/>|
|Guest agent collected performance counters, contents of D:\OSdiagnostics<br/>|{ComputerName}_OSdiagnostics.Zip<br/>|
|Role configuration files from c:\config<br/>|{ComputerName}_config.Zip<br/>|
|Role host log files from C:\Resources\temp\{GUID}.{roleName}\RoleTemp<br/>|{ComputerName}_RoleTemp.Zip<br/>|
|IIS failed request log files from C:\Resources\Directory\{guid}.DiagnosticStore\FailedReqLogFiles<br/>|{ComputerName}_FailedReqLogFiles.Zip<br/>|
|IIS log files from c:\Resources\directory\{guid}.Diagnosticstore\LogFiles<br/>|{ComputerName}_IISLogFiles.Zip<br/>|
|Microsoft Azure Diagnostics tables and configuration from C:\Resources\directory\{guid}.Diagnosticstore\Monitor<br/>|{ComputerName}_Monitor.Zip<br/>|
|Host bootstrapper log files from C:\Resources\directory\{guid}.Diagnosticstore<br/>|{ComputerName}_DiagnosticStore.Zip<br/>|
|Microsoft Azure Caching log files from C:\Resources\temp\{guid}.{rolename}\RoleTemp<br/>|{ComputerName}_CachingLogFiles.zip<br/>|
|Service model definition files from E:\__entrypoint.txt, E:\*.cssx.tag, E:\*.csman, E:\RoleModel.xml<br/>|{ComputerName}_ServiceModel.zip<br/>|
|IIS web.config from {RoleRoot}\approot\web.config<br/>|{ComputerName}_web.config<br/>|
|Startup task files from {RoleRoot}\{startup tasks=""}(get the filename from {RoleRoot}\rolemodel.xml)<br/>|{ComputerName}_StartupTaskModules.Zip<br/>|
|Role entry point binary from {RoleRoot}\{entrypoint DLL=""} (the file name obtained from {RoleRoot}\__entrypoint.txt content)<br/>|{ComputerName}_EntryPointDLL.Zip<br/>|
|Log files from C:\Logs<br/>|{ComputerName}_Logs.Zip<br/>|
  
#### Event logs

| Description| File name |
|---|---|
|System log<br/>|{ComputerName}_evt_System.*<br/>|
|Application log<br/>|{ComputerName}_evt_Application.*<br/>|
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


 
