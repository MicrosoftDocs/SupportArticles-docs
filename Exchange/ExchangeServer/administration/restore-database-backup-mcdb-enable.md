---
title: Can't restore a database from a backup if MCDB is enabled in Exchange Server 2019
description: When you try to restore a mailbox database with MCDB enabled to a recovery storage group, the database does not mount even though it shows a healthy shutdown state.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Need Help with Backup
  - Exchange Server
  - CI 111330
  - CSSTroubleshoot
ms.reviewer: jeffrem, robwhal, v-six
appliesto: 
  - Exchange Server 2019
search.appverid: 
  - MET150
ms.date: 01/24/2024
---

# Can't restore a database from a backup if MCDB is enabled in Exchange Server 2019

## Symptoms

Assume that you enable Metacache Database (MCDB) on Microsoft Exchange Server 2019 Mailbox servers. When you try to restore a mailbox database to a recovery storage group, the database does not mount even though it shows a healthy shutdown state.

## Cause

MCDB becomes linked to the primary database when the database is backed up. Because those links expire by the time that the database is restored, we must break those links to make the database mount.

## Resolution

To fix this issue, run ESEutil on the database by using the following commands:

```console
Eseutil /r E01 /d "E:\Databases\RDB1" /i
```

This example shows a log generation prefix of E01 and a recovery database path of `E:\Databases\RDB1`.

## More information

MCDB is a new feature in Exchange Server 2019 that enables solid state drives to cache the most frequently used data from a database. For more information, see [MetaCacheDatabase (MCDB) setup](/exchange/high-availability/database-availability-groups/metacachedatabase-setup).

For detailed steps about how to recover a database, see [Restore data using a recovery database](/exchange/restore-data-using-a-recovery-database-exchange-2013-help#use-the-shell-to-recover-data-using-a-recovery-database)
