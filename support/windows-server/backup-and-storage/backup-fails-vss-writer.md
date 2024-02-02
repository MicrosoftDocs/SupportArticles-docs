---
title: Backup fails because of VSS writer
description: Provides a solution to an issue where Windows Server backup fails because of the SQL Server VSS writer.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:volume-shadow-copy-service-vss, csstroubleshoot
ms.subservice: backup-and-storage
---
# Windows Server backup may fail because of the SQL Server VSS writer

This article provides a solution to an issue where Microsoft Windows Server backup fails with an error: A Volume Shadow Copy Service Operation failed.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2016  
_Original KB number:_ &nbsp; 2615182

## Symptoms

A backup of the server may fail with the following error message:

> A Volume Shadow Copy Service Operation failed. Detailed Error: The volume shadow copy operation failed with error 0x800423F4. View the event log for more information.

The following error message will be recorded in the application event log:

```output
Log Name: Application  
Source: Microsoft-Windows-Backup  
Event ID: 521  
Level: Error  
Description:  
Backup started at '*\<DateTime>*' failed as Volume Shadow copy operation failed for backup volumes with following error code '2155348129'. Please rerun backup once issue is resolved.
```

If you examine the application event log more, you will notice numerous errors from sources SQLWriter and SQLVDI.

The errors will be similar to the following:

```output
Log Name: Application
Source: SQLWRITER  
Event ID: 24583  
Level: Error  
Description:  
Sqllib error: OLEDB Error encountered calling ICommandText::Execute. hr = 0x80040e14. SQLSTATE: 42000, Native Error: 3013  
Error state: 1, Severity: 16  
Source: Microsoft SQL Server Native Client 10.0  
Error message: BACKUP DATABASE is terminating abnormally.  
SQLSTATE: 42000, Native Error: 3271  
Error state: 1, Severity: 16  
Source: Microsoft SQL Server Native Client 10.0  
Error message: A nonrecoverable I/O error occurred on file "  {DF1DD65F-F8AD-4946-A764-F62166C541E2}22:" 995(The I/O operation has been aborted because of either a thread exit or an application request.).  
```

```output
Log Name: Application  
Source: SQLVDI  
Event ID: 1  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: CONTOSOSERVER.contoso.local  
Description:  
SQLVDI: Loc=TriggerAbort. Desc=invoked. ErrorCode=(0). Process=3720. Thread=9404. Server. Instance=SBSMonitoring. VD=Global{DF1DD65F-F8AD-4946-A764-F62166C541E2}10_SQLVDIMemoryName_0.
```

## Cause

When Windows Server backup attempts to back up a disk volume, a Volume Shadow Copy Snapshot is created for the volume. When the snapshot is created, any Volume Shadow Copy Service (VSS) writer associated with the volume is called. If any of the VSS writers encounter an error, the entire backup job will fail. In this example, the SQL VSS writer is encountering an error and causing the backup job to fail.

## Resolution

The error is typically caused by a problem with one of the SQL Server instances. In order to troubleshoot the problem,  you must first figure out which SQL Server instance has the problem. Usually, the problematic SQL Server instance will be named in the first recorded SQLVDI error.

For example:

```output
Log Name: Application  
Source: SQLVDI  
Event ID: 1  
Level: Error  
Description:  
SQLVDI: Loc=SignalAbort. Desc=Client initiates abort. ErrorCode=(0). Process=4772. Thread=10300. Client. Instance= SBSMONITORING . VD=Global{3AB8F080-950C-4EF9-B637-0F37B2428F17}1_SQLVDIMemoryName_0.  
```

In this example, the SQL Server instance named *SBSMONITORING* is failing the snapshot.

There may also be an error message from source SQLWRITER that occurs at about the same time as the first SQLVDI error. The SQLWRITER error message may identify the database name that is having a problem with the snapshot.

For example:

```output
Log Name: Application  
Source: SQLWRITER  
Event ID: 24583  
Description:  
Sqllib error: OLEDB Error encountered calling ICommandText::Execute. hr = 0x80040e14. SQLSTATE:  42000, Native Error: 3013  
Error state: 1, Severity: 16  
Source: Microsoft SQL Server Native Client 10.0  
Error message: BACKUP DATABASE is terminating abnormally.  
SQLSTATE: 42000, Native Error: 945  
Error state: 2, Severity: 14  
Source: Microsoft SQL Server Native Client 10.0  
Error message: Database 'SBSMonitoring' cannot be opened due to inaccessible files or insufficient memory or disk space. See the SQL Server errorlog for details.
```

In this example, the database named *SBSMonitoring* is having a problem.

Once you have identified the SQL Server instance that is having a problem, the first step would be to test the backup with that SQL Server instance stopped. In our example of the SBSMonitoring instance, you would stop the **SQL Server (SBSMonitoring) service** on the server.

You would then run the backup job with the affected SQL Server instance stopped. If the backup completes, then you know the failure is caused by the SQL Server instance that is not running. You would then examine the SQL Server error log files and the event logs to see if we can determine what is wrong with that particular instance of SQL Server.

If you can't determine the problematic SQL Server instance from the event logs, you can always stop all the SQL Server instances on the server and try to run backup with SQL stopped. If all the SQL Server instances are stopped, the SQL VSS writer will not be used.

On a default installation of Small Business Server 2008, you would stop the following services:

- SQL Server (SBSMonitoring)
- Windows Internal Database

On a default installation of Small Business Server 2011 Standard, you would stop the following services:

- SQL Server (SharePoint)
- SQL Server (SBSMonitoring)
- Windows Internal Database
