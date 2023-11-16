---
title: Error when you create a snapshot 
description: This article provides workarounds for the problem that when you create a snapshot backup of many databases at the same time in SQL Server.
ms.date: 01/20/2021
ms.custom: sap:Administration and Management
ms.reviewer: kfarlee
---
# Error when you create a snapshot backup of many databases at the same time in SQL Server

This article helps you work around for the problem (`ERROR Selected writer 'Microsoft Writer (Service State)' is in failed state` message) that when you create a snapshot backup of many databases at the same time in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 943471

## Symptoms

In Microsoft SQL Server, you create a snapshot backup of many databases at the same time. To do this, you use the Volume Shadow Copy Service (VSS), or you use the Virtual Backup Device Interface (VDI). In this scenario, the snapshot backup operation fails. Additionally, you receive the following error message if you use the VSS to create the snapshot backup:

> ERROR: Selected writer 'Microsoft Writer (Service State)' is in failed state!
> - Status: 8 (VSS_WS_FAILED_AT_PREPARE_SNAPSHOT)
> - Writer Failure code: 0x800423f4 (\<Unknown error code>)
> - Writer ID: { **WriterID** }
> - Instance ID: { **InstanceID** }

You receive one of the following error messages if you use the VDI to create the snapshot backup:

- Error message 1

    > [Microsoft][ODBC SQL Server Driver][SQL Server] Insufficient resources to create UMS scheduler.  
    Msg 3267, SevLevel 16, State 1, SQLState 42000

- Error message 2

    > [Microsoft][ODBC SQL Server Driver][SQL Server] Could not create worker thread.  
    Msg 3013, SevLevel 16, State 1, SQLState 42000

- Error message 3

    The following message may be logged in the SQL Server error log:

    > \<Datetime> spid420 SubprocessMgr::EnqueueSubprocess: Limit on 'Max worker threads' reached

    The number of databases that you try to back up when this problem occurs varies. The number of databases depends on the following conditions:

    - The configuration of SQL Server.
    - Other activities in SQL Server.

## Cause

In SQL Server, the snapshot backup of each database uses five threads in the *Sqlservr.exe* process. Additionally, other activities may also use threads in the *Sqlservr.exe* process. Depending on the configuration of SQL Server, the available threads may be used up if you create a snapshot backup of many databases at the same time.

## Workaround

To work around this problem, create a snapshot backup of fewer databases at the same time.

If you're running a 64-bit version of SQL Server, you can consider increasing the Max Worker Threads configuration option. It isn't recommended to alter this setting on a 32-bit version of SQL Server.

## More information

We recommend that you create a snapshot backup of fewer than 35 databases at the same time.
