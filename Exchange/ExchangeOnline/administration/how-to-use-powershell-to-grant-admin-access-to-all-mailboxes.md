---
title: Use PowerShell to grant admin access to all mailboxes
description: Describes how to use Windows PowerShell to grant an admin access to all user mailboxes in Microsoft 365 through Outlook and Outlook Web App.
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
ms.date: 01/24/2024
---
# How to use Windows PowerShell to grant an admin access to all user mailboxes in Microsoft 365

_Original KB number:_ &nbsp; 2685435

## Summary

This article describes how to use Windows PowerShell to grant an admin access to all user mailboxes in a Microsoft 365 organization through Microsoft Outlook and Outlook Web App.

## Resolution

To grant an admin full access to all user mailboxes in Microsoft 365 through Outlook and Outlook Web App, follow these steps:

1. [Connect to Exchange Online by using remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Type the following command, and then press Enter:

    ```powershell
    Get-Mailbox -ResultSize unlimited -Filter {(RecipientTypeDetails -eq 'UserMailbox') -and (Alias -ne 'Admin')} | Add-MailboxPermission -User AdministratorAccount@contoso.com -AccessRights fullaccess -InheritanceType all
    ```

## References

For more information about Exchange Online PowerShell, see [Exchange Online PowerShell](/powershell/exchange/exchange-online-powershell).

For more information about the `Get-Mailbox` and `Add-MailboxPermission` Windows PowerShell cmdlets, see:

- [Get-Mailbox](/powershell/module/exchange/get-mailbox?view=exchange-ps&preserve-view=true)
- [Add-MailboxPermission](/powershell/module/exchange/add-mailboxpermission?view=exchange-ps&preserve-view=true)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
