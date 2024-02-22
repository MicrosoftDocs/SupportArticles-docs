---
title: MapiExceptionCorruptData error when cross-forest move fails
description: Fixes an issue in which you can't initiate the cross-forest move from the target forest to an Exchange Server 2013 mailbox database.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 151458
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: meerak, batre, jcoiffin, v-chazhang
appliesto: 
  - Exchange Server 2013
  - Exchange Server 2016
  - Exchange Server 2019
search.appverid: MET150
ms.date: 01/24/2024
---
# "MapiExceptionCorruptData" error when moving a mailbox to an Exchange Server 2013 database

## Symptoms

You're moving a mailbox from an organization that has Microsoft Exchange Server 2016-based servers or Exchange Server 2019-based servers to an Exchange Server 2013 database in another organization. When you use the `Remote` switch to initiate the cross-forest move of the mailbox from the target forest to the database, the move fails and generates the following error message:

> MapiExceptionCorruptData: Unable to write mailbox info.

:::image type="content" source="media/cannot-move-mailbox-to-Exchange-2013-database/MapiExceptionCorruptData-error-message.png" alt-text="Screenshot of the error message when you move the mailbox from the target forest to the database.":::

## Workaround

To avoid this issue, use the `Outbound` switch to initiate the move from the source forest.

```powershell
New-MoveRequest <mailbox name> -Outbound -RemoteHostName <MRS proxy endpoint> -RemoteCredential <credentials of the target forest> -TargetDeliveryDomain <target delivery domain> -RemoteTargetDatabase <name of the target database>
```
