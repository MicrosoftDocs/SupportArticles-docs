---
title: User isn't found when using @mentions
description: Fixes an issue in which user information doesn't resolve when you @mention a user.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Sharing\Collab
  - CI 149605
  - CSSTroubleshoot
ms.reviewer: remcgurk
appliesto: 
  - Word for Microsoft 365
  - Word for Microsoft 365 for Mac 
  - Word for the web
  - PowerPoint for Microsoft 365 for Mac
  - PowerPoint for Microsoft 365
  - PowerPoint for the web
  - Excel for Microsoft 365 for Mac 
  - Excel for Microsoft 365
  - Excel for the web
  - Outlook for Microsoft 365
  - Outlook for Microsoft 365 for Mac
  - Outlook on the web
search.appverid: 
  - MET150
ms.date: 05/26/2025
---
# User information in @mentions doesn't resolve

## Symptoms

In Microsoft Word, Excel, PowerPoint, and Outlook, if you mention a user by using the @ sign followed by the user's name or email alias, the user doesn't resolve.

## Cause

This issue occurs if the user is hidden from the global address list (GAL) in Microsoft Exchange Server or Exchange Online.

## Resolution

To resolve this issue, use one of the methods, as appropriate for your situation.

**Note:** The following steps must be done by an administrator.

### Method 1: Mailboxes are in Exchange Online in a non-hybrid configuration

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Check the `HiddenFromAddressListsEnabled` property by running the following cmdlet:

    ```powershell
    $User = Get-Mailbox -Identity john@contoso.com
    $User.HiddenFromAddressListsEnabled
    ```

3. Set the property value to **False** by running the following cmdlet:

    ```powershell
    Set-Mailbox -Identity john@contoso.com -HiddenFromAddressListsEnabled $false
    ```

### Method 2: Mailboxes are in Exchange Online in a hybrid configuration

1. [Open the Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Check the `HiddenFromAddressListsEnabled` property by running the following cmdlet:

    ```powershell
    $User = Get-RemoteMailbox -Identity john@contoso.com
    $User.HiddenFromAddressListsEnabled
    ```

3. Set the property value to **False** by running the following cmdlet:

    ```powershell
    Set-RemoteMailbox -Identity john@contoso.com -HiddenFromAddressListsEnabled $false
    ```

### Method 3: Mailboxes are in Exchange Server in a hybrid configuration

1. [Open the Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Check the `HiddenFromAddressListsEnabled` property by running the following cmdlet:

    ```powershell
    $User = Get-Mailbox -Identity john@contoso.com
    $User.HiddenFromAddressListsEnabled
    ```

3. Set the property value to **False** by running the following cmdlet:

    ```powershell
    Set-Mailbox -Identity john@contoso.com -HiddenFromAddressListsEnabled $false
    ```

## Related articles

- [Use Exchange Online PowerShell to hide recipients from address lists](/exchange/address-books/address-lists/manage-address-lists#use-exchange-online-powershell-to-hide-recipients-from-address-lists)
- [Use the Exchange Management Shell to hide recipients from address lists](/Exchange/email-addresses-and-address-books/address-lists/address-list-procedures#use-the-exchange-management-shell-to-hide-recipients-from-address-lists)
- [Use @mentions to get someone's attention](https://support.microsoft.com/office/use-mentions-to-get-someone-s-attention-90701709-5dc1-41c7-aa48-b01d4a46e8c7)
