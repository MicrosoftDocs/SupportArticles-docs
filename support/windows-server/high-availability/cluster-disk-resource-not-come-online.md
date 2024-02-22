---
title: Cluster disk resource fails to come online
description: Fixes an issue where the disk resource fails to come online when the name of the cluster disk resource has an invalid character.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jeffhugh, hisingh
ms.custom: sap:cannot-bring-a-resource-online, csstroubleshoot
---
# A cluster disk resource may fail to come online and run chkdsk when an invalid character is used in the resource name

This article provides help to solve an issue where the disk resource fails to come online when the name of the cluster disk resource has an invalid character.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2590305

## Symptoms

If the name of a Cluster disk resource has an invalid character in it from an NTFS perspective '\\' '/' character and there is some file on the root of the drive where the cluster doesn't have READ permission or if the file is in use, then the disk resource fails to come online.

## Cause

The name of the 'Physical Disk' resource has a backslash or forward slash character in the resource name. Example: "Disk G:\\" and 'Local System' cannot open a handle to a file at root of drive (whether because it's in use or permissions).

## Resolution

To fix this issue, install hotfix [3033918](https://support.microsoft.com/kb/3033918).

## Workaround  

To work around this issue, either remove the invalid character(s) in resource names for 'Physical Disk' resource types OR have 'Local System' account at least **Read** permission to files at the root of the drive. After making the changes, you should be able to bring the disk resource online.  

> [!NOTE]
> It is not recommended to store files at the root of a clustered disk as the cluster needs to open handles to files and folders as part of the health detection mechanism used to determine possible access issues to storage. Since the cluster service runs in the context of the 'Local System' account, if that account does not have permission to files at the root of a drive, the health check may fail.  

## More information

Cluster tries to enumerate files on the disk during an Online event and if it is not able to enumerate files on the root of the cluster disk, it would fail the disk.  

A snippet from the cluster logs:  

> 00001668.00001f88::*\<DateTime>* WARN [RES] Physical Disk <G:\\>: OnlineThread: Failed to get volume guid for device \\\\?\\GLOBALROOT\\Device\\Harddisk2\\Partition1\\. Error 3  
00001668.00001f88::*\<DateTime>* WARN [RES] Physical Disk <G:\\>: OnlineThread: Failed to set volguid \\??\\Volume{aaeb0322-6921-11e0-a955-00155d50c903}. Error: 183.  
00001668.00001f88::*\<DateTime>* INFO [RES] Physical Disk <G:\\>: Found 2 mount points for device \\Device\\Harddisk2\\Partition1  
00001668.00001f88::*\<DateTime>* INFO [RES] Physical Disk <G:\\>: VolumeIsNtfs: Volume \\\\?\\GLOBALROOT\\Device\\Harddisk2\\Partition1\\ has FS type NTFS  
>
> 00001668.00001f88::*\<DateTime>* ERR [RES] Physical Disk <G:\\>: VerifyFS: Failed to open file \\\\?\\GLOBALROOT\\Device\\Harddisk2\\Partition1\\kilo.docx Error: 5.  
00001668.00001f88::*\<DateTime>* ERR [RES] Physical Disk <G:\\>: VerifyFS: Failed to open file \\\\?\\GLOBALROOT\\Device\\Harddisk2\\Partition1\\kilo.docx Error: 5.
>
> 00001668.00001f88::*\<DateTime>* ERR [RES] Physical Disk <G:\\>: OnlineThread: Error 123 bringing resource online.  
00001668.00001e3c::*\<DateTime>* ERR [RES] Physical Disk: Failed to get partition size, status 3  
00001668.00001e3c::*\<DateTime>* ERR [RHS] Error 5023 from ResourceControl for resource G:\\.  
00001920.00000808::*\<DateTime>* WARN [RCM] ResourceControl(STORAGE_GET_DIRTY) to G:\\ returned 5023.  

The disk gets marked as dirty as the name had an invalid character and would run chkdsk before the disk is brought online successfully next time. Following events may be noted in the system event log after you correct the problem and online the disk for the first time.  

> Log Name: System  
Source: Microsoft-Windows-FailoverClustering  
Date: *\<DateTime>*  
Event ID: 1066  
Task Category: Physical Disk Resource  
Level: Warning  
Keywords:  
User: SYSTEM  
Computer: XXXXXXXXXXX.com  
Description: Cluster disk resource 'Cluster Disk 1' indicates corruption for volume '\\\\?\\Volume{aaeb0322-6921-11e0-a955-00155d50c903}'. Chkdsk is being run to repair problems. The disk will be unavailable until Chkdsk completes. Chkdsk output will be logged to file 'C:\\Windows\\Cluster\\Reports\\ChkDsk_ResCluster Disk 1_Disk2Part1.log'. Chkdsk may also write information to the Application Event Log.

> Log Name: Application  
Source: Chkdsk  
Date: *\<DateTime>*  
Event ID: 26214  
Task Category: None  
Level: Information  
Keywords: Classic  
User: N/A  
Computer: XXXXXXXXXXXXXXX.com  
Description: Chkdsk was executed in read/write mode.

This does not indicate actual corruption on the disk. What happened is that cluster set the dirty bit on the disk so chkdsk is run to verify an intact file system.
