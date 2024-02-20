---
title: Error 0x80041323 when you run Scheduled tasks
description: Provides a solution to fix the error 0x80041323 that occurs when you run high number of Scheduled tasks.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:task-scheduler, csstroubleshoot
---
# Error 0x80041323 when running high number of Scheduled tasks

This article provides a solution to fix the error 0x80041323 that occurs when you run high number of Scheduled tasks.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2696472

## Symptoms

Consider the scenario:  

- You have a Windows computer that runs high number of Scheduled tasks under one user account.

- The tasks are failing intermittently and under the LastRun option, you may see following error message

     > The task scheduler service is too busy 0x80041323  

- Under the Task Scheduler operational log you may see the following event logged:

    > Log Name: Microsoft-Windows-TaskScheduler/Operational  
    Source: Microsoft-Windows-TaskScheduler  
    Event ID: 706  
    Task Category: Compatibility module task status update failed  
    Description: Task Compatibility module failed to update task "<task.job>" to the required status 0. Additional Data: Error Value: 2147942405.  
    The error further implies to:  
    >
    > for decimal -2147216605 / hex 0x80041323
    > SCHED_E_SERVICE_TOO_BUSY
    >
    > The Task Scheduler service is too busy to handle your  

- Additionally, you may also notice following events getting logged in Task Scheduler operational log if Task Queue quota or Engine quota exceeded:

- If Task Queue quota exceeded:  

    >Event ID 131  
    Description: Task Scheduler failed to start task "<Task_Name>"; because the number of tasks in the task queue exceeding the quota currently configured to <Task_Queue_Limit>.  
    User Action: Reduce the number of running tasks or increase the configured queue quota.  
    Event ID 132  
    Description: Task Scheduler task launching queue quota is approaching its preset limit of tasks currently configured to <Task_Limit>.  
    User Action: Reduce the number of running tasks or increase the configured queue quota.  

- If Engine quota exceeded:  

    > Event ID 133  
    Description: Task Scheduler failed to start task <Task_Name> in TaskEngine <Engine_Name> for user <User_Name>.  
    User Action: Reduce the number tasks running in the specified user context.  
    Event ID 134  
    Description: Task Engine <Engine_Name> for user <User_Name> is approaching its preset limit of tasks.  
    User Action: Reduce the number of running tasks or increase the configured queue quota.  

    > [!Note]
    > Event ID 132 and Event ID 134 are just an indicator of the approaching issue and not the issue itself. The issue may or may not happen after these events.

## Cause

Based on code `SCHED_E_SERVICE_TOO_BUSY`, this is logged when the queue is full. The above issue occurs if:  

1. Task Queue quota is exceeded.
2. Engine quota is exceeded.

## Resolution

To resolve this particular issue, increase the value for the quota keys to maximum.

> [!Caution]
> This section contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs.

1. Click **Start**, type *regedit*, and then press ENTER.
2. Locate and then click the following registry key:
   `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\Configuration`
3. Right-click **TasksInMemoryQueue**, click **Edit**, and then click **Modify**.
4. In the **Value data** box, type *1000* \(Decimal\).
5. Right-click **TasksPerHighestPrivEngine**, click **Edit**, and then click **Modify**.
6. In the **Value data** box, type *1000* \(Decimal\).
7. Right-click **TasksPerLeastPrivEngine**, click **Edit**, and then click **Modify**.
8. In the **Value data** box, type *1000* \(Decimal\).
9. Exit **Registry Editor** and reboot the machine.

## More information

The Job queue quota is controlled through 'TasksInMemoryQueue' value while the Engine quota is controlled through "TasksPerHighestPrivEngine" and "TasksPerLeastPrivEngine" registry values located under following registry key:  

`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\Configuration`

- TasksInMemoryQueue [Default = 75, Max = 1000]
  - Determines the maximum tasks allowed to be queued in the session manager. Once this limit is exceeded, any new task instance scheduled to be executed will be discarded and you'll get the Event ID 131.
  - This queue is shared by all tasks.
- TasksPerHighestPrivEngine [Default = 100, Max = 1000]
  - Determines the maximum number of task instances allowed to be in RUNNING state for an "elevated" task engine (taskeng.exe) at any given point of time.
  - One task engine exists per user session (like SYSTEM, LOCAL SERVICE, Administrator, USER1, USER2 etc.)
  - Here "elevated" corresponds to those tasks that have the option "Run with highest privileges" selected.
- TasksPerLeastPrivEngine [Default = 50, Max = 1000]
  - Similar to "TasksPerHighestPrivEngine" except that it corresponds to non-elevated tasks.  

## Reference

[Event ID 131 - Task Scheduler Service Quotas](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd363733(v=ws.10))  
[Event ID 132 - Task Scheduler Service Quotas](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd363705(v=ws.10))
