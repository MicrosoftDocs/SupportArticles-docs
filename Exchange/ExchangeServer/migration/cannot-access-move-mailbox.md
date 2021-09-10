---
title: Can't access or move a mailbox after mailbox server is added to a DAG
description: Describes mailbox access or move errors on newly created database in DAG.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Server
- CI 156012
- CSSTroubleshoot
ms.reviewer: dpaul; batre; meerak
appliesto:
- Exchange Server 2019
search.appverid: MET150
---

# "NoSupportException" error when accessing mailbox on newly created database in DAG

## Symptoms

After you add a Microsoft Exchange 2019 mailbox server as a node to a database availability group (DAG) and create additional mailbox databases, you experience the following issues:

- When you try to access a mailbox on the mailbox server with Outlook on the web, you receive the following error message:

    > A problem occurred while you were trying to use your mailbox.  
    > X-OWA-Error Microsoft.Exchange.Data.Storage.NoSupportException

- When you try to move a mailbox to a database on the mailbox server, you receive the following error message:

    > Failed to communicate with the mailbox database. There is no support for this operation.

## Cause

These issues occur because the value of the mailbox database's schema version is incorrect. If the Information Store service isn't restarted on every node after they're added to the DAG before creating additional mailbox databases, the cluster's database isn't updated for the correct schema version.

## Workaround

After you add the node to the cluster, restart the Information Store service on the node.

If you already have created new databases in a cluster, you need to check if their schema version value is set to 121 before restarting the Information Store service on all nodes in the cluster. You can run the following cmdlet to check the database's schema version for the mailbox database:

```powershell
Get-MailboxDatabase DB01 -Status | fl *Schema*
```

Then, you'll get a result that looks like the following:

```output
IsExcludedFromProvisioningBySchemaVersionMonitoring: False
CreationSchemaVersion       : 0.121
CurrentSchemaVersion        : 0.121
RequestedSchemaVersion      : 0.121
```

If you need to update the schema version value, update the database schema, dismount and mount the database again:

```powershell
Update-DatabaseSchema DB01
Dismount-Database DB01
Mount-Database DB01
```

If the `CurrentSchemaVersion` value still shows 121, all the Information Store services haven't been restarted in the entire cluster.
