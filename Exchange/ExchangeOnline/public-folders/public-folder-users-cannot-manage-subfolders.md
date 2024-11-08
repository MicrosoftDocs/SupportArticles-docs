---
title: Public folder users can't rename, move, or delete subfolders
description: Provides workarounds for an issue in which users can't rename, move, or delete subfolders that they create in a public folder.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Online
  - CSSTroubleshoot
  - CI 172447
ms.reviewer: batre, meerak, v-trisshores
appliesto: 
  - Exchange Online
  - Exchange Online via Office 365 E Plans
  - Exchange Online via Office 365 P Plans
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
search.appverid: 
  - MET150
ms.date: 01/24/2024
---

# Public folder users can't rename, move, or delete subfolders

## Symptoms

After a user creates a subfolder in a public folder, the user can't rename, move, or delete the subfolder.

## Cause

The user mailbox `EffectivePublicFolderMailbox` property doesn't specify the [primary hierarchy](/exchange/collaboration-exo/public-folders/public-folders#public-folder-mailboxes) public folder mailbox for your Microsoft Exchange organization.

An Exchange algorithm that load balances users across all public folder mailboxes automatically assigns an `EffectivePublicFolderMailbox` value to each user mailbox.

If the user mailbox `EffectivePublicFolderMailbox` value specifies the primary hierarchy public folder mailbox for your Exchange organization, the user has the [Owner permission](/powershell/module/exchange/add-publicfolderclientpermission#-accessrights) on public folder subfolders that they create within any public folder mailbox. The Owner permission lets users rename, move, and delete those subfolders.

If the user mailbox `EffectivePublicFolderMailbox` value specifies a [secondary hierarchy public folder mailbox](/exchange/collaboration-exo/public-folders/public-folders#public-folder-mailboxes), the user inherits the parent folder permissions on public folder subfolders that they create within any public folder mailbox. The issue that's described in the "Symptoms" section occurs if the user has one of the following [public folder permissions](/powershell/module/exchange/add-publicfolderclientpermission#-accessrights) on the parent folder:

- PublishingEditor: role-based permission-set that includes the CreateSubfolders permission

- PublishingAuthor: role-based permission-set that includes the CreateSubfolders permission

- CreateSubfolders: required to create a subfolder

## Workaround

To work around the issue, grant the user the [Owner permission](/powershell/module/exchange/add-publicfolderclientpermission#-accessrights) on subfolders that they create or have to manage. Use one of the following methods.

> [!NOTE]
> To use the following methods, you must have administrator permissions.

### Method 1: Use the Exchange admin center

1. In the Exchange admin center (EAC), browse to **Public folders** \> **Public folders**.

2. Browse to the user's subfolder, and then select **Manage** in the right pane.

3. Grant the user the Owner permission on the subfolder.

> [!NOTE]
> Depending on the public folder location and your Exchange environment, use Exchange Online or on-premises EAC.

### Method 2: Use the Outlook desktop client

1. In the Microsoft Outlook desktop client, browse to the user's subfolder, and then open the **Properties** window.

2. On the **Permissions** tab, select the **Owner** permission level, and then select **Add** to specify the user.

### Method 3: Use PowerShell

Run the [Add-PublicFolderClientPermission](/powershell/module/exchange/add-publicfolderclientpermission) cmdlet to grant the user the Owner permission on a subfolder:

```powershell
Add-PublicFolderClientPermission -Identity <subfolder ID> -User <user ID> -AccessRights Owner
```

> [!NOTE]
> Depending on the public folder location and your Exchange environment, you might have to first connect your PowerShell session to Exchange Online. For on-premises public folders, use the Exchange Management Shell (EMS).

## More information

- To determine the user permissions for a public folder or subfolder, check in EAC or run the following command:

   ```powershell
   Get-PublicFolderClientPermission <folder ID> | FT FolderName,User,AccessRights
   ```

- To determine the `EffectivePublicFolderMailbox` property value for a user mailbox, run the following command:

   ```powershell
   Get-Mailbox -Identity <user mailbox> | FL Name,EffectivePublicFolderMailbox
   ```

- To identify the primary hierarchy public folder mailbox for your Exchange organization, [check in EAC](/exchange/collaboration/public-folders/create-public-folder-mailboxes#how-do-you-know-this-worked) or run the following command:

   ```powershell
   Get-Mailbox -PublicFolder | FT Name,IsRootPublicFolderMailbox
   ```
