---
title: Issues occur if the arbitration mailbox isn't on the upgraded Exchange Server
description: This article describes issues that might occur after you install a new version of Exchange Server. Issues occur if the arbitration mailbox isn't moved to the new server. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11524
ms.reviewer: anthonge, jmartin, excontent, v-six, v-kccross
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 06/03/2026
---

# Issues occur after Microsoft Exchange Server upgrade if the arbitration mailbox isn't moved to the new Exchange server

_Original KB number:_ &nbsp; 3108541

## Summary

After you upgrade to a newer version of Exchange Server, some mailbox-related features might not work as expected if arbitration mailboxes remain on an older server. This issue can prevent eDiscovery searches from working, cause mailbox move requests to stall or fail, and stop audit reports from being generated for new or moved mailboxes. To resolve the issue, move all arbitration mailboxes to a mailbox database on the latest Exchange Server in your environment.

## Symptoms

After you install a new version of Exchange Server, you experience one or more of the following issues:

- Microsoft Purview eDiscovery searches for new or moved mailboxes don't work.
- Mailbox moves stall or aren't completed successfully.
- Audit report messages aren't generated for new or moved mailboxes.

## Cause

This issue occurs if the arbitration mailbox that's used for the process is still hosted on an older version of Exchange Server.

## Resolution

To resolve this issue, move the arbitration mailbox to the latest version of Exchange Server in the deployment. To move the arbitration mailbox, follow these steps:

1. Use an account that has [sufficient permissions](/exchange/permissions/permissions) on your Exchange Server to open the [Exchange Management Shell (EMS)](/powershell/exchange/open-the-exchange-management-shell) or [connect to your Exchange server by using remote PowerShell](/powershell/exchange/connect-to-exchange-servers-using-remote-powershell).

1. Run the following [Get-Mailbox](/powershell/module/exchange/get-mailbox) cmdlet to locate the arbitration mailbox:

```powershell
Get-Mailbox -Arbitration
```

1. To move the mailbox, run the [New-MoveRequest](/powershell/module/exchange/new-moverequest) cmdlet as shown in the following example:

```powershell
Get-Mailbox -Arbitration | New-MoveRequest -TargetDatabase <name>
```
