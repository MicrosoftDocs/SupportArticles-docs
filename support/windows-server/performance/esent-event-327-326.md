---
title: ESENT Event ID 327 and 326
description: Provides a solution to an issue where ESENT Event IDs 327 and 326 are filled up the Application log file.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:applications, csstroubleshoot
---
# ESENT Event ID 327 and 326 fill up the Application log

This article provides a solution to an issue where ESENT Event IDs 327 and 326 are filled up the Application log file.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 2900773

## Symptoms

When using Windows Server 2012 and later versions, the following events are logged in the application event log at high frequency (about 5 times/sec) about SystemIdentity.mdb.

> Source: ESENT  
Event ID: 327  
Task category: General  
Level: Information  
Keyword: Classic  
Description:  
svchost (2576) database engine has attached database (2, C:\Windows\system32\LogFiles\Sum\SystemIdentity.mdb). (Time=0 sec)  
>
> Internal timing sequence: [1] 0.000, [2] 0.000, [3] 0.000, [4] 0.000, [5] 0.000, [6] 0.032, [7] 0.000, [8] 0.000, [9] 0.000, [10] 0.000, [11] 0.000, [12] 0.015.
Recovery cache: 0  
Source: ESENT  
Event ID: 326  
Task category: General  
Level: Information  
Keyword: Classic  
Description:  
svchost (2576) database engine has attached database (2, C:\Windows\system32\LogFiles\Sum\SystemIdentity.mdb). (Time=0 sec)  
>
> Internal timing sequence: [1] 0.000, [2] 0.000, [3] 0.281, [4] 0.000, [5] 0.000, [6] 0.000, [7] 0.000, [8] 0.000, [9] 0.000, [10] 0.000, [11] 0.000, [12] 0.000.  
Storage cache: 1

As a result, the application event log will be filled up and other events may be difficult to confirm.

## Cause

This issue occurs when there's a problem with the data in the SystemIdentity.mdb database file.

## Resolution

To stop the occurrence of this event, stop the **User Access Logging** service.

After stopping the service, do one of the following.

- Database file deletion and regeneration

    After stopping the service, delete all files in the folder `%SystemRoot%\system32\LogFiles\Sum\`. After that, launch the **User Access Logging** service. The database will be newly generated.

- Stop User Access Logging service

    If you aren't using the **User Access Logging** service, disable it. After stopping the service, disable **Startup Type** for **User Access Logging** at the **Service** item of the maintenance tool.

## References

- [User Access Logging Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh849634(v=ws.11))

- [Manage User Access Logging](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj574126(v=ws.11))
