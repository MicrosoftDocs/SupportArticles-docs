---
title: Can't access or move a mailbox after mailbox server is added to a DAG
description: Describes mailbox access or move errors on a newly created database in DAG.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CI 156012
  - CSSTroubleshoot
ms.reviewer: dpaul, batre, meerak, v-chazhang
appliesto: 
  - Exchange Server 2019
search.appverid: MET150
ms.date: 01/24/2024
---

# "NoSupportException" error when accessing mailbox on newly created database in DAG

## Symptoms

After you add a Microsoft Exchange Server 2019 mailbox server as a node to a database availability group (DAG), and you create additional mailbox databases, you experience the following issues:

- When you try to access a mailbox on the mailbox server by using Outlook on the web, you receive the following error message:

    > A problem occurred while you were trying to use your mailbox.  
    > X-OWA-Error Microsoft.Exchange.Data.Storage.NoSupportException

- When you try to move a mailbox to a database on the mailbox server, you receive the following error message:

    > Failed to communicate with the mailbox database. There is no support for this operation.

## Cause

These issues occur because the schema version value of the mailbox database is incorrect. Before you create additional mailbox databases, the Information Store service must be restarted on every node after the node is added to the DAG. Otherwise, the cluster database isn't updated for the correct schema version.

## Workaround

After you add a node to the cluster, restart the Information Store service on the node.

If you have already created new databases in a cluster, check whether their schema version value is set to **121** before you restart the Information Store service on all nodes in the cluster. To check the database schema version for the mailbox database, run the following cmdlet:

```powershell
Get-MailboxDatabase DB01 -Status | fl *Schema*
```

You should get a result that resembles the following:

```output
IsExcludedFromProvisioningBySchemaVersionMonitoring: False
CreationSchemaVersion       : 0.121
CurrentSchemaVersion        : 0.121
RequestedSchemaVersion      : 0.121
```

If you have to update the schema version value, update the database schema, and then dismount and remount the database:

```powershell
Update-DatabaseSchema DB01
Dismount-Database DB01
Mount-Database DB01
```

If the `CurrentSchemaVersion` value still shows **121**, this means that not all the Information Store services across the whole cluster were restarted.
