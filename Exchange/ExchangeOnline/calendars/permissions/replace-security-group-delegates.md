---
title: Security groups configured as calendar delegates don't work as expected in Exchange Online
description: Resolve inconsistent calendar delegate access when a security group is configured as the delegate instead of individual Exchange Online users.
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

# Replace security groups used as calendar delegates

## Summary

This article explains how to fix calendar delegate access issues that occur when a security group is set as a calendar delegate in Exchange Online. Permissions assigned to the group don't apply consistently to its members, or the group shows the `Delegate` flag without the expected delegate behavior. To resolve the issue, remove the security group and add each user individually with `Editor` access and the `Delegate` flag.

## Symptoms

Calendar access granted to a security group doesn't apply consistently to its members, or the group appears with the `Delegate` flag but members don't receive the expected delegate behavior.

## Cause

Setting a security group as a delegate isn't supported. Configure individual users instead.

## Resolution

1. Review the calendar permission list with [Get-MailboxFolderPermission](/powershell/module/exchangepowershell/get-mailboxfolderpermission):

   ```powershell
   Get-MailboxFolderPermission -Identity "owner@contoso.com:\Calendar"
   ```

1. Remove the group entry with [Remove-MailboxFolderPermission](/powershell/module/exchangepowershell/remove-mailboxfolderpermission):

   ```powershell
   Remove-MailboxFolderPermission -Identity "owner@contoso.com:\Calendar" -User "calendar-delegates@contoso.com" -Confirm:$false
   ```

1. Add each required user separately with [Add-MailboxFolderPermission](/powershell/module/exchangepowershell/add-mailboxfolderpermission):

   ```powershell
   Add-MailboxFolderPermission -Identity "owner@contoso.com:\Calendar" -User "delegate@contoso.com" -AccessRights Editor -SharingPermissionFlags Delegate
   ```

1. Repeat step 3 for each user who needs delegate access.

1. Run the command from step 1 again. Confirm that the group is absent and each delegate has `Editor` access with the `Delegate` flag.

For additional delegate design guidance, see [Best practices for organizations when using the Outlook calendar](https://support.microsoft.com/office/best-practices-for-organizations-when-using-the-outlook-calendar-d93f72d3-2361-4e0d-8d6a-5c4939c17f39).

## More information

- [SharingPermissionFlags is ignored for calendar delegates in Exchange Online](assign-editor-delegate-rights.md)
- [Reset corrupt Outlook delegate permissions](fix-corrupt-delegate-permissions.md)
