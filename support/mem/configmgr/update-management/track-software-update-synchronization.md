---
title: Track software update synchronization
description: Learn how Configuration Manager synchronizes software update metadata through WSUS at top-level and child sites in a hierarchy.
ms.date: 08/31/2026
ai-usage: ai-assisted
ms.topic: reference
ms.reviewer: kaushika, vicopado
ms.custom: sap:Software Update Management (SUM)\Software Update Synchronization
---

# Track software update synchronization

_Applies to:_ Configuration Manager

## Summary

Software update synchronization keeps the Configuration Manager site database and WSUS databases current. Use this article to understand the underlying process and to help troubleshoot synchronization issues by reviewing the relevant log files and status messages.

Software update synchronization in Configuration Manager retrieves software update metadata that meets the criteria that you configure in the software update point properties. The top-level site synchronizes with Microsoft Update or a configured upstream Windows Server Update Services (WSUS) server. Configuration Manager then replicates the resulting configuration items to child sites in the hierarchy.

This article describes each step in both processes, including the components involved, such as WSUS Synchronization Manager (`WSyncMgr`), SMS Database Notification Monitor (`SMSDBMON`), and Policy Provider (`PolicyPV`). It also describes how Configuration Manager cleans up expired software update metadata from the site database.

## Synchronization at the top-level site

The top-level site is either a central administration site or a stand-alone primary site. You configure products, classifications, languages, and the synchronization source only at this site. The following diagram summarizes synchronization at the top-level site.

:::image type="content" source="./media/top-level-site-synchronization.png" alt-text="Flowchart showing software update synchronization through WSUS Synchronization Manager, WSUS, and child sites." lightbox="./media/top-level-site-synchronization-expanded.png":::

### Step 1: Start software update synchronization

Synchronization starts on a configured schedule or when you manually select **Synchronize Software Updates** in the Configuration Manager console.

For a scheduled synchronization, WSUS Synchronization Manager (`WSyncMgr`) wakes up at the configured time. The WSyncMgr.log file records entries similar to the following example:

```output
Wakeup for scheduled regular sync
Starting Sync SMS_WSUS_SYNC_MANAGER
Performing sync on regular schedule
```

For a manual synchronization, the SMS Provider executes the `SyncNow` method in the `SMS_SoftwareUpdate` WMI class. The method sets the `SyncNow` value in the `Update_SyncStatus` table to `SELF`. `SMSDBMON` then creates `SELF.SYN` in the `WSyncMgr.box` inbox, which wakes up `WSyncMgr`.

The following SQL statement illustrates the database update:

```sql
UPDATE Update_SyncStatus
SET SyncNow = 'SELF'
WHERE SiteCode = dbo.fnGetSiteCode();
```

> [!IMPORTANT]
> Don't modify Configuration Manager site database data unless Microsoft Support directs you to do so. Unsupported database changes can leave the site in an unsupported state.

The relevant log files contain entries similar to these examples:

- SMSProv.log:

  ```output
  ExecMethodAsync : SMS_SoftwareUpdate::SyncNow
  ```

- SMSDBMON.log:

  ```output
  RCV: UPDATE on Update_SyncStatus for SyncNotif_WSyncMgr [SELF][47788]
  SND: Dropped <ConfigMgr installation folder>\inboxes\WSyncMgr.box\SELF.SYN [47788]
  ```

- WSyncMgr.log:

  ```output
  Wakeup by inbox drop
  Found local sync request file
  Starting Sync
  Performing sync on local request
  ```

`WSyncMgr` reads the software update points from the site control file. It synchronizes the first software update point installed at the site before it synchronizes any additional software update points. Additional software update points are WSUS replicas of the first software update point.

> [!TIP]
> To initiate synchronization without the console, create a zero-byte SELF.SYN file in \<ConfigMgr installation folder>\\Microsoft Configuration Manager\\Inboxes\\WSyncMgr.box on the top-level site server. Use this method only when console-based synchronization isn't available.

### Step 2: Request synchronization from WSUS

`WSyncMgr` uses the WSUS administration API to request synchronization from WSUS on the first software update point. WSUS connects to Microsoft Update or to the upstream WSUS server configured for the top-level site.

`WSyncMgr` creates status message ID 6701 (WSUS synchronization started) and 6704 (WSUS synchronization is in progress). WSUS records a request initiated by `WSyncMgr` as a manual synchronization in WSUS console, even when a Configuration Manager schedule triggered the request. The WsyncMgr.log file records entries that resemble the following examples:

```output
STATMSG: ID=6701 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_WSUS_SYNC_MANAGER"...
...
STATMSG: ID=6704 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_WSUS_SYNC_MANAGER"...
Synchronizing WSUS server <SERVERFQDN>
sync: Starting WSUS synchronization
```

### Step 3: Synchronize metadata into the WSUS database

WSUS downloads software update metadata and applies changes to the WSUS database. `WSyncMgr` monitors progress through the WSUS API, and records the following entries in WsyncMgr.log:

```output
sync: WSUS synchronizing categories
sync: WSUS synchronizing updates
sync: WSUS synchronizing updates, processed 130 out of 130 items (100%)
Done synchronizing WSUS Server <SERVERFQDN>
```

After WSUS finishes, `WSyncMgr` waits for the synchronization results to become available and records the content version of the update source.

### Step 4: Synchronize metadata into the site database

`WSyncMgr` reads categories and updates from the WSUS database and inserts or updates them in the Configuration Manager site database. Configuration Manager stores software update metadata as configuration items.

During this phase, `WSyncMgr` creates status message ID `6705` (WSUS synchronization is in progress), and records the following entries in WsyncMgr.log:

```output
STATMSG: ID=6705 SOURCE="SMS Server" COMP="SMS_WSUS_SYNC_MANAGER"
Synchronizing SMS database with WSUS server <SERVERFQDN>
sync: SMS synchronizing categories, processed 223 out of 223 items (100%)
sync: SMS synchronizing updates, processed 5 out of 5 items (100%)
Done synchronizing SMS with WSUS Server <SERVERFQDN>
```

After the site database synchronization finishes, `WSyncMgr` calls the `spProcessSUMSyncStateMessage` stored procedure. The procedure updates the last synchronization time and content version for the software update point. The WsyncMgr.log file records an entry that resembles the following example:

```output
Set content version of update source {C2D17964-BBDD-4339-B9F3-12D7205B39CC} for site CS1 to 34
```

### Step 5: Run WSUS maintenance

If you enable WSUS maintenance in the software update point properties, `WSyncMgr` starts a separate maintenance thread after metadata synchronization. Depending on the selected options, Configuration Manager performs these tasks:

- Adds recommended nonclustered indexes to the WSUS database if they don't exist.
- Declines expired updates, old revisions, and updates that are superseded longer than the configured period.
- Deletes obsolete updates that meet the WSUS deletion criteria.

During the maintenance process, the WsyncMgr.log file records entries that resemble the following examples:

```output
Starting cleanup on WSUS, default server <SERVERFQDN>
Cleaning up WSUS server <SERVERFQDN>
Done Indexing SUSDB. Custom indexes were created if they didn't exist previously. <SERVERFQDN>
Cleanup processed 804 total updates and declined 8
Done Declining updates in WSUS Server <SERVERFQDN>
6 update(s) were deleted from SUSDB in Server: <SERVERNAME> Database: SUSDB
Waiting for 5 minutes after deleting obsolete updates. Deletion Completed
```

These tasks maintain the WSUS database. They're separate from the process that removes expired software update configuration items from the Configuration Manager site database.

### Step 6: Notify child sites

`WSyncMgr` sends synchronization notifications to all child sites through file replication. The notifications instruct the child sites to synchronize their WSUS servers. The WsyncMgr.log file records entries that resemble the following example:

```output
Sending sync notification to child site(s): PS1, PS2
SQL Replication type has not been set for <ConfigMgr installation folder>\inboxes\WSyncMgr.box\outbox\CS1.SYN, replicating to (PS1, PS2)
```

### Step 7: Replicate configuration items

Configuration Manager replicates software update configuration items from the top-level site database to child primary site databases through database replication. When synchronization finishes successfully, `WSyncMgr` creates status message ID `6702` (WSUS synchronization finished).

## Synchronization at child sites

At the end of top-level site synchronization, each child site receives a synchronization notification. Because database replication already provides the update configuration items, synchronization at a child primary or secondary site primarily synchronizes its WSUS servers.

The following diagram summarizes synchronization at a child site.

:::image type="content" source="./media/child-site-synchronization.png" alt-text="Flowchart showing child-site synchronization from the parent notification through WSUS cleanup and secondary-site notification." lightbox="./media/child-site-synchronization-expanded.png":::

### Step 1: Receive the parent-site notification

The parent site sends a .syn notification through file replication. When the file arrives in `WSyncMgr.box`, `WSyncMgr` wakes up and starts synchronization. The WsyncMgr.log file records entries that resemble the following examples:

```output
Wakeup by inbox drop
Found parent sync notification file CS1.SYN
Starting Sync
Performing sync on parent request
```

`WSyncMgr` reads the software update points from the site control file. It identifies the first software update point and any replica software update points at the site.

### Step 2: Start child-site synchronization

`WSyncMgr` creates status message ID `6701` (WSUS synchronization started) and requests synchronization from WSUS on the first software update point. The WsyncMgr.log file records entries that resemble the following examples:

```output
STATMSG: ID=6701 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_WSUS_SYNC_MANAGER"...
Synchronizing WSUS server ps1site.contoso.com
```

### Step 3: Synchronize WSUS from the parent-site software update point

WSUS on the child site's first software update point synchronizes metadata from WSUS on the parent site's software update point. The WsyncMgr.log file records entries that resemble the following examples:

```output
sync: Starting WSUS synchronization
sync: WSUS synchronizing categories
sync: WSUS synchronizing updates, processed 130 out of 130 items (100%)
Done synchronizing WSUS Server ps1site.contoso.com
```

### Step 4: Update the content version and policy

After WSUS synchronization finishes, `WSyncMgr` calls `spProcessSUMSyncStateMessage` to update the last synchronization time and content version in `Update_SyncStatus`. The WsyncMgr.log file records an entry that resembles the following example:

```output
Set content version of update source {C2D17964-BBDD-4339-B9F3-12D7205B39CC} for site PS1 to 34
```

The database update triggers `SMSDBMON` to create an \<UpdateSource_UniqueID>.stn file in policypv.box. Policy Provider (`PolicyPV`) processes this scan tool notification and creates or updates the `UpdateSource` policy in the database. The SMSDBMON.log file records entries that resemble the following examples:

```output
RCV: UPDATE on Update_SyncStatus for UpdSyncStatus_iu [{C2D17964-BBDD-4339-B9F3-12D7205B39CC}][46680]
SND: Dropped <ConfigMgr installation folder>\inboxes\policypv.box\{C2D17964-BBDD-4339-B9F3-12D7205B39CC}.STN
```

The PolicyPV.log file records entries that resemble the following examples:

```output
Found {C2D17964-BBDD-4339-B9F3-12D7205B39CC}.STN
Added Scan Tool ID {C2D17964-BBDD-4339-B9F3-12D7205B39CC}
```

### Step 5: Synchronize replica software update points

`WSyncMgr` sends requests one at a time to WSUS on the remaining software update points, including internet-facing software update points. These WSUS servers are replicas of WSUS on the first software update point.

During this phase, `WSyncMgr` creates status message ID 6706 (WSUS synchronization is in progress). The status message description refers to an internet-facing WSUS server even when the replica isn't internet-facing. The WsyncMgr.log file records entries that resemble the following examples:

```output
Synchronizing replica WSUS servers
STATMSG: ID=6706 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_WSUS_SYNC_MANAGER"
Synchronizing WSUS server ps1replica.contoso.com
sync: Starting Replica WSUS synchronization
Done synchronizing WSUS Server ps1replica.contoso.com
```

### Step 6: Run WSUS maintenance

If WSUS maintenance is enabled, `WSyncMgr` runs the configured maintenance tasks after synchronization. The tasks run against WSUS on the child site's software update points.

### Step 7: Complete synchronization

When synchronization succeeds, `WSyncMgr` creates status message ID `6702` (WSUS synchronization finished) and records the parent site and content version. The WsyncMgr.log file records entries that resemble the following examples:

```output
STATMSG: ID=6702 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_WSUS_SYNC_MANAGER"
Sync succeeded. Setting sync alert to canceled state on site PS1
Successfully synced site with parent CS1, version 34
```

If the site has child secondary sites, `WSyncMgr` sends each one a synchronization notification.

## Expired update cleanup in the site database

`SMS_WSUS_SYNC_MANAGER` removes expired software update metadata from the Configuration Manager site database. This cleanup is distinct from WSUS maintenance tasks, which operate on the WSUS database.

The cleanup runs when `SMS_WSUS_SYNC_MANAGER` starts and at the end of a synchronization cycle. The component calls the `spDeleteExpiredUpdates` stored procedure when the previous call occurred more than three hours ago. The component stores the previous run time as an epoch value in this registry location:

```text
HKLM\Software\Microsoft\SMS\Components\SMS_WSUS_SYNC_MANAGER\LastDeleteExpiredUpdatesTime
```

The stored procedure runs for up to 45 minutes. It marks eligible configuration items as tombstoned, which causes the site database to remove the items and their associations.

An expired update is eligible for deletion when all of the following conditions are true:

- The update isn't part of an active deployment.
- The update isn't in a software update group, except for a supersedence relationship.
- The expiration date is older than the site's **Updates Cleanup Age** value.
- The site owns the configuration item.

You can view the cleanup age in the site database with the following query:

```sql
SELECT *
FROM SC_Component_Property
WHERE Name = 'Updates Cleanup Age';
```

The default delay means an expired update can remain visible in the Configuration Manager console before cleanup removes it. Review `WSyncMgr.log` for an entry similar to `Deleted N expired updates` to confirm that cleanup is running.

## Related content

- [Software updates introduction](/intune/configmgr/sum/understand/software-updates-introduction)
- [Software update maintenance](/intune/configmgr/sum/deploy-use/software-updates-maintenance)
- [WSUS maintenance guide](wsus-maintenance-guide.md)
