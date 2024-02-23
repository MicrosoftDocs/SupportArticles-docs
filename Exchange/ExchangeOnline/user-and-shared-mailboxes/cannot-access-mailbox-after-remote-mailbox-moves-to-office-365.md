---
title: Cannot access mailbox after remote mailbox moves to Microsoft 365
description: Resolves an issue that blocks a user from accessing their mailbox through Outlook after a remote mailbox move from an on-premises Exchange Server environment to Microsoft 365.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Exchange Online
- Outlook
- Exchange
search.appverid: MET150
ms.reviewer: jhayes, shawsull, benwinz, sulobr, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---
# Can't access a mailbox by using Outlook after a remote mailbox move from an on-premises Exchange Server environment to Microsoft 365

## Symptoms

After you move a user's mailbox from an on-premises Microsoft Exchange Server environment to Microsoft 365, the user can't access the mailbox by using Microsoft Outlook. However, the user can access the mailbox by using Outlook Web App.

In addition, you may see an error message in the Exchange Management Console that resembles the following after the failed remote mailbox move:

> \<Date> \<Time> [] \<Date> \<Time> [] Failed to convert the source mailbox 'Primary (00000000-0000-0000-0000-000000000000)' to mail-enabled user after the move. Attempt 6/6. Error: UpdateMovedMailboxPermanentException.

## Cause

This issue may occur if you disable the permission inheritance on the target user in the on-premises Active Directory schema.

Therefore, even though the user's on-premises mailbox is marked as being moved in Exchange Server, it's not converted to a remote user mailbox as expected. The user's on-premises mailbox continues to include a usual mailbox-enabled user.

## Resolution

To resolve this issue, follow these steps:

1. Identify all user properties on the mailbox, and then save this information to a text file. To do this, open the Exchange Management Shell, and then run the following command:

    ```ps
    Get-Mailbox <UserMailbox> | fl | Out-File C:\UserMailbox.txt
    ```

2. Disable the user's on-premises mailbox. To do this, use one of the following methods:
   - Use the Exchange Management Console to disable the user's on-premises mailbox.
   - Use Exchange Management Shell to disable the user's on-premises mailbox. To do this, run the following Exchange Management Shell command:

    ```ps
    Disable-Mailbox <UserMailbox>
    ```

   For more information about this cmdlet, see [Disable a mailbox](/previous-versions/office/exchange-server-2010/bb123730(v=exchg.141)).

3. Convert the user's on-premises mailbox to a remote user mailbox. To do this, run the following Exchange Management Shell cmdlet:

    ```ps
    Enable-RemoteMailbox -Identity <UserName> -RemoteRoutingAddress <UserName@domain.mail.onmicrosoft.com>
    ```

4. After the remote mailbox is provisioned, modify any custom mailbox attributes (for example, the `legacyExchangeDN` attribute) that you want and that weren't assigned by an email address policy to the user account.

## More information

> [!NOTE]
> In Microsoft Exchange 2010, a remote mailbox consists of a mail-enabled user who exists in the on-premises Active Directory and an associated mailbox that exists in the cloud-based service.

For more information about the cmdlets that are mentioned in this article, see:

- [Disable-Mailbox](/powershell/module/exchange/disable-mailbox)
- [Enable-RemoteMailbox](/powershell/module/exchange/enable-remotemailbox)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
