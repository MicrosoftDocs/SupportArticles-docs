---
title: activation tasks run over limit
description: This article provides resolutions for the error that occurs when more activation tasks run in Service Broker than the limit set by the Max_Queue_Readers property.
ms.date: 08/04/2020
ms.custom: sap:Administration and Management
ms.reviewer: akbarf, ramakoni
---
# Max_Queue_Readers property is ignored when you try to limit activation tasks in Service Broker

This article helps you resolve the problem that occurs when more activation tasks run in Service Broker than the limit set by the `Max_Queue_Readers` property.

_Original product version:_ &nbsp; SQL Server 2017, SQL Server 2016, SQL Server 2014, SQL Server 2012, SQL Server 2008 R2  
_Original KB number:_ &nbsp; 3163368

## Symptoms

Consider the following scenario:

- You use Service Broker in SQL Server 2017 on Windows, Microsoft SQL Server 2014 or SQL Server 2012.

- You set Service Broker for asynchronous stored procedure execution.

- You set the `Max_Queue_Readers` property to a specific value for the Service Broker queue to limit how many instances of an activation stored procedure run at the same time.

In this scenario, you notice that more activated tasks are running than the value that's set for `Max_Queue_Readers`.

## Cause

This problem can occur if the Service Broker database is switched from single-user mode (`RESTRICTED_USER`) to multi-user mode (`MULTI_USER`) by running the following:

```sql
ALTER DATABASE <dbname> SET MULTI_USER
```

When the user mode is changed on the database, Service Broker is shut down and restarted. During this process, the existing `QueueMonitor` object is dropped, and another instance of `QueueMonitor` object is created. If the activation process is running a long operation while Service Broker is shutting down, the status of the `QueueMonitor` object is changed to **dropped**.

However, the existing `QueueMonitor` object instance isn't deleted because its reference count hasn't reached zero. If the activation procedure is still running when Service Broker restarts, the new instance of the `QueueMonitor` object and the dropped `QueueMonitor` object will coexist in the same queue. The dropped `QueueMonitor` object instance will be deleted the next time that Service Broker starts.

## Workaround

To work around this issue, make sure that you run `ALTER DATABASE <dbname> SET MULTI_USER` when no activated procedure is running. To do this, use one of the following methods:

- Before you change the user mode, disable all the queues in the database, and then re-enable all the queues.
- Before you change the user mode, disable the activation procedure for all the affected queues by running the following command, and then re-enable the activation procedure:

    ```sql
    ALTER QUEUE <queueName> WITH ACTIVATION (STATUS = OFF)
    ```

## More information

You can check the number of activation procedures that are running for a specific queue by running a query against `sys.dm_broker_activated_tasks` as follows:

```sql
SELECT * FROM sys.dm_broker_activated_tasks WHERE queue_id = <queue number>
```

You can query the state of the queue monitor by running the following query:

```sql
SELECT * FROM sys.dm_broker_queue_monitors WHERE queue_id = <queue number>
```

The state of the queue monitor is displayed as **dropped** if the database user mode was changed.
