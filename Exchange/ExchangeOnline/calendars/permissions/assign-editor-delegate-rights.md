---
title: SharingPermissionFlags is ignored for calendar delegates in Exchange Online
description: Learn how to fix calendar delegates when `SharingPermissionFlags` is ignored in Exchange Online. Assign Editor access rights to apply Delegate flags.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: shanefe, v-kccross
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring\Calendar Permission
  - Exchange Online
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 10/07/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# SharingPermissionFlags is ignored for calendar delegates in Exchange Online

## Summary

Resolves an issue in which `SharingPermissionFlags` is ignored for a calendar delegate. To fix the issue, set the delegate's access rights to `Editor` when you use the `Delegate` or `CanViewPrivateItems` sharing permission flags.

## Symptoms

An Exchange Online PowerShell command succeeds, but the calendar permission shows `SharingPermissionFlags` as `None`. The affected user isn't treated as a delegate.

## Cause

This issue occurs when you combine `SharingPermissionFlags` with calendar access rights other than `Editor`.

## Resolution

1. Review the current permission with [Get-MailboxFolderPermission](/powershell/module/exchangepowershell/get-mailboxfolderpermission):

   ```powershell
   Get-MailboxFolderPermission -Identity "owner@contoso.com:\Calendar" -User "delegate@contoso.com"
   ```

1. Update the existing permission with [Set-MailboxFolderPermission](/powershell/module/exchangepowershell/set-mailboxfolderpermission). Pair the `Delegate` flag with `Editor` access:

   ```powershell
   Set-MailboxFolderPermission -Identity "owner@contoso.com:\Calendar" -User "delegate@contoso.com" -AccessRights Editor -SharingPermissionFlags Delegate
   ```

1. If the delegate also needs access to private calendar items, include both flags:

   ```powershell
   Set-MailboxFolderPermission -Identity "owner@contoso.com:\Calendar" -User "delegate@contoso.com" -AccessRights Editor -SharingPermissionFlags Delegate,CanViewPrivateItems
   ```

1. Run the command from step 1 again. Confirm that `AccessRights` is `Editor` and that `SharingPermissionFlags` contains the intended value.

If the user must have access rights other than `Editor`, don't assign delegate flags to that permission.

## More information

- [Replace security groups used as calendar delegates](replace-security-group-delegates.md)
- [Reset corrupt Outlook delegate permissions](fix-corrupt-delegate-permissions.md)
