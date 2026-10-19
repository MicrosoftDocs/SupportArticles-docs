---
title: DelegateCollectionUpdateFailedException and "Failed to update delegateCollection" errors for Outlook delegates in Exchange Online
description: Fix DelegateCollectionUpdateFailedException errors in Outlook by resetting corrupt delegate permissions, restoring delegate access, and verifying calendar settings.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.reviewer: shanefe, v-kccross
ms.custom: 
  - sap:Calendaring\Calendar Permission
  - Exchange Online
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
  - Outlook on the web
  - Outlook for Windows
  - New Outlook for Windows
  - Outlook for Mac
ms.date: 10/07/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# Reset corrupt Outlook delegate permissions

## Summary

Reset corrupt Outlook delegate permissions to resolve `DelegateCollectionUpdateFailedException` and `Failed to update delegateCollection` errors that prevent users from adding, changing, or removing Outlook delegates. To resolve the errors, reset the mailbox owner's delegate collection, restore each delegate's calendar permissions, and verify the delegate access.

## Symptoms

- Outlook or Exchange Online PowerShell returns `DelegateCollectionUpdateFailedException` or `Failed to update delegateCollection`.
- Adding, changing, or removing a delegate fails for the mailbox owner's primary calendar.

## Cause

The delegate collection that stores a mailbox owner's delegates is corrupt. Outlook and Exchange Online PowerShell both use this collection when you add, change, or remove a delegate, so the same error occurs in both.

## Resolution

Use these steps when a user can't add, change, or remove an Outlook delegate because the mailbox delegate collection is corrupt.

1. Record the current calendar permissions. You must restore each delegate after the reset.

   ```powershell
   Get-MailboxFolderPermission -Identity owner@contoso.com:\Calendar
   ```

   For syntax and parameter details, see [Get-MailboxFolderPermission](/powershell/module/exchangepowershell/get-mailboxfolderpermission).

1. Reset the delegate collection on the mailbox owner's primary calendar.

   ```powershell
   Remove-MailboxFolderPermission -Identity owner@contoso.com:\Calendar -ResetDelegateUserCollection
   ```

   The reset removes corrupt delegate data and changes existing delegates to Editor permissions. For details, see [Remove-MailboxFolderPermission](/powershell/module/exchangepowershell/remove-mailboxfolderpermission#-resetdelegateusercollection).

1. Restore each delegate with [Set-MailboxFolderPermission](/powershell/module/exchangepowershell/set-mailboxfolderpermission). Add `CanViewPrivateItems` only for delegates who should see private calendar items.

   ```powershell
   Set-MailboxFolderPermission -Identity owner@contoso.com:\Calendar -User delegate@contoso.com -AccessRights Editor -SharingPermissionFlags Delegate
   ```

   ```powershell
   Set-MailboxFolderPermission -Identity owner@contoso.com:\Calendar -User delegate@contoso.com -AccessRights Editor -SharingPermissionFlags Delegate,CanViewPrivateItems
   ```

### Verify the resolution

Run `Get-MailboxFolderPermission` again. Confirm that each delegate has `Editor` access and that `SharingPermissionFlags` contains `Delegate`. Then have the mailbox owner add or remove a test delegate in Outlook.

## More information

- [Restore missing delegate meeting invitations](fix-delegate-invites.md)
