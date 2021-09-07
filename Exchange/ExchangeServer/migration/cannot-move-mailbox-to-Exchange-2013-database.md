---
title: MapiExceptionCorruptData error when cross-forest move fails
description: Fixes an issue in which you can't initiate the cross-forest move from the target forest to an Exchange Server 2013 mailbox database.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom:
- CI 151458
- Exchange Server
- CSSTroubleshoot
ms.reviewer: meerak; batre; jcoiffin
appliesto: 
- Exchange Server 2013
- Exchange Server 2016
- Exchange Server 2019
search.appverid: MET150
---
# "MapiExceptionCorruptData" error when moving a mailbox to an Exchange Server 2013 mailbox database

## Symptoms

You're moving a mailbox from an organization that has Microsoft Exchange 2016 servers or Exchange 2019 servers to an Exchange Server 2013 database in another organization. When you use the `Remote` switch to initiate the cross-forest move from the target forest to move the mailbox to the database, the cross-forest move fails with the following error message:

> MapiExceptionCorruptData: Unable to write mailbox info.

:::image type="content" source="media/cannot-move-mailbox-to-Exchange-2013-database/MapiExceptionCorruptData-error-message.png" alt-text="Screenshot of the error message.":::

## Workaround

To avoid this issue, use the `Outbound` switch to initiate the move from the source forest.

```powershell
New-MoveRequest <mailbox name> -Outbound -RemoteHostName <MRS proxy endpoint> -RemoteCredential <credentials of the target forest> -TargetDeliveryDomain <target delivery domain> -RemoteTargetDatabase <name of the target database>
```
