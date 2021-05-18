---
title: No soft-deleted mailbox after license removal
description: Describes an issue that prevents a user from restoring a deleted mailbox in Microsoft 365. A resolution is provided.
author: Norman-sun
ms.author: v-swei
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: benjak, kellybos
appliesto:
- Exchange Online
search.appverid: MET150
---
# No soft-deleted mailbox after license removal in Microsoft 365

_Original KB number:_ &nbsp; 3158794

## Symptoms

When you try to perform a mailbox-restore operation to recover the contents of a deleted mailbox in Microsoft 365, you can't find a soft-deleted mailbox for the account that was deprovisioned.

## Cause

Currently, removing the license leaves the mailbox in a hard-deleted state. Therefore, the mailbox is not displayed as either **Soft Deleted** or **Inactive**. The following command is specific to removing the license in PowerShell:

```powershell
Set-MSOLUserLicense -UserPrincipalName "<Account>" -RemoveLicenses
```

This may leave the mailbox in a disabled state that prevents it from being displayed as either **Soft Deleted** or **Inactive**. In this situation, the following commands won't find the mailbox:

```powershell
Get-Mailbox <Account> -SoftDeletedMailbox
Get-Mailbox <Account> -IncludeInactive
```

## Resolution

When the license is removed from a mailbox without following other deprovisioning steps, this may leave the mailbox in a hard-deleted state. In order to recover the mailbox, the user must relicense the Azure user object. That will reconnect the mailbox as long as it's within 30 days from the disconnect date.

:::image type="content" source="media/no-soft-deleted-mailbox-after-license-removal/assign-license-page.png" alt-text="A screenshot of the Assign License page" border="false":::

If the on-premises account no longer exists and is not listed in the **Active Users** section of the Microsoft 365 admin center, and the account was deleted less than 30 days earlier, follow these steps:

1. Sign in to the Microsoft 365 admin center.
2. Locate **Users** > **Deleted Users**.

   :::image type="content" source="media/no-soft-deleted-mailbox-after-license-removal/deleted-users-field.png" alt-text="A screenshot of the Deleted Users field":::

3. Search for the user, and then select the account object.
4. Select the **Restore** option.

    > [!NOTE]
    > The user becomes an active user. The **Sync Type** is now listed as **In cloud** instead of **Synced with Active Directory**.

    :::image type="content" source="media/no-soft-deleted-mailbox-after-license-removal/sync-type-page.png" alt-text="A screenshot of the Sync Type page" border="false":::

5. Locate **Active Users**, and then add an Exchange license for the user.
6. After some minutes, the mailbox becomes active in Exchange.

7. When you finish the search and export, run the `Remove-Mailbox` cmdlet to change the object to a soft-deleted mailbox. The soft-deleted mailbox will be available for 30 days. It can be returned to an active state by using the `Undo-SoftDeletedMailbox` cmdlet.
