---
title: Database Replication Service synchronization internals
description: Understand how Configuration Manager schedules, extracts, sends, receives, and acknowledges Database Replication Service changes between sites.
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
# Understand Database Replication Service synchronization internals

## Summary

After Database Replication Service (DRS) initialization finishes and a replication group becomes active, Configuration Manager uses SQL Server change tracking and SQL Server Service Broker (SSB) to synchronize changes between sites. Each synchronization cycle passes through six distinct stages: scheduling, message-builder activation, destination selection, change extraction, message transmission, and completion acknowledgment. A cycle is complete only when the initiating site receives and processes the DRS_SyncComplete acknowledgment from the destination—not when the sender finishes queuing its outgoing messages.

This article describes each stage in detail and identifies the database objects, log entries, and diagnostic queries you can use to determine where a cycle stopped.

For a decision tree that starts from a degraded or failed replication link, see [Troubleshoot Database Replication Service links](sql-replication.md).

> [!IMPORTANT]
> The tables, views, and message names in this article are for understanding and read-only diagnostics. Don't update Configuration Manager database objects, execute DRS stored procedures manually, or delete SSB conversations. Run Replication Link Analyzer (RLA) for supported repairs. If RLA doesn't resolve the condition, contact Microsoft Support.

## Understand replication groups, articles, and patterns

DRS doesn't synchronize the database as one unit. It organizes replicated data into **replication groups**. Each group contains one or more **articles**, and each article defines an object whose changes are replicated together with the other articles in the group.

The replication pattern controls the direction and extraction format:

- **Global** data ordinarily flows from the central administration site (CAS) to primary sites. Some global data can originate at a primary site, flow to the CAS, and then replicate to other primary sites.
- **Site** data flows from a primary site to the CAS. It doesn't ordinarily flow from one primary site to another.
- **Global proxy** data is the subset of global data that flows from a primary site to its secondary sites.

Initialization transfers a complete copy of the applicable data. Normal synchronization begins after initialization and transfers changes from the last successfully sent change-tracking version.

## Understand the end-to-end synchronization cycle

A normal cycle has two control paths:

1. The DRS message-builder path at the initiating site schedules the replication group, extracts changes, and sends synchronization messages.
1. The DRS receive path at the destination processes the messages and returns a completion acknowledgment through the RCM control channel.

:::image type="content" source="media/drs-synchronization-internals/end-to-end-flow.png" alt-text="Sequence diagram of a DRS synchronization cycle. The initiating site schedules and extracts changes, sends synchronization start, data, and end messages to the destination, and records incomplete send history. The destination applies the changes and returns DRS SyncComplete through the RCM channel. The source then records the processing and completion times.":::

The following sequence is important when troubleshooting:

1. The initiating site determines that a replication group's synchronization interval has elapsed.
1. It places a `DRS_StartMsgBuilder` message in `ConfigMgrDRSMsgBuilderQueue`.
1. Queue activation runs the message builder for that replication group.
1. The message builder selects eligible destinations and extracts article changes.
1. It sends `DRS_SyncStart`, zero or more data messages, and `DRS_SyncEnd` over the group's SSB conversation.
1. The destination processes the messages in order and applies the changes.
1. After processing `DRS_SyncEnd`, the destination returns `DRS_SyncComplete` through the RCM queue.
1. The initiating site records the destination processing time and the local completion time.

Sending `DRS_SyncEnd` doesn't complete the cycle. The cycle is complete only after the initiating site processes the matching `DRS_SyncComplete` acknowledgment.

## Phase 1: Schedule the replication group

:::image type="content" source="media/drs-synchronization-internals/initiating-site-flow.png" alt-text="Flowchart of initiating-site DRS processing in four phases. RCMCtrl schedules and activates the message builder, DRS filters destinations by throttling and dialog state, validates change-tracking versions and extracts articles by replication pattern, and then sends the message sequence and waits for SyncComplete.":::

The `RCMCtrl` synchronization thread runs the scheduler once per minute. The scheduler evaluates active send channels for replication groups. A group is eligible when all the following conditions apply:

- Its configured synchronization interval has elapsed since `LastSendStartTime`. A clock change that makes the current time earlier than the last start time also makes the group eligible.
- The send channel is active.
- Its transport is DRS, or its distributed-view transport isn't currently enabled for that site.
- A `DRS_StartMsgBuilder` message for the same group isn't already waiting in `ConfigMgrDRSMsgBuilderQueue`.
- The replication pattern isn't the cloud pattern.

The scheduler considers groups in replication-priority order. A CAS doesn't initiate site-data synchronization because site data originates below the CAS.

For each eligible group, the scheduler obtains an SSB dialog for the appropriate priority contract and sends `DRS_StartMsgBuilder` to the local message-builder queue. This queue separates scheduling from extraction, so the scheduler doesn't have to wait for a group to finish building its data messages.

## Phase 2: Activate the message builder

The activation procedure for `ConfigMgrDRSMsgBuilderQueue` receives one message at a time. For `DRS_StartMsgBuilder`, it uses the replication group ID as SQL session context and checks active SQL requests before starting extraction. If another request already has the same group context, DRS logs that the group is already being processed and doesn't start a second extraction for it.

This check and the scheduler's queue check prevent concurrent message builders for the same replication group. A message already in the queue or a session already processing the group indicates that the previous cycle didn't leave the message-building stage.

DRS also honors its internal stop-sending signal. While that signal exists, the activation procedure leaves new group changes unsent and logs the reason. This behavior can occur during site maintenance and recovery operations.

## Phase 3: Select destination sites

Before extracting changes, DRS identifies the active destinations that can participate in the cycle. It excludes a destination in the following important conditions.

### Incomplete-cycle throttling

DRS examines recent send history for the replication group and destination. If the number of recent rows without `SyncCompleteTime` reaches the current throttling window, DRS doesn't send another cycle to that destination. It logs a message similar to:

```output
Not sending changes to sites <site code> since last <count> syncs to these sites have not completed.
```

This behavior prevents an unhealthy destination from accumulating an unlimited number of incomplete cycles. It also means that an extraction problem might actually be the result of earlier cycles that never returned `DRS_SyncComplete`.

### Changed dialog with an incomplete cycle

DRS obtains the current SSB dialog handle for each destination. If it has to create a different dialog while send history still contains an incomplete cycle for that group and destination, it doesn't use the new dialog in the current cycle. `LastSendResult` is set to `-20`, and DRS retries in a later cycle.

This safeguard prevents a cycle that began on one conversation from being incorrectly completed on another conversation.

### Secondary-site eligibility

For global-proxy data, a primary site also removes secondary sites that aren't currently eligible to receive the group. Other site state and channel-health checks can further reduce the target list.

After selecting destinations, DRS creates a new synchronization ID. The same GUID correlates the start, data, end, and completion processing for that cycle.

### Inspect incomplete cycles

Run the following read-only query at the initiating site. Replace the replication group and destination site code with the affected values:

```sql
DECLARE @ReplicationGroup nvarchar(255) = N'Configuration Data';
DECLARE @TargetSite nvarchar(3) = N'P01';

SELECT TOP (10)
    h.SyncID,
    h.TargetSite,
    h.ChangeCount,
    h.MessageCount,
    h.StartTime,
    h.EndTime,
    h.ProcessedTime,
    h.SyncCompleteTime
FROM dbo.DrsSendHistory AS h
INNER JOIN dbo.ReplicationData AS r
    ON r.ID = h.ReplicationGroupID
WHERE r.ReplicationGroup = @ReplicationGroup
    AND h.TargetSite = @TargetSite
ORDER BY h.ID DESC;
```

The following sample output shows two cycles that the sender finished but the destination didn't acknowledge:

```output
SyncID                                TargetSite ChangeCount MessageCount StartTime               EndTime                 ProcessedTime SyncCompleteTime
------------------------------------ ---------- ----------- ------------ ----------------------- ----------------------- ------------- ----------------
5F42C6C2-09B7-4A24-98B1-9E39D6845F34 P01        7           2            2026-07-29 09:42:01.000 2026-07-29 09:42:02.000 NULL          NULL
11841AE7-E550-4501-948C-BD41CD48B751 P01        3           1            2026-07-29 09:37:01.000 2026-07-29 09:37:02.000 NULL          NULL
```

The selection logic is conceptually equivalent to the following pseudocode:

```text
recentCycles = latest cycles for this group, grouped by destination
if incomplete cycles in recentCycles >= throttling window:
    exclude destination from this synchronization
    log that recent synchronizations haven't completed
```

The actual throttling window is product-controlled. Don't update send-history rows to bypass it.

## Phase 4: Extract article changes

For every article in the replication group, DRS compares the last version successfully sent with the SQL change-tracking versions that remain valid. It then invokes the generated extraction object for that article:

- Site-pattern articles use an `SCCM_DRS.spGet<ArticleName>Changes` procedure and place serialized results in a site tracking table.
- Global-pattern articles use an `SCCM_DRS.fnGet<ArticleName>Changes` function and place row operations in a global tracking table.
- Filtered global-proxy articles use an `SCCM_DRS.fnGet<ArticleName>ChangesSec` function so the secondary site receives only its applicable data.

The extracted operations include the table, operation type, change version, replication context, and changed row data. DRS preserves article dependencies when it later applies upserts and deletes at the destination.

### Change-tracking version validity

SQL Server periodically cleans old change-tracking versions. If a destination's last sent version is older than the minimum version that remains valid for an article and the condition isn't explained by a newly added table, normal synchronization can't reconstruct all missed changes. DRS logs a potential resynchronization warning that identifies the replication group, article, last sent version, and minimum valid versions.

This condition requires reinitialization of the affected data; it isn't corrected by clearing an SSB queue. For change-tracking cleanup and backlog diagnostics, see [Database Replication Service performance](sql-performance.md).

### Interpret extraction VLogs

When you enable DRS verbose logging, a successful global-pattern extraction generates entries similar to the following example. The synchronization GUID stays the same throughout one cycle:

```output
SYNC(9E4382D1-F137-4B13-9298-0A63F740C842) [Configuration Data] Start extract and send of changes, pattern is global and group id is 3
SYNC(9E4382D1-F137-4B13-9298-0A63F740C842) [Configuration Data] Encoding and Compression is enabled for this replication group.
SYNC(9E4382D1-F137-4B13-9298-0A63F740C842) [Configuration Data] Starting scan, group ID is 3
SYNC(9E4382D1-F137-4B13-9298-0A63F740C842) [Configuration Data] - Extracted 1 changes for table CM_SiteConfiguration
SYNC(9E4382D1-F137-4B13-9298-0A63F740C842) [Configuration Data] Extracted 1 total changes.
```

If the start and scan entries appear but the total-change entry doesn't, inspect the intervening entries for the article that failed. The relevant extraction logic can be summarized as follows:

```text
for each article in the replication group:
    verify that the last sent version is still valid
    select the extraction object for the replication pattern
    append extracted operations to the applicable tracking table
    preserve the article dependency information
```

## Phase 5: Send the message sequence

DRS sends an ordered sequence for every selected destination.

### Synchronization start

`DRS_SyncStart` identifies the source site, replication group, synchronization ID, starting version, and other cycle metadata. When the destination processes it, the receiving message-activity row associates with the current synchronization ID and receive dialog handle.

### Data messages

If the extraction process makes changes, DRS creates one or more data messages:

- Global and global-proxy row operations use `DRS_SyncData` or `DRS_SyncDataCompressed`.
- Site-pattern serialized operations use `DRS_SyncBinaryData` or `DRS_SyncBinaryDataCompressed`.
- The receiver decompresses compressed messages before parsing and applying them.

To keep messages within the configured maximum replication-message size, DRS splits them. The `DRS_MessageActivity_Send` function keeps track of the message count and the sizes of compressed, uncompressed, and total data for the cycle.

Before each data send, DRS checks that the send channel is still active and that `LastVersionSent` didn't change since extraction began. If the version changed, `LastSendResult` becomes `-10` and the cycle stops. This check prevents two cycles from advancing the same destination from different starting versions.

At the destination, the message handler:

1. Reads the synchronization metadata.
1. Decompresses or decodes the message when required.
1. Builds the article dependency order.
1. Applies upserts.
1. Applies deletes.
1. Advances the receive-side version and message activity.

### Synchronization end and ping

After sending all data messages, DRS sends `DRS_SyncEnd`. It can also send a synchronization ping that's used for channel-health tracking. The initiating site then updates its last-send end time and last version sent, and inserts a row in `DrsSendHistory` for the synchronization ID and each destination.

At this point, the send-history row has a start and end time, but `ProcessedTime` and `SyncCompleteTime` remain empty. The acknowledgment path, not the sender's end-message path, intentionally populates those columns.

### Interpret send and receive VLogs

The initiating site records the transition from extraction to transport:

```output
SYNC(9E4382D1-F137-4B13-9298-0A63F740C842) [Configuration Data] Sending DRS_SyncStart message to 1 sites.
SYNC(9E4382D1-F137-4B13-9298-0A63F740C842) [Configuration Data] Called spDRSSendDataMsg 1 times.
SYNC(9E4382D1-F137-4B13-9298-0A63F740C842) [Configuration Data] Sending DRS_SyncPing and DRS_SyncEnd message to 1 sites and updating DRS_MessageActivity.
SYNC(9E4382D1-F137-4B13-9298-0A63F740C842) [Configuration Data] Completed operation in 1 seconds.
```

The corresponding destination entries show whether the receive handler decoded and applied the data:

```output
Received message DRS_SyncStart.
Updating DRS_MessageActivity_Receive CurrentReceiveDialogHandle: 5e179647-4d47-f111-93fd-00155d012345, LastReceiveStartTime: 07/29/2026 09:42:01 and LastReceiveResult: 0.
DRS_SyncDataCompressed message decompressed from length 762 to 2376.
Processed all upserts.
Processed all deletes.
Updating DRS_MessageActivity_Receive with LastVersionReceived: 4099493 for ReceiveDialogHandle: 5e179647-4d47-f111-93fd-00155d012345.
Received message DRS_SyncEnd.
Updating DRS_MessageActivity_Receive with LastVersionReceived: 4099494 and LastReceivedEndTime: 07/29/2026 09:42:02 for DialogHandle: 5e179647-4d47-f111-93fd-00155d012345.
Processed message DRS_SyncEnd.
```

The values are illustrative, but the message text reflects the current processing stages. A sender `Completed operation` entry means that message construction finished. It doesn't mean that the destination applied the messages or that the source received `DRS_SyncComplete`.

## Phase 6: Acknowledge completion

When the destination processes `DRS_SyncEnd`, it looks up the matching `CurrentReceiveSyncID` in receive-side message activity.

- If the synchronization ID matches, the destination creates `DRS_SyncComplete` with the destination site code, synchronization ID, and processing time.
- If the synchronization ID isn't current for any receive channel, the destination returns `DRS_SyncError` when it can identify the source. This response allows the initiating site to resolve stale synchronization history instead of waiting indefinitely.

`DRS_SyncComplete` travels through the `ConfigMgrRCMQueue` control channel, not the DRS data queue. At the initiating site, RCM processes the acknowledgment and:

- Sets `DrsSendHistory.ProcessedTime` to the processing time reported by the destination.
- Sets `DrsSendHistory.SyncCompleteTime` to the time the initiating site processed the acknowledgment.
- Updates `DRS_MessageActivity_Send.LastSyncProcessedTime`.
- Updates RCM channel health for the destination.

This distinction explains several failure patterns:

- A populated send end time with an empty completion time means that the sender finished queuing the cycle, but the complete acknowledgment wasn't processed.
- A destination can have applied the data even though the initiating site still shows an incomplete cycle if the RCM acknowledgment path is unhealthy.
- Repeated incomplete cycles eventually trigger sender throttling for that group and destination.

### Compare send and receive activity

Run this read-only query on each affected site and compare the row for the same replication group and remote site.

```sql
DECLARE @ReplicationGroup nvarchar(255) = N'Configuration Data';
DECLARE @RemoteSite nvarchar(3) = N'P01';

SELECT
    ReplicationGroup,
    ReplicationPattern,
    SiteCode,
    LastVersionSent,
    LastVersionReceived,
    [LastSendStartTime(local)],
    [LastSendEndTime(local)],
    [LastReceiveStartTime(local)],
    [LastReceiveEndTime(local)],
    [LastSyncProcessedTime(local)],
    LastSendResult,
    LastReceiveResult,
    CurrentSendSyncID,
    CurrentReceiveSyncID,
    CurrentReceiveDialogHandle,
    SendConversationGroupID
FROM dbo.vDRS_MessageActivity
WHERE ReplicationGroup = @ReplicationGroup
    AND SiteCode = @RemoteSite;
```

Focus on the following comparisons:

- `CurrentSendSyncID` at the sender identifies the cycle you're investigating.
- `CurrentReceiveSyncID` at the destination advances when `DRS_SyncStart` is processed.
- `LastReceiveEndTime(local)` advances when the destination processes `DRS_SyncEnd`.
- `LastSyncProcessedTime(local)` at the sender advances after the sender processes `DRS_SyncComplete`.

The completion logic is conceptually equivalent to the following pseudocode:

```text
destination processes DRS_SyncEnd
if synchronization ID matches current receive activity:
    destination sends DRS_SyncComplete over ConfigMgrRCMQueue

source processes DRS_SyncComplete
source sets ProcessedTime from the destination message
source sets SyncCompleteTime to the current source time
source updates LastSyncProcessedTime
```

## Understand the DRS queues

The synchronization path uses different queues for different responsibilities:

- `ConfigMgrDRSMsgBuilderQueue` is a local work queue that starts extraction for a replication group.
- `ConfigMgrDRSQueue` receives global and global-proxy synchronization messages.
- `ConfigMgrDRSSiteQueue` receives site-data synchronization messages.
- `ConfigMgrRCMQueue` receives control messages, including `DRS_SyncComplete` and `DRS_SyncError`.

An empty transmission queue doesn't prove that a cycle completed. It only proves that SQL Server transmitted the outgoing messages. Check the destination DRS queue and the return RCM path before concluding that synchronization succeeded.

## How to interpret "LastSendResult"

Negative `LastSendResult` values identify the point where the sender abandoned a cycle:

| Value | Meaning |
| --- | --- |
| `-99` | Snapshot-isolation error. |
| `-20` | The SSB dialog handle changed while an earlier synchronization was incomplete. |
| `-10` | `LastVersionSent` changed while synchronization was in progress. |
| `-3` | The replication group requires reinitialization, and the message builder sent an invalid-subscription notification. |
| `-2` | An exception occurred while sending `DRS_SyncStart` or `DRS_SyncEnd`. |
| `-1` | Another error caused the synchronization cycle to fail. Review earlier log entries for the specific failure. |

A nonnegative value counts successful data-message activity; it doesn't by itself prove that the destination returned `DRS_SyncComplete`.

## How to safely correlate a cycle

Start with the supported DRS diagnostic procedure. It collects replication-group status, message activity, send and receive queues, send history, and SSB configuration in one output set:

```sql
EXEC spDiagDRS;
```

For more information, see [Get details with SPDiagDRS](troubleshoot-database-replication-service-issues.md#get-details-with-spdiagdrs).

Use the synchronization ID to correlate one cycle across the logs and diagnostic output. The most useful sequence is:

1. Find the affected replication group and destination in DRS message activity.
1. Note `LastSendStartTime`, `LastSendEndTime`, `LastSendResult`, and `LastSyncProcessedTime`.
1. Find the same group, destination, and time in send history.
1. Determine whether `ProcessedTime` and `SyncCompleteTime` are populated.
1. Check the destination receive activity for the same source, group, and synchronization ID.
1. Check the source transmission queue, destination DRS receive queue, and source RCM receive path.
1. Correlate the synchronization ID in `RCMCtrl.log` and DRS verbose log entries.

Use this interpretation:

| Observation | Likely stage |
| --- | --- |
| No new send start after the interval elapses | Scheduling, inactive channel, stop-sending state, or message-builder activation. |
| Send start exists, but send end doesn't | Extraction, message construction, or data send. |
| Send end exists, but destination receive end doesn't | SSB transport or destination queue processing. |
| Destination receive end exists, but source completion is empty | `DRS_SyncComplete` creation, RCM transport, or RCM processing. |
| Several recent send-history rows have empty completion times | The destination is approaching or has reached the sender throttling window. |
| `LastSendResult` is `-20` | The dialog changed while a prior cycle remained incomplete. |

## How to correlate SSB conversations

DRS stores reusable SSB dialogs in `SSB_DialogPool`. Send-side message activity associates a replication group and destination with the current send conversation group. Receive-side message activity stores the current receive conversation handle.

The conversation group ID is local to one SQL Server instance. To trace a dialog across sites, use `sys.conversation_endpoints.conversation_id`, which identifies the two ends of the same SSB conversation. On the receiving site, the resulting `conversation_handle` should agree with `CurrentReceiveDialogHandle` for the active source and replication group.

On the initiating site, first find the DRS dialog pool entries for the destination and identify the applicable conversation group:

```sql
SELECT
    FromService,
    ToService,
    OnContract,
    Handle,
    ConversationGroupID,
    CreationTime
FROM dbo.SSB_DialogPool
WHERE ToService LIKE N'ConfigMgrDRS_%'
ORDER BY CreationTime DESC;
```

Use `SendConversationGroupID` from `vDRS_MessageActivity` to find the cross-site conversation ID:

```sql
DECLARE @SendConversationGroupID uniqueidentifier =
    '00000000-0000-0000-0000-000000000000';

SELECT
    conversation_handle,
    conversation_id,
    conversation_group_id,
    state_desc,
    far_service,
    far_broker_instance
FROM sys.conversation_endpoints
WHERE conversation_group_id = @SendConversationGroupID;
```

Replace the placeholder with the actual GUID. Then run the following query at the destination, using the `conversation_id` returned by the initiating site:

```sql
DECLARE @ConversationID uniqueidentifier =
    '00000000-0000-0000-0000-000000000000';

SELECT
    conversation_handle,
    conversation_id,
    conversation_group_id,
    state_desc,
    far_service,
    far_broker_instance
FROM sys.conversation_endpoints
WHERE conversation_id = @ConversationID;
```

The destination `conversation_handle` should match `CurrentReceiveDialogHandle` for the applicable source site and replication group. The conversation IDs correlate the two SQL Server instances; the local conversation group IDs don't.

A mismatch can occur after a site database is restored from an older snapshot or when SSB dialog state is altered while synchronization is active. The original cycle can then remain incomplete because its start and end messages no longer correlate with the expected receive handle.

Don't delete rows from `SSB_DialogPool`, end conversations, or run internal dialog cleanup procedures manually. Run RLA first. RLA can detect and repair supported dialog-pool conditions while preserving DRS state. If the handles still don't correlate after RLA completes, collect `RCMCtrl.log`, `SPDiagDRS` output from both sites, and the applicable SQL Server error log, and contact Microsoft Support.

## How to identify the failing stage

Use the following stage boundaries before requesting reinitialization:

- **Scheduling:** No `DRS_StartMsgBuilder` work begins for an active group after its interval.
- **Extraction:** The cycle starts, but article extraction fails or the last sent version is older than the valid change-tracking window.
- **Send:** Extraction completes, but start, data, or end messages fail to enter or leave SSB.
- **Receive and apply:** Messages reach the destination queue but remain queued or fail while applying article operations.
- **Acknowledgment:** The destination processes the end message, but the source doesn't process `DRS_SyncComplete`.

Reinitialization replaces the affected data baseline, but it doesn't repair an underlying SSB endpoint, certificate, blocked SQL session, disabled queue, or RCM acknowledgment failure. Identify and correct that underlying stage first.
