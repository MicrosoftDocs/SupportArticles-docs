---
title: Mailboxes are stalled during a migration
description: Provides a resolution for an issue in which mailboxes are stalled during a migration.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
  - CI 171618
ms.reviewer: matbyrd, ninob, meerak, v-trisshores
appliesto: 
  - Exchange Server 2019
search.appverid: MET150
ms.date: 01/24/2024
---

# Mailboxes are stalled during a migration

## Symptoms

When you check the status of an in-progress migration of more than 10 mailboxes, you see that only 10 mailboxes have the `CopyingMessages` status. Other mailboxes in the migration batch have a "stalled" status, such as `StalledDueToTarget_MdBReplication`, `StalledDueToTarget_MdbAvailability`, or `StalledDueToTarget_DiskLatency`.

## Cause

Microsoft Exchange Server 2019 implements workload management (WLM) throttling. By default, WLM applies a limit of 10 simultaneous mailbox moves from the same source or to the same target. WLM throttling overrides [Mailbox Replication Service (MRS) throttling](/exchange/troubleshoot/move-mailboxes/mailbox-migration-reached-maximum-number).

When a mailbox in the `CopyingMessages` state completes its move, the next stalled mailbox enters the `CopyingMessages` state. The throttling process continues until no stalled mailboxes remain.

Throttling can occur in any of the following scenarios:

- [On-premises moves](/exchange/architecture/mailbox-servers/manage-mailbox-moves), either local or cross-forest.

- [Remote moves](/exchange/hybrid-deployment/move-mailboxes) to or from Microsoft Exchange Online.

- Moves that you initiate in the Exchange admin center (EAC) for either Exchange Server or Exchange Online.

- Moves that you initiate by using the [New-MoveRequest](/powershell/module/exchange/new-moverequest) or [New-MigrationBatch](/powershell/module/exchange/new-migrationbatch) cmdlets.

> [!NOTE]
> The stalled status is typical and doesn't mean that your migration has a problem. The purpose of throttling during mailbox migration is to maintain the performance of higher priority Exchange Server workloads.

## Resolution

To increase the number of simultaneous mailbox moves, you can increase the WLM limit. We recommend that you don't set the WLM limit to a value that is greater than 100. Start by changing the WLM limit to 25, and then check Exchange Server performance during the migration. To further increase the number of simultaneous mailbox moves, successively increase the WLM limit by 10, and monitor Exchange Server performance at each step.

To initially set a WLM limit that is different from the default value, run the following commands (this example sets the WLM limit to 25):

```powershell
$limit = 25
New-SettingOverride -Name "MdbReplication" -Component WorkloadManagement -Section MdbReplication -Parameters @("MaxConcurrency=$limit") -Reason "Allow more simultaneous mailbox moves"
New-SettingOverride -Name "CiAgeOfLastNotification" -Component WorkloadManagement -Section MdbReplication -Parameters @("MaxConcurrency=$limit") -Reason "Allow more simultaneous mailbox moves"
New-SettingOverride -Name "MdbAvailability" -Component WorkloadManagement -Section MdbReplication -Parameters @("MaxConcurrency=$limit") -Reason "Allow more simultaneous mailbox moves"
New-SettingOverride -Name "DiskLatency" -Component WorkloadManagement -Section MdbReplication -Parameters @("MaxConcurrency=$limit") -Reason "Allow more simultaneous mailbox moves"
New-SettingOverride -Name "MdbDiskLatency" -Component WorkloadManagement -Section MdbReplication -Parameters @("MaxConcurrency=$limit") -Reason "Allow more simultaneous mailbox moves"
```

To further update the WLM limit, run the following commands (this example sets the WLM limit to 35):

```powershell
$limit = 35
Set-SettingOverride -Identity "MdbReplication" -Parameters @("MaxConcurrency=$limit")
Set-SettingOverride -Identity "CiAgeOfLastNotification" -Parameters @("MaxConcurrency=$limit")
Set-SettingOverride -Identity "MdbAvailability" -Parameters @("MaxConcurrency=$limit")
Set-SettingOverride -Identity "DiskLatency" -Parameters @("MaxConcurrency=$limit")
Set-SettingOverride -Identity "MdbDiskLatency" -Parameters @("MaxConcurrency=$limit")
```

## More information

- After you set a new WLM limit, you can verify it by running the following commands:

  ```powershell
  Get-SettingOverride -Identity "MdbReplication" | Select -ExpandProperty Parameters
  Get-SettingOverride -Identity "CiAgeOfLastNotification" | Select -ExpandProperty Parameters
  Get-SettingOverride -Identity "MdbAvailability" | Select -ExpandProperty Parameters
  Get-SettingOverride -Identity "DiskLatency" | Select -ExpandProperty Parameters
  Get-SettingOverride -Identity "MdbDiskLatency" | Select -ExpandProperty Parameters
  ```

- Use the [Get-MoveRequest](/powershell/module/exchange/get-moverequest) cmdlet to view the detailed status of an ongoing mailbox move that you initiated by using the [New-MoveRequest](/powershell/module/exchange/new-moverequest) cmdlet.

- Use the [Get-MigrationStatistics](/powershell/module/exchange/get-migrationstatistics) cmdlet to view the detailed status of an ongoing mailbox move that you initiated in the EAC or by using the [New-MigrationBatch](/powershell/module/exchange/new-migrationbatch) cmdlet.
