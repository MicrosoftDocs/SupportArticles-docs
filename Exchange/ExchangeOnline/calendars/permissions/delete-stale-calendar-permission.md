---
title: An unknown or deleted user remains on the calendar permission list in Exchange Online
description: Resolve calendar permission entries that remain visible as unknown users or can't be removed by using the standard Exchange Online PowerShell command.
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

# Can't remove stale calendar permissions in Exchange Online

## Summary

Resolves an issue in which a stale calendar permission remains after you try to remove it. Use Exchange Online PowerShell to identify the stale entry and remove it by using its exact user value. Use the `Force` switch if a warning or confirmation prevents the removal.

## Symptoms

Use this procedure when any of these symptoms occur:

- A calendar permission remains after you try to remove it.
- The permission has no SMTP address and appears as an unknown user.
- An add operation says that the user already has access, but a remove operation says that no permission entry exists.

## Cause

A calendar permission entry refers to a user that Exchange Online can no longer resolve, such as a deleted account. The entry appears as an unknown user without an SMTP address. Because it isn't linked to a resolvable recipient, the standard add and remove commands might not match it by the user's email address.

## Resolution

1. Review the current calendar permissions with [Get-MailboxFolderPermission](/powershell/module/exchangepowershell/get-mailboxfolderpermission):

   ```powershell
   Get-MailboxFolderPermission -Identity "owner@contoso.com:\Calendar"
   ```

1. Identify the stale entry from the command output. Use the exact value shown for the affected user in the next command.

1. Remove the entry with [Remove-MailboxFolderPermission](/powershell/module/exchangepowershell/remove-mailboxfolderpermission):

   ```powershell
   Remove-MailboxFolderPermission -Identity "owner@contoso.com:\Calendar" -User "stale-user" -Confirm:$false
   ```

1. If Exchange Online displays a warning or confirmation that prevents the removal, retry the command with the Exchange Online-only `Force` switch. The `Force` switch hides warning and confirmation messages. It doesn't select a different permission entry, so verify the `User` value before you run the removal.


   ```powershell
   Remove-MailboxFolderPermission -Identity "owner@contoso.com:\Calendar" -User "stale-user" -Force -Confirm:$false
   ```

1. Run the command from step 1 again. Confirm that the stale entry no longer appears.

## More information

- [Fix corrupt calendar permission entries](fix-corrupt-calendar-permissions.md)
- [Reset corrupt Outlook delegate permissions](fix-corrupt-delegate-permissions.md)
