---
title: Information collected by DebugDiag
description: This article describes the information on what is collected in DebugDiag Diagnostic.
ms.date: 03/19/2020
ms.custom: sap:Health, diagnostic, and performance features
ms.topic: article
ms.technology: iis-health-diagnostic-performance
---
# DebugDiag 1.2 installation and data collector

This article describes the information that might be collected from a machine when running the DebugDiag 1.2 installation and data collector.

_Original product version:_ &nbsp; Windows Server 2008 R2, 2008  
_Original KB number:_ &nbsp; 2700007

## Summary

The DebugDiag 1.2 installation and data collector will install DebugDiag 1.2 to the machine, and allow the user to create a hang dump to upload to Microsoft. It also allows the user to run DebugDiag manually and upload data to Microsoft at a later time.

## Operating system

|Description|
|-|
|Machine Name:|
|OS Name:|
|Last Reboot/Uptime:|
|AntiMalware:|
|User Account Control:|
|Username:|
||

## Computer system

|Description|
|-|
|Computer Model:|
|Processor(s):|
|Machine Domain:|
|Role:|
||

## Hang dump files

|Description|File Name|
|--|--|
|Process Dump files|{Computername}\_SDPHangDumps_{Date}_{Time}.zip|
  
## DebugDiag data files

|Description| File Name |
|--|--|
|File Folder specified by user that will contain data they want to upload to Microsoft.|{Computername}\_SDPDebugDiagData_{Date}_{Time}.zip|
  
## DebugDiag log files

|Description| File Name |
|--|--|
|DebugDiag 1.2 Service and Rule Logs|{Computername}_DebugDiag_Logs.zip|
  
## More information

If the user selects to install DebugDiag 1.2 to the machine, it will launch the DebugDiag 1.2 installer.  After installed, this troubleshooter won't remove DebugDiag 1.2 from the machine. Use Control Panel to uninstall the program if that is desired.

For more information, see [KB2598970 - Information about Microsoft Automated Troubleshooting Services and Support Diagnostic Platform](https://support.microsoft.com/help/2598970).
