---
title: Disable Exchange ActiveSync for users in Microsoft 365
description: Privides the steps to disable Exchange ActiveSync for Microsoft 365 users.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 08/20/2024
---
# Disable Exchange ActiveSync for users in Microsoft 365

_Original KB number:_ &nbsp; 2795303

Microsoft 365 admins can use one of the following methods to disable Exchange ActiveSync access for users:

- Exchange Online PowerShell
- Exchange admin center

## Disable Exchange ActiveSync by using Exchange Online PowerShell

Follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For more information about how to do this, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Do one of the following:

   - To disable ActiveSync connectivity for a single user, run the [Set-CasMailbox](/powershell/module/exchange/set-casmailbox) command:

        ```powershell
        Set-CASMailbox -Identity <Mailbox ID> -ActiveSyncEnabled $False
        ```

   - To disable ActiveSync connectivity for a group of users, use the [Get-User](/powershell/module/exchange/get-user) command.

        For example, to disable ActiveSync for all the users in the Sales department, run the following command:

        ```powershell
        Get-User -RecipientTypeDetailsUserMailbox | where {$_.Department -eq "Sales"} | Set-CASMailbox -ActiveSyncEnabled $False
        ```

   - To disable ActiveSync for all users in an organization, run the [Get-Mailbox](/powershell/module/exchange/get-mailbox) command:

        ```powershell
        Get-Mailbox | Set-CasMailbox -ActiveSyncEnabled $False
        ```

## Disable Exchange ActiveSync by using the Exchange admin center

Follow these steps:

1. Sign in to the [Exchange admin center](https://admin.exchange.microsoft.com/) as an Exchange admin.
1. In the left navigation pane, select **Recipients** > **Mailboxes**.
1. Select the user mailbox to open the flyout pane for the mailbox properties.
1. On the **General** tab, select **Manage email apps settings**.
1. In the **Manage settings for email apps** dialog, disable **Mobile (Exchange ActiveSync)** and then select **Save**.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
