---
title: Error when you try to enable or disable an archive mailbox for an Exchange Online user or move a mailbox to an on-premises environment
description: Describes that you receive an error message when you try to enable or disable an archive mailbox for an existing Exchange Online user or move a mailbox from Exchange Online to an on-premises environment.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Archiving
  - CSSTroubleshoot
  - 'Associated content asset: 4555318'
ms.reviewer: bradhugh
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 06/25/2024
---

# Error when you try to enable or disable an archive mailbox for an Exchange Online user or move a mailbox to an on-premises environment

_Original KB number:_&nbsp;3050691

## Problem

When you try to enable or disable an archive mailbox for an existing Exchange Online user, or when you try to move a mailbox from Exchange Online to an on-premises environment, you receive an error message that resembles one of the following:

> Error: UserAlreadyBeingMigratedException: The user '\<User Email Address>' already has a pending request. Please remove the existing request and resume the current batch or start a new batch for this user.
>
> Mailbox '\<User Display Name>' has a completed move request associated with it. Before you create a new move request for the mailbox, run the Remove-MoveRequest cmdlet to clear the completed move request.
>
> Mailbox '\<User Display Name>' has move status \<move status>. You can't enable or disable an archive while the mailbox is being moved.

When you run the `Get-MoveRequest | fl` command to examine the move request, you verify that the request is a Microsoft 365 datacenter move request. This is indicated by the IntraOrg flag.

## Cause

This problem occurs because failed move requests are not yet removed from the system.

To maintain service health, Exchange Online regularly moves mailboxes between different servers. Completed Microsoft 365 datacenter move requests are cleaned up very quickly. Failed Microsoft 365 datacenter move requests may remain somewhat longer but are still cleaned up after some time. These failed move requests do not affect users. The service will retry the move in the future, if it's required.

## Solution

Generally, if an internal datacenter move doesn't affect your ability to perform administrative tasks, you can safely ignore the error messages.

If management tasks are affected by the move requests, follow these steps:

1. Connect to Exchange Online by using remote Windows PowerShell. For more information, see [Connect to Exchange Online using remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
1. Verify that the mailbox is being moved. To do this, run the following command:

    ```powershell
    Get-MoveRequest | fl Status, Protect, "Display Name", Identity
    ```

   If the "Display Name" placeholder matches the mailbox for which you want to enable or disable archiving, a mailbox move is in progress. The move is preventing the change from being made.
1. Examine the output, and then do one of the following, as appropriate:
   - If the Status is **Queued** or **InProgress**, wait for the move to finish. This should occur in one or two days. If you can't wait that long, remove the move request by running the following command:

        ```powershell
        Remove-MoveRequest -Identity IdentityOfFailedRequest
        ```

   - If the Status is **Failed**, remove the move request by running the following command:

        ```powershell
        Remove-MoveRequest -Identity IdentityOfFailedRequest
        ```

This operation should not affect user access or cause any problems. Additionally, you don't have to notify Microsoft or the mailbox owner that you're taking this action.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
