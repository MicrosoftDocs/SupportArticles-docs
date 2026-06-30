---
title: Cannot set folder security descriptor with non-canonical ACL error when you move a mailbox in Exchange Server
description: Resolves an issue in which you receive cannot set folder security descriptor with non-canonical ACL error message. This issue might occur when you move mailboxes in Exchange Server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration\Issues with Move Mailbox within same organization
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11525
ms.reviewer: batre, v-six, v-kccross
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 05/27/2026
---

# Cannot set folder security descriptor with non-canonical ACL error when you move a mailbox in Exchange Server 

_Original KB number:_ &nbsp;2764844

## Summary

This article describes an issue where a mailbox move fails with a non-canonical ACL error. The issue occurs because the mailbox contains a corrupted access control list (ACL). To resolve the problem, identify the corrupted ACL by using move request statistics and remove it by using the ExFolders tool. As a workaround, you can skip moving folder ACLs during the move request, but doing so resets folder permissions to their defaults after the move.

## Symptoms

When you try to move a mailbox in Exchange Server, you receive the following error message:

> Error: Cannot set folder security descriptor with non-canonical ACL.

## Cause

This issue occurs because the mailbox has a corrupted access control list (ACL).

## Resolution

To resolve this issue, follow these steps:

1. Using an account that has [sufficient permissions](/exchange/permissions/permissions) on your Exchange Server, open the [Exchange Management Shell (EMS)](/powershell/exchange/open-the-exchange-management-shell) or [connect to your Exchange server by using remote PowerShell](/powershell/exchange/connect-to-exchange-servers-using-remote-powershell).

1. To identify the ACL that causes this issue, run the [Get-MoveRequestStatistics](/powershell/module/exchange/get-moverequeststatistics) PowerShell cmdlet as shown in the following example:

    ```powershell
    $mr = get-moverequeststatistics -IncludeReport <mailboxIdentity>  

    $mr.Report.Failures
    ```

   Look for entries under `Failures` that mention ACL issues.

1. Manually remove problematic permissions from the mailbox with PowerShell by using the following command:

   ```powershell
   Get-MailboxFolderStatistics <mailboxIdentity> | ForEach-Object {
    $folder = $_.FolderPath
    $identity = "$($_.SourceDatabase):$folder"
    Remove-MailboxFolderPermission -Identity $identity -User <SID-or-User> -Confirm:$false
   }```

   Replace `mailboxIdentity` with the mailbox name and `SID-or-User` with the user’s SID or UPN.

## Workaround

To work around this issue, run the [New-MoveRequest](/powershell/module/exchange/new-moverequest) cmdlet together with the `-SkipMoving:FolderACls` switch as shown in the following example:

```powershell
New-moverequest -Identity <username> -Target Database "database name" -SkipMoving:FolderACls
```

> [!NOTE]
> When you move the mailbox by using the `-SkipMoving:FolderACls` switch, Exchange Server doesn't move the ACLs of the folders in the mailbox. Therefore, after you move the mailbox, all the folders have default permissions.
