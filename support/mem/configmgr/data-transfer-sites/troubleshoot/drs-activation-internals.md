---
title: Database Replication Service activation internals
description: Understand how Configuration Manager starts, sizes, monitors, and stops Database Replication Service message handlers.
ms.manager: dcscontentpm
audience: itpro
ms.date: 07/30/2026
ms.reviewer: umaikhan
ms.subservice: core-infra
ms.service: configuration-manager
ms.topic: reference
ms.collection: tier3
ms.custom: sap:Configuration Manager Database\Database Replication Links
ai-usage: ai-assisted
---

<!-- markdownlint-disable-next-line MD025 -->
# Understand Database Replication Service activation internals

## Summary

Configuration Manager Database Replication Service (DRS) uses long-running SQL sessions to receive and process replication messages. The SMS Replication Configuration Monitor component, represented by `RCMCtrl`, determines how many handlers are needed, starts them, and replaces them when they exit. Use this information to understand activation architecture, interpret log entries, and diagnose handler or queue problems before you contact Microsoft Support.

For information about the message lifecycle as processed by these handlers, see [Understand Database Replication Service synchronization internals](drs-synchronization-internals.md).

> [!IMPORTANT]
> The objects and queries in this article are for understanding and read-only diagnostics. Don't start DRS stored procedures manually, change queue state, alter site-control properties directly, or terminate SQL sessions. Run Replication Link Analyzer (RLA) first. Contact Microsoft Support if product-managed handlers or database objects remain inconsistent.

## Activation architecture

DRS separates messages by replication pattern:

- `ConfigMgrDRSQueue` receives global and global-proxy data messages.
- `ConfigMgrDRSSiteQueue` receives site-data messages.

RCM runs an activation-management cycle that follows this sequence:

1. Determine the desired number of global and site handlers.
1. Confirm that the site role and current site state allow the applicable handlers.
1. Confirm that each DRS queue is enabled.
1. Keep the required number of asynchronous SQL commands running against the queue.
1. Cancel surplus handlers when the target count decreases.
1. Replace handlers that returned or failed.

This architecture uses external activation managed by RCM. SQL Server stores the queues and messages, while RCM owns the handler sessions that call the DRS activation procedure.

:::image type="content" source="media/drs-activation-internals/activation-flow.png" alt-text="Flowchart that shows RCM calculating DRS handler targets, checking site and queue state, maintaining SQL handler sessions, and continuing the activation cycle.":::

## Process for calculating handler targets

The calculation uses these inputs:

- The SQL Server logical processor count.
- The number of active global receive channels.
- The number of active site receive channels.
- The local site role.
- The `MaxHandlers` site-control property.

`MaxHandlers` defaults to 20. The calculated global and site counts are each capped by this value. This cap is important when comparing current behavior with older troubleshooting material that described an uncapped CPU-derived count.

The role-specific behavior is:

| Site role | Global queue handlers | Site queue handlers |
| --- | --- | --- |
| Central administration site (CAS) | Sized from active global channels and processors, with a minimum of three. | Sized from active site channels and processors, with a minimum of three. |
| Primary site | Sized from active global channels and processors. | Exactly two when site receive channels exist. These handlers allow site-channel control messages, including synchronization completion, to be processed. |
| Secondary site | Sized for the applicable global-proxy receive channels. | Zero. A secondary site doesn't receive site-data replication groups. |

A configured override passed to the activation manager is also constrained by the SQL Server processor count. Increasing a value doesn't create useful concurrency when the site role, active channels, or available processors don't support it.

### Inspect the calculated targets

The following procedure returns only the current calculation:

```sql
EXEC dbo.spDRSGetNumberOfHandlersToLaunch;
```

The result contains the SQL processor count, calculated global handler count, and calculated site handler count. For example:

```output
NumCPUs NumGlobal NumSite
------- --------- -------
16      8         3
```

The values depend on site role and active channels. Don't treat the sample as a recommended configuration.

The calculation is conceptually equivalent to the following pseudocode:

```text
read SQL processor count
read active global and site receive-channel counts
calculate counts for the local site role
apply role minimums where required
cap each calculated count at MaxHandlers
return processor, global-handler, and site-handler counts
```

## Processes for starting and maintaining handlers

RCM first evaluates the local site state. If the site isn't in a state that permits DRS change application, it removes the applicable handler sessions instead of starting new ones.

For each permitted queue, RCM then:

1. Checks whether the queue is enabled.
1. Compares running handlers with the desired count.
1. Cancels handlers that exceed the desired count.
1. Opens encrypted, integrated-authentication SQL connections for missing handlers.
1. Starts the DRS activation procedure asynchronously.
1. Retains the asynchronous state so it can detect completion and restart the handler during a later cycle.

The activation procedure waits for messages, processes a configured fetch size, and returns when signaled or when the queue is disabled. RCM then decides whether to start it again.

### Interpret RCMCtrl.log

A healthy activation cycle contains entries similar to:

```output
Launching 8 sprocs on queue ConfigMgrDRSQueue and 3 sprocs on queue ConfigMgrDRSSiteQueue.
Site is active and DRS queue is enabled, calling the DrsActivation procedure.
spDRSActivation started on ConfigMgrDRSQueue ...
DrsActivation sproc is running on queue ConfigMgrDRSQueue.
```

If a queue isn't enabled, RCM records:

```output
ConfigMgrDRSQueue queue is NOT enabled, so not calling the DrsActivation procedure for this queue.
```

If the site state doesn't permit activation, the log identifies the state boundary and RCM removes handlers. For example, a CAS in maintenance can suppress site-queue handlers, while a reverse-initialization maintenance state suppresses all DRS activation.

A returned-handler message isn't automatically a failure. Correlate it with the preceding queue state, SQL exception, stop signal, or site-state transition.

## Site state and maintenance behavior

Handler availability follows initialization and recovery state:

- An active site runs the handlers allowed by its role.
- During initialization, applicable DRS queues can be disabled so normal change messages aren't applied before the baseline is ready.
- A CAS in maintenance can continue only the queue processing permitted by its specific maintenance condition.
- During reverse initialization, RCM suppresses DRS activation until the required baseline work completes.
- When both desired counts become zero, RCM signals running handlers to stop, waits for them to exit, and removes their sessions.

This coordination prevents normal synchronization from racing with baseline replacement.

## How to inspect the queue and session state

Use this read-only query to inspect the two DRS queues:

```sql
SELECT
    name,
    is_receive_enabled,
    is_enqueue_enabled,
    is_activation_enabled,
    activation_procedure,
    max_readers
FROM sys.service_queues
WHERE name IN (N'ConfigMgrDRSQueue', N'ConfigMgrDRSSiteQueue');
```

`is_receive_enabled = 0` explains why RCM refuses to launch handlers for that queue. Don't use `ALTER QUEUE` to change the state manually; the state can be intentional during initialization or recovery.

Use the following read-only query to identify active requests in the site database that are associated with replication processing:

```sql
SELECT
    r.session_id,
    s.program_name,
    r.status,
    r.command,
    r.wait_type,
    r.wait_time,
    r.blocking_session_id,
    r.cpu_time,
    r.total_elapsed_time
FROM sys.dm_exec_requests AS r
INNER JOIN sys.dm_exec_sessions AS s
    ON s.session_id = r.session_id
WHERE r.database_id = DB_ID()
    AND (
        s.program_name LIKE N'%replication%'
        OR s.program_name LIKE N'%DRS%'
    )
ORDER BY r.session_id;
```

A waiting activation request can be healthy because the handler waits for queue work. Investigate when one or more of these conditions apply:

- RCMCtrl.log repeatedly starts and loses handlers.
- The queue backlog grows while no handler request remains active.
- A handler is blocked by another session for an extended period.
- The queue is unexpectedly disabled after initialization is complete.
- SQL connection, encryption, memory, or authentication errors accompany handler restarts.

## How to distinguish capacity limits from failure states

More handlers don't correct every backlog. Use the observed stage:

| Observation | Interpretation |
| --- | --- |
| Incoming queue grows and all expected handlers are running | SQL processing, blocking, message cost, or sustained arrival rate can be the constraint. |
| Incoming queue grows and RCM reports the queue disabled | Site state or queue state is preventing activation. |
| RCM repeatedly launches handlers that immediately return | Review the returned message and preceding SQL error. |
| Handler target is lower than CPU count | Active channels, site role, or `MaxHandlers` is limiting the count by design. |
| One handler has a long wait with a blocking session ID | Resolve the SQL blocking root cause; adding handlers can increase contention. |
| Outgoing transmission queue grows but incoming queue doesn't | The problem is SSB transport, not destination activation capacity. |

For SQL blocking, memory, and change-tracking backlog checks, see [Database Replication Service performance](sql-performance.md). For SSB transport checks, see [SQL Server instance configuration](sql-configuration.md).

## Supported recovery path

1. Run RLA for the affected link.
1. Confirm the site isn't intentionally initializing, recovering, or in maintenance.
1. Compare calculated targets with RCMCtrl.log.
1. Confirm queue receive state and active SQL requests.
1. Check blocking and SQL Server resource pressure.
1. Collect RCMCtrl.log, `SPDiagDRS` output, and relevant SQL Server error log entries.
1. Contact Microsoft Support if queue state, handler targets, or product-managed sessions remain inconsistent.

Don't use historical registry overrides or direct site-control/database updates to force handler counts. Current builds include bounded handler calculation and role-aware activation behavior.
