---
title: Proxy address is already being used error message in Exchange Online
description: Describes an issue in which a mailbox isn't created for a user in Exchange Online.
author: simonxjx
audience: ITPro
ms.service: exchange-online
ms.topic: troubleshooting
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.author: v-six
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
---
# (Proxy address  is already being used) error message in Exchange Online

## Problem

When you try to create a new user in Exchange Online or when you try to assign an Exchange Online license to an Office 365 user, you receive the following message:

> We are preparing the mailbox for this user.

However, the mailbox creation process doesn't complete successfully. If you try to access the properties of this user, you receive an error message that resembles the following:

> The proxy address "SMTP:\<user>@contoso.com" is already being used by "\<domain>.prod.outlook.com/Microsoft Exchange Hosted Organizations/contoso.onmicrosoft.com/\<forest>".
Choose another proxy address.

## Cause

An object that has the same proxy address already exists in Exchange Online.

## Solution

Check for objects have the same proxy address, and then remove or change the proxy address of the object that's in conflict.
To determine which objects share the proxy address of a specified user, follow these steps:

1. Connect to Exchange Online by using a remote Windows PowerShell session. For more information about how to do this, see [Connect to Exchange Online using remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Run the following command:

    ```powershell
    Get-EXORecipient | Where-Object {$_.EmailAddresses -match "user@contoso.onmicrosoft.com"} | Format-List Name, RecipientType, emailaddresses
    ```

    This command lists all mail recipients that have a type that matches the proxy address of a specified user. The duplicate proxy address may be associated with any of the following:
      - Site mailbox
      - Mail contact
      - Mail user
      - Mail-enabled distribution group
      - Group mailbox
      - Mail-enabled public folder

Only one proxy address at a time can be assigned to an object. After you determine which object is in conflict, you can remove or change the proxy address that's associated with that object.

## More information

For more information about primary addresses and proxy addresses, see [Add or remove email addresses for a mailbox](/exchange/recipients-in-exchange-online/manage-user-mailboxes/add-or-remove-email-addresses).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).