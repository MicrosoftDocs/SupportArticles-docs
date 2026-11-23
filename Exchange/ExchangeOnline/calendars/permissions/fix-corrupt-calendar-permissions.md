---
title: CorruptDataException and security-principal-already-present errors when you change calendar permissions in Exchange Online
description: Resolve CorruptDataException and security-principal-already-present errors caused by a stale or inconsistent Exchange Online calendar permission entry.
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
ms.date: 10/07/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# Fix corrupt calendar permission entries

## Summary

Resolves `CorruptDataException` and `security-principal-already-present` errors that occur because of a stale or inconsistent calendar permission entry. Remove and re-create the affected permission with the access rights that you want.

## Symptoms

Use this procedure when calendar permission changes fail and you see one or more of these symptoms:

- `Microsoft.Exchange.Data.StoreObjects.CorruptDataException`.
- "The security principal specified is already on the permission set."
- Outlook reports that it can't display some permissions.
- Outlook on the web reports that it can't send the sharing invitation.

## Cause

These symptoms occur when the Calendar folder contains a stale or inconsistent permission entry.

## Resolution

1. Review the current permission entries with [Get-MailboxFolderPermission](/powershell/module/exchangepowershell/get-mailboxfolderpermission).

   ```powershell
   Get-MailboxFolderPermission -Identity "owner@contoso.com:\Calendar"
   ```

1. Record the access rights and delegate flags for the affected user before you change the entry.

1. Remove the affected entry with [Remove-MailboxFolderPermission](/powershell/module/exchangepowershell/remove-mailboxfolderpermission).

   ```powershell
   Remove-MailboxFolderPermission -Identity "owner@contoso.com:\Calendar" -User "affected-user@contoso.com" -Force -Confirm:$false
   ```

1. Run the command from step 1 again. Confirm that the affected entry is absent before you add it again.

1. Re-create the permission with [Add-MailboxFolderPermission](/powershell/module/exchangepowershell/add-mailboxfolderpermission). The following example restores nondelegate Editor access:

   ```powershell
   Add-MailboxFolderPermission -Identity "owner@contoso.com:\Calendar" -User "affected-user@contoso.com" -AccessRights Editor
   ```

1. Run the command from step 1 again. Confirm that the user appears once and has the intended access rights.

If the failure specifically affects delegate add, change, or removal operations, use the delegate-data reset procedure instead of repeatedly re-creating one permission.

## More information

- [Remove stale calendar permissions](delete-stale-calendar-permission.md)
- [Reset corrupt Outlook delegate permissions](fix-corrupt-delegate-permissions.md)
- [Set Editor rights for calendar delegates](assign-editor-delegate-rights.md)
