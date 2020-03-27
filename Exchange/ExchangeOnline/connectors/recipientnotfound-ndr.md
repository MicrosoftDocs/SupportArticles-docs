---
title: 550 5.1.10 RESOLVER.ADR.RecipientNotFound in Office 365.
description: Describes an NDR error that an Office 365 user receives when they try to send email to on-premises Exchange users in a hybrid deployment. Provides a solution.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: Office 365
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: neozhu
appliesto: 
- Exchange Online
search.appverid: MET150
---

# "550 5.1.10 RESOLVER.ADR.RecipientNotFound" NDR error when an Office 365 user tries to send mail to on-premises users in a hybrid deployment

_Original KB number:_&nbsp;3197393

## Problem

An Office 365 user is unable to send email messages to on-premises Exchange users in an Exchange hybrid deployment. The Office 365 user receives the following nondelivery report (NDR):

> Your message to <User@contoso.com> couldn't be delivered.
>
> User wasn't found at <contoso.com>

The NDR contains the following error code:

> 550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup

## Cause

This problem occurs if the user was created in Office 365. In this scenario, the on-premises Exchange environment has no object to reference for the user. Therefore, all queries for that SMTP address fail.

## Solution

To resolve this problem, create a remote mailbox in the on-premises environment and then wait for or force directory synchronization to occur. To do this, follow these steps:

1. Create an on-premises object for the cloud mailbox by using the New-RemoteMailbox cmdlet in the Exchange Management Shell.

    > [!NOTE]
    > This object must have the same name, alias, and user principal name (UPN) as the cloud mailbox. For more information, see [New-RemoteMailbox](https://technet.microsoft.com/library/ff607480%28v=exchg.160%29.aspx).

1. Set the ExchangeGuid property on the new on-premises object that you created in step 1 to match the cloud mailbox. To do this, follow these steps:
   1. Connect to Exchange Online by using a remote PowerShell.

        For more information, see [Connect to Exchange Online PowerShell](https://technet.microsoft.com/library/jj984289%28v=exchg.160%29.aspx).

   1. Use the Get-Mailbox cmdlet to retrieve the value of the ExchangeGuid property of the cloud mailbox. For example, run the following command:

        `Get-Mailbox <MailboxName>| FL ExchangeGuid`

        For more information, see [Get-Mailbox](https://technet.microsoft.com/library/bb123685%28v=exchg.160%29.aspx).

   1. Open the Exchange Management Shell on the on-premises Exchange server.
   1. Use the Set-RemoteMailbox cmdlet to set the value of the ExchangeGuid property on the on-premises object to the value that you retrieved in step 2b. For example, run the following command:

    `Set-RemoteMailbox <MailboxName> -ExchangeGuid <GUID>`

    For more information, see [Set-RemoteMailbox](https://technet.microsoft.com/library/ff607302%28v=exchg.160%29.aspx).

1. Wait for directory synchronization to occur. Or, force directory synchronization.

    For more information, see [Synchronize your directories](https://technet.microsoft.com/library/jj151771.aspx).

1. Make sure that the Office 365 user object is displayed as "Synced with Active Directory."

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
