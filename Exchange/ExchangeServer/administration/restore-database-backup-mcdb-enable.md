---
title: Can't restore a database from a backup if MCDB is enabled in Exchange Server 2019
description: When you try to restore a mailbox database with MetaCacheDatabase (MCDB) enabled to a recovery storage group, the database doesn't mount even if it shows a healthy shutdown state.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Need Help with Backup
  - Exchange Server
  - CI 111330
  - CI 9823
  - CI 12258
  - CSSTroubleshoot
ms.reviewer: jeffrem, robwhal, v-six, v-kccross
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
search.appverid: MET150
ms.date: 06/29/2026
---

# Can't restore a database from a backup if MCDB is enabled in Exchange Server

## Summary

Exchange Server can’t mount a restored mailbox database when MetaCacheDatabase (MCDB) is enabled because the backup preserves links between the MCDB and the primary database. After restoration, those links become invalid, which prevents the database from mounting even if it’s in a clean shutdown state. You must remove the stale MCDB linkage by using ESEutil to perform recovery on the database before it can mount successfully.

## Symptoms

Assume that you enable MetaCacheDatabase (MCDB) on Microsoft Exchange Server SE or Exchange Server 2019 Mailbox servers. When you try to restore a mailbox database to a recovery storage group, the database does not mount even if it shows a healthy shutdown state.

## Cause

MCDB becomes linked to the primary database when the database is backed up. Because those links expire by the time that the database is restored, we must break those links to make the database mount.

## Resolution

To fix this issue, run ESEutil on the database by using the following commands:

```console
Eseutil /r E01 /d "E:\Databases\RDB1" /i
```

This example shows a log generation prefix of E01 and a recovery database path of `E:\Databases\RDB1`.

## More information

MCDB enables solid state drives to cache the most frequently used data from a database. For more information, see [MetaCacheDatabase (MCDB) setup](/exchange/high-availability/database-availability-groups/metacachedatabase-setup).

For detailed steps about how to recover a database, see [Restore data using a recovery database](/exchange/restore-data-using-a-recovery-database-exchange-2013-help#use-the-shell-to-recover-data-using-a-recovery-database)
