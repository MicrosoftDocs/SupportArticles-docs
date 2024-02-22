---
title: Low disk space on database logs or drives
description: Check the database log or drive disk space and create warning alert when the disk is free space is < 20 MB or free space is < 10%.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: brianpr, v-six
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010
ms.date: 01/24/2024
---
# Low disk space on database logs or database drives

_Original KB number:_ &nbsp; 2619978

## Symptoms

In a Microsoft Exchange Server 2010 environment, a Mailbox database may exhibit the following behavior:

- Mail delivery to the database may be stopped.
- The database may become unmounted and cannot be mounted.
- Inability to move files to the same location as the database or log files associate with the database.
- Inability to move mailboxes to the database.

## Cause

Low disk space on database or database log volume.

## Resolution

If you encounter low disk space issues, you can perform the following actions to correct the issue:

- Delete content from mailboxes or public folders.
- Purge items from the Recoverable Items folder.
- Run database maintenance.
- Purge transaction logs.
- Change the database path to a hard disk drive that has more space.

For more information and related step by step instructions on this topic, see the Low Disk Space on Database Logs or Database Drives section in [Understanding the Exchange 2010 Store](/previous-versions/office/exchange-server-2010/bb331958(v=exchg.141)).
