---
title: Remote move migration doesn't finalize
description: Describes an issue in which a remote move migration doesn't finalize because of the replication lag of a second mailbox database copy.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Database Replication Issues
  - Exchange Server
  - CSSTroubleshoot
  - CI 166083
ms.reviewer: haembab, ninob, meerak, v-trisshores
appliesto: 
  - Exchange Server
search.appverid: MET150
ms.date: 01/24/2024
---
# Remote move migration doesn't finalize

## Symptoms

When you initiate a remote move migration by using the [Exchange admin center](/exchange/mailbox-migration/manage-migration-batches) (EAC) or the [New-MoveRequest](/powershell/module/exchange/new-moverequest) PowerShell cmdlet, the migration to the target mailbox database doesn't finish, and it returns the following error message:

> Cannot enter finalization because Data Guarantee is lagging behind by more than 00:05:00. Failure: Database GUID doesn't satisfy the constraint SecondCopy because the commit time 7/1/2022 2:35:10 PM isn't guaranteed by replication time 12/31/9999 11:59:59 PM

## Cause

The [DataMoveReplicationConstraint](/exchange/managing-mailbox-database-copies-exchange-2013-help#effect-of-mailbox-moves-on-continuous-replication) setting for the target mailbox database is set to **SecondCopy**. This is the default value if the system or administrator added a second mailbox database copy. The **SecondCopy** setting requires that at least one passive database copy meets the [Data Guarantee API](/exchange/managing-mailbox-database-copies-exchange-2013-help#check-replication-health) criteria for health, replay lag time, and copy queue length. The error message indicates that the migration didn't finalize because no passive database copy met the maximum replay lag time criteria.

## Resolution

Use the appropriate method, depending on the direction of the move request and whether the target mailbox is in a [database availability group](/exchange/high-availability/database-availability-groups/database-availability-groups) (DAG):

- For [offboarding](/exchange/hybrid-deployment/move-mailboxes#move-exchange-online-mailboxes-to-the-on-premises-organization), if the target mailbox is in a DAG, use one of the following methods:

  - Run the [Get-MailboxDatabaseCopyStatus](/powershell/module/exchange/get-mailboxdatabasecopystatus) PowerShell cmdlet to view the [health and status](/exchange/high-availability/manage-ha/monitor-dags) of the mailbox database copies. Diagnose and fix a mailbox database copy, then restart the migration.

  - Restart the remote move migration to a mailbox database that meets the Data Guarantee API criteria.

  - Set the **DataMoveReplicationConstraint** to **None** by running the following command in the on-premises [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell) (EMS):

     ```powershell
     Set-MailboxDatabase <target mailbox database GUID> -DataMoveReplicationConstraint None
     ```

- For offboarding, if the target mailbox is _not_ in a DAG, use the following method:

  - Set the **DataMoveReplicationConstraint** to **None** by running the following command in the on-premises EMS:

     ```powershell
     Set-MailboxDatabase <target mailbox database GUID> -DataMoveReplicationConstraint None
     ```

- For [onboarding](/exchange/hybrid-deployment/move-mailboxes#move-on-premises-mailboxes-to-exchange-online), use the following method:

  - Remove the move request, and then retry the migration. If the error reoccurs, contact Microsoft Support.
