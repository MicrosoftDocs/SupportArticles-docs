---
title: How to disable Exchange ActiveSync for users
description: Describes how to disable Exchange ActiveSync for users in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# How to disable Exchange ActiveSync for users in Microsoft 365

_Original KB number:_ &nbsp; 2795303

## Procedure

Microsoft 365 admins can use the following to disable Exchange ActiveSync access for users.

- Exchange Online PowerShell
- Exchange admin center

### Exchange Online PowerShell

To disable ActiveSync for users by using Exchange Online PowerShell, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For more information about how to do this, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Do one of the following:

   - To disable ActiveSync connectivity for a single user, run the following command:

        ```powershell
        Set-CASMailbox -Identity <Mailbox ID> -ActiveSyncEnabled $False
        ```

   - To disable ActiveSync connectivity for a group of users, use the `Get-User` cmdlet to change the scope of the command.

        For example, to disable ActiveSync for all the users in the Sales department, run the following command:

        ```powershell
        Get-User -RecipientTypeDetailsUserMailbox | where {$_.Department -eq "Sales"} | Set-CASMailbox -ActiveSyncEnabled $False
        ```

   - To disable ActiveSync for all users in an organization, run the following command:

        ```powershell
        Get-Mailbox | Set-CasMailbox -ActiveSyncEnabled $False
        ```

### Exchange admin center

To disable ActiveSync for users in Microsoft 365 by using the Exchange admin center, follow these steps:

1. Sign in to the [Microsoft 365 portal](https://portal.office.com/) as a global admin.
2. Select **Admin**, and then select **Exchange**.
3. In the left navigation pane, select **recipients**, and then select **mailboxes**.
4. Select the user mailbox that you want to change, and then select **Edit** (:::image type="icon" source="media/how-to-disable-exchange-activesync-for-users/edit-icon.png" border="false":::).
5. Select **mailbox features**, and then select **Disable Exchange ActiveSync**.

   :::image type="content" source="media/how-to-disable-exchange-activesync-for-users/mailbox-features.png" alt-text="Screenshot of the Mailbox Feature dialog box.":::

6. Select **OK**.

## References

For more information about the Windows PowerShell cmdlets that are mentioned in this article, go to the following Microsoft TechNet websites:

- [Get-User](/powershell/module/exchange/get-user)
- [Set-CasMailbox](/powershell/module/exchange/set-casmailbox)
- [Get-Mailbox](/powershell/module/exchange/get-mailbox)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
