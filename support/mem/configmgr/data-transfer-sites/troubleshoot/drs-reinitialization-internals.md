---
title: Database Replication Service reinitialization internals
description: Understand how Configuration Manager requests, creates, transfers, applies, and completes a Database Replication Service initialization package.
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
# Understand Database Replication Service reinitialization internals

## Summary

Database Replication Service (DRS) reinitialization establishes a new baseline for a replication group when SQL Server change-tracking synchronization can no longer continue safely. This article explains how Configuration Manager manages each stage of that process—from the initial control message through package creation, file transfer, BCP application, and completion—and how to use database queries and log entries to identify which stage has stalled.

For information about normal change synchronization after the baseline is active, see [Understand Database Replication Service synchronization internals](drs-synchronization-internals.md).

> [!IMPORTANT]
> The queries in this article are read-only. Don't force `.PUB` files, disable queues, update initialization status, delete messages, truncate replication tables, or run BCP manually. Run Replication Link Analyzer (RLA) first and use product-supported reinitialization actions. Contact Microsoft Support when tracking records, packages, queues, or database objects remain inconsistent.

## Why initialization uses the RCM channel

Normal DRS data messages can't repair a subscription whose baseline is invalid. Reinitialization control messages therefore use the Replication Configuration Monitor (RCM) Service Broker channel, including while a normal DRS data queue is unavailable.

The main messages are:

| Message | Purpose |
| --- | --- |
| `DRS_SubscriptionInvalid` | Marks a full replication group or selected articles as requiring initialization. |
| `DRS_InitRequest` | Requests a baseline from the publishing site and carries the tracking GUID. |
| `DRS_InitRequestReceived` | Confirms that the publishing site accepted the current request. |
| `DRS_InitPackageCreated` | Reports that baseline export and package creation completed. |
| `DRS_ApplyingBcp` | Reports application progress at the requesting site. |
| `DRS_InitFailed` | Reports a terminal failure for the tracked request. |
| `DRS_InitFinished` | Confirms that all required articles are active and communicates the synchronization baseline. |

RCM preserves and can replay critical control messages during failover. Current builds also detect some missing or orphaned initialization requests and resend them only when the RCM channel is healthy and no matching request remains in the transmission queue.

:::image type="content" source="media/drs-reinitialization-internals/reinitialization-flow.png" alt-text="Sequence diagram that shows a DRS reinitialization request flow: publisher BCP export and package creation, file transfer to requesting site, BCP import, progress messages, and initialization completion.":::

## End-to-end lifecycle

### 1. Mark the subscription invalid

Configuration Manager identifies either an entire replication group or specific articles that need a new baseline. A full initialization marks the group as required. A partial initialization marks only the named articles.

Configuration Manager assigns a `RequestTrackingGUID` to the request. Configuration Manager uses this value to correlate database state, VLogs entries, RCMCtrl.log, package processing, and control messages.

### 2. Request the package

The requesting site sends `DRS_InitRequest` through the RCM queue. The publishing site validates the sending site, replication group, requested articles, and request age. If a newer outstanding request exists, it ignores the older request. Otherwise, it stores the request and returns `DRS_InitRequestReceived`.

### 3. Export the baseline

RCM on the publishing site creates the initialization content. For each requested article, it:

1. Runs the article's pre-snapshot handling when required.
1. Exports the applicable rows to a `.bcp` file.
1. Writes the expected row count to a companion `.bcp.rowcount` file.
1. Records progress for the tracking GUID.
1. Includes publication and version metadata used by the receiver for validation.

The implementation checks each BCP result and doesn't treat the package as successfully created when a required article export fails.

### 4. Package and transfer the files

The exported files are compressed into an initialization package. Configuration Manager creates a file-replication minijob to transfer the package to the requesting site. The package transfer is separate from the SSB control messages that report request state.

This separation is diagnostically important:

- A healthy `DRS_InitRequest` exchange doesn't prove that the package file transferred.
- A delivered package doesn't prove that its BCP files can be validated or applied.
- An SSB transmission error can block status messages even when a package exists on disk.

### 5. Validate and apply the package

At the requesting site, RCM validates the tracking GUID, replication group, publication metadata, article list, files, and expected row counts. It then performs the applicable pre-apply handling and imports each BCP file.

During BCP application, Configuration Manager can disable change tracking for the target table, replace the applicable baseline rows, import the file in batches, restore change tracking, and run post-snapshot handling. Exact table handling depends on the article definition and replication pattern.

After each required article is applied successfully, its state becomes active. `DRS_ApplyingBcp` messages report aggregate progress to the publishing site.

### 6. Complete initialization

RCM verifies that no required article remains missing or inactive. It then:

1. Calculates the change-tracking baseline needed for subsequent synchronization.
1. Sends `DRS_InitFinished` to the publishing site.
1. Updates send and receive message activity.
1. Marks the replication link active for the group.
1. Allows normal DRS synchronization to resume when all maintenance conditions are cleared.

Initialization isn't complete merely because the CAB file arrived or BCP import began. Completion requires all applicable articles to become active and the finish message to be processed.

## Initialization status values

`RCM_DrsInitializationTracking` records the overall request state and progress percentage.

| Value | Status | Meaning |
| --- | --- | --- |
| 0 | `Unknown` | No meaningful tracked state is available. |
| 1 | `Required` | A baseline is required. |
| 2 | `Requested` | The requesting site sent the request. |
| 3 | `PendingCreation` | The publishing site accepted the request and must create the package. |
| 4 | `PackageCreated` | Export and package creation completed. |
| 5 | `PendingApplication` | The requesting site is validating or applying the package. |
| 6 | `Active` | All required articles are active. |
| 7 | `Aborted` | A newer request or workflow decision superseded this request. |
| 8 | `Missing` | Required initialization content is missing. |
| 99 | `Failed` | Initialization failed. |

Progress milestones start at 0 for required, 1 for requested, 21 for pending creation, 41 for package created, 59 for pending application, and 100 for active. During export and import, progress can advance between these milestones.

The publisher also tracks package work in `RCM_InitPackageRequest`:

| Value | Package request state |
| --- | --- |
| 0 | Requested |
| 1 | Creating |
| 2 | Created |
| 3 | Sent |
| 97 | Retry requested after failover |
| 98 | Retry sent after failover |
| 99 | Create failed |
| 100 | Send failed |

These two tables answer different questions. Initialization tracking describes the cross-site lifecycle. Package request state describes publisher-side creation and transfer work.

## How to inspect tracked requests

Run this read-only query in the site database:

```sql
SELECT
    SiteRequesting,
    SiteFulfilling,
    ReplicationGroup,
    RequestTrackingGUID,
    InitializationStatus,
    InitializationPercent,
    IsPartialInit,
    CreatedTime,
    ModifiedTime,
    TryCount
FROM dbo.RCM_DrsInitializationTracking
ORDER BY ModifiedTime DESC;
```

Example:

```output
SiteRequesting SiteFulfilling ReplicationGroup       InitializationStatus InitializationPercent IsPartialInit
-------------- --------------- ---------------------- -------------------- --------------------- -------------
P01            CAS             Configuration Data    5                    74                    0
```

On the site creating the package, correlate the same GUID with:

```sql
SELECT
    RequestTrackingGUID,
    SiteCode,
    Status,
    Progress,
    CreatedTime,
    LastModifyTime
FROM dbo.RCM_InitPackageRequest
ORDER BY LastModifyTime DESC;
```

A stale timestamp is useful only when interpreted with the current state. For example, `PendingApplication` directs investigation to package receipt, validation, and BCP import. A package request stuck in `Creating` directs investigation to publisher-side export.

## How to correlate control-message transport

Use this query to check whether initialization control messages are waiting for transmission:

```sql
SELECT
    enqueue_time,
    message_type_name,
    to_service_name,
    transmission_status,
    conversation_handle
FROM sys.transmission_queue
WHERE message_type_name IN (
    N'DRS_SubscriptionInvalid',
    N'DRS_InitRequest',
    N'DRS_InitRequestReceived',
    N'DRS_InitPackageCreated',
    N'DRS_ApplyingBcp',
    N'DRS_InitFailed',
    N'DRS_InitFinished'
)
ORDER BY enqueue_time;
```

Don't delete transmission rows or end conversations to clear a symptom. The status text identifies transport or authentication work that must be corrected first.

## How to interpret logs by stage

The following representative entries show useful stage boundaries. Site codes, groups, GUIDs, paths, and values vary.

Request processing in VLogs includes entries similar to:

```output
INFO: Received DRS_InitRequest from Site P01 for replication group: Configuration Data; TrackingGuid [<guid>]
INFO: Received DRS_InitRequestReceived for replication group: Configuration Data
INFO: Received DRS_InitPackageCreated for replication group: Configuration Data
INFO: Received DRS_ApplyingBcp (74) from site P01 for replication group: Configuration Data
INFO: Received DRS_InitFinished from Site P01 for replication group: Configuration Data
```

Publisher-side RCMCtrl.log includes export boundaries such as:

```output
Checking if we need to create an initialization package for replication group Configuration Data for site P01.
BCP out result is 0.
```

File replication records package submission similar to:

```output
Created minijob to send compressed copy of DRS INIT BCP Package to site P01. Transfer root = <package path>.
```

Receiver-side RCMCtrl.log includes import and completion boundaries such as:

```output
Successfully turned off change tracking for table <table> before BCP IN.
Current change track version is <version> after applying bcp files for replication group Configuration Data.
Sent InitFinished message to CAS for replication ID <id>.
```

Search by tracking GUID first. Group name alone can mix an old aborted request with the current request.

## How to locate the failing stage

| Last confirmed stage | Check next |
| --- | --- |
| `Required` | RCM channel health and generation of `DRS_InitRequest`. |
| `Requested` | Transmission status and publisher receipt of the matching GUID. |
| `PendingCreation` | Publisher RCMCtrl.log, BCP results, disk space, and package-request progress. |
| `PackageCreated` | File-replication minijob and sender/receiver transfer logs. |
| `PendingApplication` | Package validation, row-count files, BCP errors, SQL blocking, and disk space at the receiver. |
| `Active` locally but link not active remotely | Delivery and processing of `DRS_InitFinished`. |
| `Failed`, create failed, or send failed | The recorded progress and first preceding error for the same GUID. |

## Supported recovery path

1. Run RLA for the affected link.
1. Record the current tracking GUID, state, percent, and modification time.
1. Correlate the GUID across VLogs, RCMCtrl.log, and file-replication logs at both sites.
1. Check SSB transmission only for missing control-message stages.
1. Check package creation, transfer, or BCP application according to the last confirmed state.
1. Correct environmental causes such as disk space, SQL blocking, connectivity, or permissions.
1. Use the supported console or RLA action when a new initialization is required.
1. Contact Microsoft Support before modifying any product-managed status, queue, message, package, or database object.

Repeatedly requesting reinitialization without finding the failing stage can supersede useful tracking records and create more package work. Preserve the current GUID and evidence before starting another request.
