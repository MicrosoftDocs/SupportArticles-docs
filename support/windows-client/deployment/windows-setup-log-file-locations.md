---
title: Windows setup log file locations
description: Describes the setup log file locations for each setup phase of Windows Vista, Windows 7, Windows Server 2008 R2, Windows 8.1, and Windows 10 Version 1607.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, kimnle
ms.custom: sap:setup, csstroubleshoot
ms.technology: windows-client-deployment
---
# Windows Vista, Windows 7, Windows Server 2008 R2, Windows 8.1, and Windows 10 setup log file locations

This article describes where to locate these log files and which log files are most useful for troubleshooting each setup phase of Windows 7, of Windows Server 2008 R2, and of Windows Vista.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 927521

## Introduction

Windows setup log files are in different locations on the hard disk. These locations depend on the setup phase.

Support for Windows Vista without any service packs installed ended on April 13, 2010. To continue receiving security updates for Windows, make sure you're running Windows Vista with Service Pack 2 (SP2). For more information, see [Windows XP support has ended](https://support.microsoft.com/help/14223).

## Down-level phase

The downlevel phase is the Windows setup phase that is running within the previous operating system. The following table lists important log files in this setup phase.

|Log file|Description|
|---|---|
|C:\WINDOWS\setupapi.log|Contains information about device changes, driver changes, and major system changes, such as service pack installations and hotfix installations.<br/><br/> This log file is used only by Microsoft Windows XP and earlier versions.|
|C:\$WINDOWS.~BT\Sources\Panther\setupact.log|Contains information about setup actions during the installation.|
|C:\$WINDOWS.~BT\Sources\Panther\setuperr.log|Contains information about setup errors during the installation.|
|C:\$WINDOWS.~BT\Sources\Panther\miglog.xml|Contains information about the user directory structure. This information includes security identifiers (SIDs).|
|C:\$WINDOWS.~BT\Sources\Panther\PreGatherPnPList.log|Contains information about the initial capture of devices that are on the system during the downlevel phase.|
  
## Windows Preinstallation Environment phase

The Windows Preinstallation Environment (Windows PE or WinPE) phase is the Windows setup phase that occurs after the restart at the end of the downlevel phase, or when you start the computer by using the Windows installation media. The following table lists important log files in this setup phase.

|Log file|Description|
|---|---|
|X:\$WINDOWS.~BT\Sources\Panther\setupact.log|Contains information about setup actions during the installation.|
|X:\$WINDOWS.~BT\Sources\Panther\setuperr.log|Contains information about setup errors during the installation.|
|X:\$WINDOWS.~BT\Sources\Panther\miglog.xml|Contains information about the user directory structure. This information includes security identifiers (SIDs).|
|X:\$WINDOWS.~BT\Sources\Panther\PreGatherPnPList.log|Contains information about the initial capture of devices that are on the system during the downlevel phase.|
|or||
|C:\$WINDOWS.~BT\Sources\Panther\setupact.log|Contains information about setup actions during the installation.|
|C:\$WINDOWS.~BT\Sources\Panther\setuperr.log|Contains information about setup errors during the installation.|
|C:\$WINDOWS.~BT\Sources\Panther\miglog.xml|Contains information about the user directory structure. This information includes security identifiers (SIDs).|
|C:\$WINDOWS.~BT\Sources\Panther\PreGatherPnPList.log|Contains information about the initial capture of devices that are on the system during the downlevel phase.|
  
> [!NOTE]
> You may also see a log file in the `X:\WINDOWS` directory. The Setupact.log file in this directory contains information about the progress of the initial options that are selected on the Windows installation screen. The Windows installation screen appears when you start the computer by using the Windows installation media. After you select **Install now** from the Windows installation screen, the Setup.exe file starts, and this log file is no longer used.

## Online configuration phase

The online configuration phase (the first boot phase) starts when you receive the following message:
> Please wait a moment while Windows prepares to start for the first time.

During this phase, basic hardware support is installed. If it's an upgrade installation, data and programs are also migrated. The following table lists important log files in this setup phase.

|Log file|Description|
|---|---|
|C:\WINDOWS\PANTHER\setupact.log|Contains information about setup actions during the installation.|
|C:\WINDOWS\PANTHER\setuperr.log|Contains information about setup errors during the installation.|
|C:\WINDOWS\PANTHER\miglog.xml|Contains information about the user directory structure. This information includes security identifiers (SIDs).|
|C:\WINDOWS\INF\setupapi.dev.log|Contains information about Plug and Play devices and driver installation.|
|C:\WINDOWS\INF\setupapi.app.log|Contains information about application installation.|
|C:\WINDOWS\Panther\PostGatherPnPList.log|Contains information about the capture of devices that are on the system after the online configuration phase.|
|C:\WINDOWS\Panther\PreGatherPnPList.log|Contains information about the initial capture of devices that are on the system during the downlevel phase.|
  
### Windows Welcome phase

The Windows Welcome phase includes the following options and events:

- It provides the options to create user accounts.
- It provides the option to specify a name for the computer.
- The Windows System Assessment Tool (Winsat.exe) finishes performance testing to determine the Windows Experience Index rating.

The Windows Welcome phase is the final setup phase before a user signs in. The following table lists important log files in this setup phase.

|Log file|Description|
|---|---|
|C:\WINDOWS\PANTHER\setupact.log|Contains information about setup actions during the installation.|
|C:\WINDOWS\PANTHER\setuperr.log|Contains information about setup errors during the installation.|
|C:\WINDOWS\PANTHER\miglog.xml|Contains information about the user directory structure. This information includes security identifiers (SIDs).|
|C:\WINDOWS\INF\setupapi.dev.log|Contains information about Plug and Play devices and driver installation.|
|C:\WINDOWS\INF\setupapi.app.log|Contains information about application installation.|
|C:\WINDOWS\Panther\PostGatherPnPList.log|Contains information about the capture of devices that are on the system after the online configuration phase.|
|C:\WINDOWS\Panther\PreGatherPnPList.log|Contains information about the initial capture of devices that are on the system during the downlevel phase.|
|C:\WINDOWS\Performance\Winsat\winsat.log|Contains information about the Windows System Assessment Tool performance testing results.|
  
## Rollback phase

If a Windows upgrade installation fails, and you've successfully rolled back the installation to the previous operating system desktop, there are several log files that you can use for troubleshooting. The following table lists important log files in this phase.

|Log file|Description|
|---|---|
|C:\$WINDOWS.~BT\Sources\Panther\setupact.log|Contains information about setup actions during the installation.|
|C:\$WINDOWS.~BT\Sources\Panther\miglog.xml|Contains information about the user directory structure. This information includes security identifiers (SIDs).|
|C:\$WINDOWS.~BT\Sources\Panther\setupapi\setupapi.dev.log|Contains information about Plug and Play devices and driver installation.|
|C:\$WINDOWS.~BT\Sources\Panther\setupapi\setupapi.app.log|Contains information about application installation.|
|C:\$WINDOWS.~BT\Sources\Panther\PreGatherPnPList.log|Contains information about the initial capture of devices that are on the system during the downlevel phase.|
|C:\$WINDOWS.~BT\Sources\Panther\PostGatherPnPList.log|Contains information about the capture of devices that are on the system after the online configuration phase.|
  
## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
