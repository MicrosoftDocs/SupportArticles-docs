---
title: Server name doesn't update after moved to a new region
description: After a mailbox is moved to a new region, the server name doesn't update when you view the mailbox properties. This is by design.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: kerbo, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Server name doesn't update after a mailbox is moved to a new region in Microsoft 365

_Original KB number:_ &nbsp; 4073426

## Symptoms

After a mailbox is moved to a new region in Microsoft 365, the server name doesn't update when you view the mailbox properties by using Remote PowerShell.

## Cause

This behavior is by design.

## Workaround

The database name is updated immediately after the mailbox is moved. Therefore, you can use the database name to verify that the mailbox was successfully moved to a different region.

## References

For a more detailed explanation of this behavior, see the following Microsoft 250 Hello Blog article:

[Exchange ServerName Points To Wrong Or Decommissioned Server](https://blogs.technet.microsoft.com/rmilne/2014/12/04/exchange-servername-points-to-wrong-or-decommissioned-server/)
