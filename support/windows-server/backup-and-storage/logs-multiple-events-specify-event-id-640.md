---
title: System logs events that specify Event ID 640
description: Describes a situation in which system logs many instances of Event ID 640
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Backup, Recovery, Disk, and Storage\Data corruption and disk errors, csstroubleshoot
---
# System logs multiple events that specify Event ID 640

This article provides some information about Event ID 640.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows 10 - all editions  
_Original KB number:_ &nbsp; 4577004

## Symptoms

The Application log lists many ESENT events that specify Event ID 640 in Windows 10, Windows Server 2019, and Windows Server 2016.

## Cause

Event ID 640 indicates that the Extensible Storage Engine (ESE) has detected that a database file and its flush map file are not synchronized. This situation occurs rarely. It is caused by one of the following conditions:

- The database was moved, but not all the required files were moved together with it.
- The sector that hosts the flush map's header is corrupted. This condition is exceptionally rare.
- An existing ESE database was deleted and then re-created, but its flush map file was not deleted or re-created. This discrepancy typically occurs when an application migrates its data from one ESE database to another ESE database, and the application does not clean up correctly. Such migrations may be more frequent during or shortly after Windows upgrades. After the new database is created, the system detects the old flush map file. That file is not synchronized with the new database. In this scenario, there is no risk to the data in the new database. The condition is benign.

## Status

A future release of Windows is expected to include a change that prevents the system from logging Event ID 640 in the benign case.

## Determine the cause of Event ID 640

To determine the cause of Event ID 640, examine the "...FromDb" fields in the event data, and consider the following situations:

- All or some of these fields are not initialized and, therefore, have values of zero. In this case, Event ID 640 was caused by the creation of a new database. This is a benign case. You do not have to take any action to mitigate it.

- All the "...FromDb" fields have non-zero values. In this case, you should investigate the problem.

The "...FromDb" fields appear in bold in the following example of an event log entry:  

> services (836,D,35) Error -1919 validating header page on flush map file '\<Drive>:\\\<Path>\\\<FileName>.jfm'. The flush map file will be invalidated. Additional information: **[SignDbHdrFromDb:Create time:00/00/1900 00:00:00.000 Rand:0 Computer:] [SignFmHdrFromDb:Create time:00/00/1900 00:00:00.000 Rand:0 Computer:]** [SignDbHdrFromFm:Create time:*\<DateTime>* Rand:559408839 Computer:] [SignFmHdrFromFm:Create time:*\<DateTime>* Rand:4291821429 Computer:]

> [!Note]
> In this example, \<Drive>:\\\<Path>\\\<FileName> represents the actual path and name of the flush map file.

## About Event ID 636

If Windows logs Event ID 640 in the benign case, it may also log Event ID 636. In this case, you can also ignore Event ID 636.
