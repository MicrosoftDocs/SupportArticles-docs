---
title: Delegates open Outlook calendar but can't view private item details in Exchange Online
description: Fix private calendar items that a delegate can't open by granting the required delegate flag and verifying the mailbox owner's calendar permissions.
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

# Restore delegate access to private calendar items

## Summary

Resolves an issue in which an Outlook delegate can open the mailbox owner's calendar but can't view the subject or details of private calendar items. Grant the delegate `Editor` access with the `Delegate` and `CanViewPrivateItems` sharing permission flags.

## Symptoms

- A delegate can open the mailbox owner's calendar but can't open a private appointment.
- The delegate sees the private item's time but not its subject or details.
- Private-item visibility differs between Outlook clients.

## Cause

By default, delegates can't view private items. Grant private-item access only when the mailbox owner approves it.

## Resolution

If the delegate already has calendar permission, grant `Editor` access with both the `Delegate` and `CanViewPrivateItems` flags by using [Set-MailboxFolderPermission](/powershell/module/exchangepowershell/set-mailboxfolderpermission).

```powershell
Set-MailboxFolderPermission -Identity owner@contoso.com:\Calendar -User delegate@contoso.com -AccessRights Editor -SharingPermissionFlags Delegate,CanViewPrivateItems
```

If the delegate doesn't have an existing permission entry, use [Add-MailboxFolderPermission](/powershell/module/exchangepowershell/add-mailboxfolderpermission) with the same access rights and sharing flags.

If the target is a shared mailbox, follow the supported access configuration in [Private items aren't displayed in a shared mailbox in Outlook](/troubleshoot/exchange/user-and-shared-mailboxes/private-items-not-display).

### Verify the resolution

Have the mailbox owner create a test appointment and mark it private. Confirm that the delegate can open it and view its details. Also confirm that users without `CanViewPrivateItems` can't view those details.

## More information

- [Reset corrupt Outlook delegate permissions](fix-corrupt-delegate-permissions.md)
- [Resolve Full Access and delegate conflicts](fix-full-access-delegate-conflicts.md)
