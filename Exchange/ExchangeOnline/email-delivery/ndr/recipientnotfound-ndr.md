---
title: NDR error 550 5.1.10 RESOLVER.ADR.RecipientNotFound
description: Describes an NDR error that a Microsoft 365 user receives when they try to send email to on-premises Exchange users in a hybrid deployment. Provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 167832
ms.reviewer: neozhu, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# "550 5.1.10 RESOLVER.ADR.RecipientNotFound" when Microsoft 365 users send emails to on-premises users in a hybrid deployment

_Original KB number:_&nbsp;3197393

## Problem

A Microsoft 365 user is unable to send email messages to on-premises Exchange users in an Exchange hybrid deployment. The Microsoft 365 user receives the following nondelivery report (NDR):

> Your message to <User@contoso.com> couldn't be delivered.
>
> User wasn't found at <contoso.com>

The NDR contains the following error code:

> 550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup

## Cause

This problem occurs if the user was created in Microsoft 365. In this scenario, the on-premises Exchange environment has no object to reference for the user. Therefore, all queries for that SMTP address fail.

## Solution

To resolve this problem, create a remote mailbox in the on-premises environment and then wait for or force directory synchronization to occur. To do this, follow these steps:

1. Create an on-premises object for the cloud mailbox by using the New-RemoteMailbox cmdlet in the Exchange Management Shell.

    > [!NOTE]
    > This object must have the same name, alias, and user principal name (UPN) as the cloud mailbox. For more information, see [New-RemoteMailbox](/powershell/module/exchange/new-remotemailbox).

1. Set the ExchangeGuid property on the new on-premises object that you created in step 1 to match the cloud mailbox. To do this, follow these steps:
   1. Connect to Exchange Online by using a remote PowerShell.

        For more information, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

   1. Use the Get-Mailbox cmdlet to retrieve the value of the `ExchangeGuid` property of the cloud mailbox. For example, run the following command:

        ```powershell
        Get-Mailbox <MailboxName>| FL ExchangeGuid
        ```

        For more information, see [Get-Mailbox](/powershell/module/exchange/get-mailbox).

   1. Open the Exchange Management Shell on the on-premises Exchange server.
   1. Use the `Set-RemoteMailbox` cmdlet to set the value of the `ExchangeGuid` property on the on-premises object to the value that you retrieved in step 2b. For example, run the following command:

      ```powershell
      Set-RemoteMailbox <MailboxName> -ExchangeGuid <GUID>
      ```

      For more information, see [Set-RemoteMailbox](/powershell/module/exchange/set-remotemailbox).

1. Wait for directory synchronization to occur. Or, force directory synchronization.

    For more information, see [Synchronize your directories](/azure/active-directory/hybrid/whatis-hybrid-identity).

1. Make sure that the Microsoft 365 user object is displayed as **Synced with Active Directory**.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).