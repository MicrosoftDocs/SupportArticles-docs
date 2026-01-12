---
title: IIS and ASP.NET diagnostics
description: This article describes the basic information diagnostic of IIS/ASP.NET.
ms.date: 04/07/2020
ms.custom: sap:Performance
---
# IIS and ASP.NET basic information diagnostic

This article describes information that's collected by Microsoft Internet Information Services (IIS)/ASP.NET Basic Information Data Collector.

_Original product version:_ &nbsp; ASP.NET 3.5, Windows Server 2012  
_Original KB number:_ &nbsp; 2606942

## Summary

The IIS/ASP.NET Information Collector for Windows collects information that is used to troubleshoot IIS and ASP.NET common issues.

## Operating system information

The following operating system information is collected:

- Machine Name
- OS Name
- Last Reboot/Uptime
- AntiMalware
- User Account Control
- Username

## Computer system information

The following computer system is collected:

- Computer Model
- Processor(s)
- Machine Domain
- Role

## Event log files

|Description|File Name|
|---|---|
|Application Event Log|{Computername}_evt_Application.evtx|
|System Event Log|{Computername}_evt_System.evtx|
|Security Event Log|{Computername}_evt_Security.evtx|
|IIS Configuration Administrative Event Log|{Computername}_evt_IISConfiguration-Administrative.evtx|
|IIS Configuration Operational Event Log|{Computername}_evt_IISConfiguration-Administrative.evtx|
  
## IIS configuration

|Description|File Name|
|---|---|
|IIS/ASP.NET Configuration Files|{Computername}_IISConfiguration.zip|
|IIS Machine Key Information|IISMachineKeyInfo.txt|
|Kerberos Configuration Information|IISKerberosReport.htm|
  
## IIS log files

|Description|File Name|
|---|---|
|Http Error Logs|{Computername}_HttpErrorLogs.zip|
|IIS Log Files|{Computername}_IISLogs.zip|
  
## IIS Services registry settings

|Description|File Name|
|---|---|
|HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\HTTP|{Computername}_REG_SERVICES_HTTP.TXT|
|HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\ASP|{Computername}_REG_SERVICES_ASP.TXT|
|HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\INETINFO|{Computername}_REG_SERVICES_INETINFO.TXT|
|HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\IISADMIN|{Computername}_REG_SERVICES_IISADMIN.txt|
|HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\W3SVC|{Computername}_REG_SERVICES_W3SVC.TXT|
|HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\WAS|{Computername}_REG_SERVICES_WAS.TXT|
|HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\LanManWorkstation|{Computername}_REG_SERVICES_LANMANWORKSTATION.TXT|
|HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\LanManServer|{Computername}_REG_SERVICES_LANMANSERVER.TXT|
|HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ASP.NET|{Computername}_REG_SOFTWARE_ASPNET.TXT|
|HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\ASP.NET|{Computername}_REG_SOFTWARE_WOW6432NODE_ASPNET.TXT|
  
## IIS/ASP.NET file information

|Description|File Name|
|---|---|
|IIS File Information|IISFileInfo.txt|
|.NET Framework 32-bit File Information|NetFrameworkFileInfo.txt|
|.NET Framework 64-bit File Information|NetFramework64FileInfo.txt|
|Web Site File Information|{Web Site Name}_SiteFileInfo.txt|
  
## Installation setup logs for IIS

|Description|File Name|
|---|---|
|IIS Setup Log|{Computername}_IIS7.log|
|CBS Setup Log|{Computername}_CBS.log|
  
## Installed updates/hotfixes

|Description|File Name|
|---|---|
|Update/Hotfix history:|{Computername}_Hotfixes.CSV|
|Update/Hotfix history:|{Computername}_Hotfixes.htm|
|Update/Hotfix history:|{Computername}_Hotfixes.TXT|
  
## Networking information

|Description|File Name|
|---|---|
|TCP/IP Basic Information|{Computername}_TcpIp-Info.txt|
|SMB Basic Information|{Computername}_SMB-Info.txt|
  
## System information

|Description|File Name|
|---|---|
|MSINFO32.exe Information in Text Format|{Computername}_msinfo32.txt|
|MSINFO32.exe Information in NFO Format|{Computername}_msinfo32.nfo|
  
## Virtualization information

|Description|File Name|
|---|---|
|Machine Virtualization Information in HTM format|{Computername}_Virtualization.htm|
|Machine Virtualization Information in TXT format|{Computername}_Virtualization.txt|
  
## More information

The IIS/ASP.NET Basic Information Data Collector also reports ASP.NET applications that may have the compilation debug setting configured to **True**. For more information about this setting, see [Debug Mode in ASP.NET Applications](https://support.microsoft.com/help/2580348).
