---
title: Delegates not listed correctly after migration
description: Describes an issue in which delegates are duplicated in the Delegates dialog box after a migration to Microsoft 365 hybrid environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: kellybos, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Delegates are not listed correctly in Outlook after a migration to Microsoft 365 hybrid environment

_Original KB number:_ &nbsp; 4023846

## Symptoms

After a migration to Microsoft 365 hybrid environment, delegates or managers are moved to Exchange Online. However, the delegates are listed two times in the **Delegates** dialog box in Outlook.

:::image type="content" source="media/delegates-not-listed-correctly-in-outlook-after-migration/delegates-are-listed-two-times.png" alt-text="Screenshot of the Delegates dialog box that shows delegates are listed two times.":::

When you view the permissions, a value of **None** is listed in the **Delegate Permissions** dialog box.

:::image type="content" source="media/delegates-not-listed-correctly-in-outlook-after-migration/delegate-permissions-shows-none.png" alt-text="Screenshot of the Delegate Permissions dialog box showing None.":::

> [!NOTE]
> In some cases, the delegate is listed only one time, but the permissions are still listed as **None**.

However, when you view the calendar or other folder properties in Outlook, the appropriate permissions are listed.

:::image type="content" source="media/delegates-not-listed-correctly-in-outlook-after-migration/calendar-properties-page.png" alt-text="Screenshot of the calendar properties page.":::

Also, an administrator can view permissions in Exchange Remote PowerShell by using one of the following commands:

```powershell
Get-MailboxFolderPermission -Identity ManagerSMTP:\Calendar
```

```powershell
Get-MailboxFolderPermission -Identity ManagerSMTP:\Inbox
```

Delegates can still send on behalf of others as expected. This is true so long as they are listed in the **Delegate Permissions** dialog box. This can be verified by an administrator by running the following command from the Exchange Online environment:

```powershell
Get-MailUser -Identity ManagerSMTP | Format-Table GrantSendOnBehalfTo
```

Additionally, delegates report that they cannot see private items if they were previously granted this permission.

## Status

This issue is currently under investigation by Microsoft.

## Resolution

No action is required unless delegates require access to private items on the calendar. Delegates retain the access that was granted to their account before their account or their manager's account was migrated. If changes must be made before users have mailboxes in Exchange Online, the folder permissions can be managed from the folder properties. The permissions can also be reapplied in the **Delegate Permissions** dialog box.

> [!NOTE]
> If the delegate is listed two times in the **Delegate Permissions** dialog box, you do not have to remove the duplicate user unless the delegate has to be able to view the private items. If you make any change, you should take steps to reconfigure the delegate fully. To do this, you must re-add the folder level permissions in Outlook, and select the **Delegate can see my private items** check box.
