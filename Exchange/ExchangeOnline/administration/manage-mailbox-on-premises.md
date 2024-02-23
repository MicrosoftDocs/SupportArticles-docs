---
title: Manage a mailbox in the on-premises environment
description: Describes how to manage a mailbox in the on-premises environment in a scenario in which a Microsoft 365 mailbox exists and directory synchronization is enabled but an on-premises mail-enabled user doesn't exist for the mailbox.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: desadan, jhayes, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Manage a mailbox when a Microsoft 365 mailbox exists but an on-premises mail-enabled user doesn't exist
  
_Original KB number:_ &nbsp; 2813304

## Introduction

This article describes how to manage a mailbox in the on-premises environment in the following scenario:

- A Microsoft 365 mailbox exists.
- Active Directory synchronization is enabled.
- An on-premises mail-enabled user doesn't exist for the mailbox.

## Procedure

To manage a mailbox in the on-premises environment in the scenario that's described in the "Introduction" section, follow these steps:

1. Use SMTP matching to match the Microsoft 365 user account with an on-premises user account. To do this, see [How to use SMTP matching to match on-premises user accounts to Microsoft 365 user accounts for directory synchronization](https://support.microsoft.com/help/2641663).

2. Convert the on-premises user account to a mail-enabled user. To do this, use Exchange Management Shell on the on-premises Microsoft Exchange server to run the following command:

    ```powershell
    Enable-MailUser -Identity User -ExternalEmailAddress <user>@<domain>.mail.onmicrosoft.com
    ```

3. Obtain the Exchange GUID of the Microsoft 365 mailbox. To do this, follow these steps:

   1. Connect to Microsoft Exchange Online by using remote PowerShell. For more information, go to [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

   2. Run the following command:

      ```powershell
      Get-Mailbox -Identity <UserAlias>
      ```

4. Update the on-premises mail-enabled user to use the Exchange GUID of the Microsoft 365 mailbox. To do this, use Exchange Management Shell to run the following command:

    ```powershell
    Set-MailUser -Identity <UserAlias> -ExchangeGuid <Office365MailboxGUID>
    ```

5. Move the mailbox from Microsoft 365 to the on-premises domain. You can do this by using the Exchange Management Console or the Exchange Management Shell.

    For example, use the Exchange Management Shell to run the following command:

    ```powershell
    New-MoveRequest -Identity <UserAlias> -OutBound -RemoteTargetDatabase <OnPremisesDatabase> -RemoteHostName <mail.domain.com> -RemoteCredential (get-credential) -TargetDeliveryDomain <domain.com>
    ```

    At the credential prompt, type the user name and password of the on-premises administrator to start the migration.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
