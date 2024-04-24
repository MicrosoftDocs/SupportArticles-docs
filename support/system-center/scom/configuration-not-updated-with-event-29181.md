---
title: Configuration isn't updated and event 29181
description: Fixes an issue that repeatedly triggers event ID 29181 on a System Center Operations Manager server.
ms.date: 04/15/2024
---
# Configuration isn't updated and event ID 29181 is logged in System Center Operations Manager

This article provides a resolution for the issue that configuration changes are not updated on a management server and event 29181 is logged.

_Original product version:_ &nbsp; System Center 2012 Operations Manager Service Pack 1, System Center 2012 R2 Operations Manager  
_Original KB number:_ &nbsp; 3092452

## Symptoms

In a System Center environment that has many clients, configuration changes are not updated on a management server. Additionally, the event 29181 is repeatedly logged in the Operations Manager log.

## Cause

This issue occurs when the Management Configuration service fails because the instance transfer can't perform a bulk insert. This issue typically occurs when the environment has a large number of clients, such as 2000 or more.

> [!NOTE]
> You may also encounter this error if the latency from the management server(s) to the Operations Manager SQL Server instance(s) is high (greater than 10ms). 

## Resolution

To fix this issue, follow these steps to modify the batch size settings for the Management Configuration service on the management server:

1. Make a backup of the `..\Program Files\System Center 2012\Operations Manager\Server\ConfigService.Config` file.
1. Edit the ConfigService.config file, and then modify the settings as follows:
    
    ```xml
    <Setting Name="SnapshotSyncManagedEntityBatchSize" Value="10000" />  
    <Setting Name="SnapshotSyncRelationshipBatchSize" Value="10000" />  
    <Setting Name="SnapshotSyncTypedManagedEntityBatchSize" Value="20000" />
    ```

1. Restart the Configuration service.

## More information

To determine whether you are experiencing this issue, run the following SQL query against the `OperationsManager` database:

```sql
select * from cs.WorkItem where workitemname like '%snapshot%' order by StartedDateTimeUtc desc
```

In the scenario that's described in the Symptoms section, the `WorkItemStateId` is always **10** (failed) instead of **20** (successful).

|WorkItemStateId |State Definition |
|----------------|------------------|
|1 |Running |
|10 |Failed |
|12 |Abandoned |
|15 |Timed out |
|20 |Successful |
