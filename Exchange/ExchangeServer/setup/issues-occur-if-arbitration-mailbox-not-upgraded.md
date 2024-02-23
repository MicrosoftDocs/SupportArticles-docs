---
title: Issues occur if arbitration mailbox isn't upgraded
description: Describes the issues that may occur after you install a new version of Exchange Server. Occurs if the arbitration mailbox is not moved to new server. A resolution is provided.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: anthonge, jmartin, excontent, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
search.appverid: MET150
---
# Issues after Exchange Server upgrade if the arbitration mailbox isn't upgraded to the new Exchange server

_Original KB number:_ &nbsp; 3108541

## Symptoms

After you install a new version of Exchange Server, you experience one or more of the following issues:

- eDiscovery searches for new or moved mailboxes do not work.
- Mailbox moves stall or are not completed successfully.
- Audit report messages are not generated for new or moved mailboxes.
- Daily Skype for Business call logs for new or moved mailboxes are blank.

## Cause

This issue occurs if the arbitration mailbox that's used for the process is still hosted on an older version of Exchange Server.

## Resolution

To resolve this issue, move the arbitration mailbox to the latest version of Exchange Server in the environment.

To do this, first run the following [Get-Mailbox](/powershell/module/exchange/get-mailbox) cmdlet to locate the arbitration mailbox:

```powershell
Get-Mailbox -Arbitration
```

Run the following [New-MoveRequest](/powershell/module/exchange/new-moverequest) cmdlet to move the mailbox:

```powershell
Get-Mailbox -Arbitration | New-MoveRequest -TargetDatabase <name>
```
