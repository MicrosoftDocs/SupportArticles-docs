---
title: Compress large registry hives 
description: Describes how to compress large registry hives.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: System Hang
ms.technology: Performance
---
# Compress "Bloated" Registry Hives

This article describes how to compress large registry hives to avoid performance issues.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2498915

## Symptoms

Consider the following scenario:

You may discover that some of your registry hives are abnormally large or "bloated". Registry hives that are in this state can cause various performance issues and errors in the system log.

## Cause

There can be many causes for this issue. Troubleshooting the actual cause can be a long and tedious process. In this scenario, you simply want to compress the registry hives to a normal state.

## Resolution

While there may be third-party tools available for this scenario, the process listed below could be followed to compress the affected hives.

1) Boot from a WinPE disk. ([https://technet.microsoft.com/library/cc766093(WS.10).aspx](https://technet.microsoft.com/library/cc766093%28ws.10%29.aspx))
2) Open regedit while booted in WinPe, load the bloated hive under HLKM. (for example, HKLM\Bloated)
3) Once the bloated hive has been loaded, export the loaded hive as a "Registry Hive" file with a unique name. (for example, %windir%\system32\config\compressedhive)
 a) You can use dir from a command line to verify the old and new sizes of the registry hives.
4) Unload the bloated hive from regedit. (If you get an error here, close the registry editor. Then reopen the registry editor and try again.)
5) Rename the hives so that you'll boot with the compressed hive.
for example,
c:\windows\system32\config\ren software software.old
c:\windows\system32\config\ren compressedhive software

## More information

Related Content 

|Resource|Synopsis|
|---|---|
|B [2903037](https://support.microsoft.com/help/2903037) Cumulative list of reasons that cause a Registry Bloat|Comprehensive list of reasons for registry bloat by rkiran circa 2013.|
|B [2487389](https://support.microsoft.com/help/2487389) How to bloat the registry|Batch file that intentionally bloats the registry for test purposes. Aaronmax.<br/>Default script adds 250K multi-string values into the Cluster Key section of the registry. Can be repurposed for other users.|
|B [2278919](https://support.microsoft.com/help/2278919) Print driver causing registry bloat by adding too many entries under PendingFileRenameOperations|Circa 2010 article by sumehp triggered where HP print driver created thousands of entries under pendingfilerenameoperations section of registry.|
|B [2720115](https://support.microsoft.com/help/2720115) Registry Bloat Detection, Analysis, and Correction|Circa 2012 article by blakemo noting an array of symptoms (SBSL, no boot, high cpu. Leverages checkreg to find and clean up the registry.|
| [2578694](https://support.microsoft.com/help/2578694) Registry bloat in HKU\.DEFAULT\Software\Hewlett-Packard\ by HPZUILHN.DLL|Registry bloat under hku\.default\software\Hewlett-packard section of registry.|
|B [3037266](https://support.microsoft.com/help/3037266) SBSL: App: WNF state registrations cause excessive reads and bloat of notifications registry hive|WNF state registrations cause boot and logon delays. Problem fixed in Windows 10 RTM. Fix was backported to 8.1 / WS12R2 by KB 3063843|
|B [2761589](https://support.microsoft.com/help/2761589) SBSL: DISK: VSS snapshots by DPM et al bloat the system hive of the registry|Windows computers running DPM experience slow OS startup + slow first-time logons + event log spam et al caused by the accumulation of no-longer-in-play snapshots accumulating in the \storage section of the registry.|
|B [2777245](https://support.microsoft.com/help/2777245) SBSL: OS: Registry bloat delays boot and logon performance|Known contributors for registry bloat including Adobe coldfusion, VSS snapshots including DPM backups,|
|KB [2498915](https://support.microsoft.com/help/2498915) : How to Compress "Bloated" Registry Hives|CY 2011 era article that uses WINPE to load offline registry files in REGEDIT.|
|KB [2844430](https://support.microsoft.com/help/2844430) How to compress bloated software hive 2GB after install of Microsoft SQL server 2012 SP1|Contains cleanup script. see KB 2498915 + KB 2793634|
|KB [2845220](https://support.microsoft.com/help/2845220) Insufficient system resources exist to complete the requested service|triggered by AQL bug that causes registry bloat|
|||
