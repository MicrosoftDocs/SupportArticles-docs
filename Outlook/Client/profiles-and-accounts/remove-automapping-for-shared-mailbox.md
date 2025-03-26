---
title: Remove automapping for a shared mailbox
description: Describes how to disable automapping for a shared mailbox in Outlook for Microsoft 365.
author: cloud-writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: gbratton
ms.custom: 
  - sap:Exchange Mailbox Accounts\Shared mailboxes
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook for Microsoft 365
ms.date: 03/25/2025
---

# How to remove automapping for a shared mailbox in Outlook for Microsoft 365

This article discusses how to remove automapping for shared mailboxes in Microsoft Outlook for Microsoft 365.

In Microsoft Outlook, Autodiscover automatically maps to any mailbox for which a user has full access permissions. Autodiscover automatically loads all mailboxes for which the user has full access permissions in the following scenarios:

- An admin grants full access permissions for a user to access another user's mailbox.
- The user has full access permissions to a shared mailbox.

If the user has full access permission to many mailboxes, automapping might cause performance issues when Outlook starts. For example, in some organizations, admins have full access to all user mailboxes in their organization. If this is the case, Outlook tries to open all mailboxes in the organization.

## Procedure

To disable automapping on a mailbox, use Exchange Online PowerShell to remove the user's full access permissions from the mailbox, and then add the user's full access permissions back to the mailbox, but with automapping disabled.

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. To remove the user's full access permission from the mailbox, run the following command:

    ```powershell
    Remove-MailboxPermission -Identity <MailboxIdentity> -User <UserIdentity> -AccessRights FullAccess
    ```

    - _MailboxIdentity_ is the name, alias, or email address of the mailbox where the permissions are being removed from.
    - _UserIdentity_ is the name, alias, or email address of the mailbox user who's losing the permissions on the mailbox.

   This example removes full access permissions from Kathleen Reiter's mailbox for the admin account.

   ```powershell
   Remove-MailboxPermission -Identity kathleenr@contoso.onmicrosoft.com -User admin@contoso.onmicrosoft.com -AccessRights FullAccess
   ```

   > [!NOTE]
   > After you run this command, you receive a confirmation prompt to continue. To prevent the confirmation prompt, add `-Confirm:$false` to the end of the command.

3. To grant full access permissions back to the user on the mailbox with automapping disabled, run the following command:

    ```powershell
    Add-MailboxPermission -Identity <MailboxIdentity> -User <UserIdentity> -AccessRights FullAccess -AutoMapping $false
    ```

    - _MailboxIdentity_ specifies the name, alias, or email address of the mailbox where the permissions are being added.
    - _UserIdentity_ specifies the name, alias, or email address of the mailbox user who's getting the permissions on the mailbox.

   This example adds the full access permissions to Kathleen Reiter's mailbox with automapping disabled for the admin account.

   ```powershell
   Add-MailboxPermission -Identity kathleenr@contoso.onmicrosoft.com -User admin@contoso.onmicrosoft.com -AccessRights FullAccess -AutoMapping $false
   ```

   After you run this command, the following output is displayed:

   ```output
   Identity          User                               AccessRights    IsInherited    Deny
   --------          ----                               -----------     -----------    ----
   KathleenR         <DCServer>\<AdminSAMAccountName>   {FullAccess}    False          False
   ```

4. Repeat the previous steps for every mailbox where the user has full access permission and you want to disable automapping for the mailbox.

For more information, see [Disable Outlook auto-mapping with full access mailboxes](/previous-versions/office/exchange-server-2010/hh529943(v=exchg.141)).
