---
title: Public folder permissions and settings don't propagate to all subfolders
description: Provides workarounds for an issue in which the EAC doesn't apply public folder permissions or settings on all subfolders.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Online
  - CSSTroubleshoot
  - CI 2580
ms.reviewer: batre, meerak, v-shorestris
appliesto:
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 12/04/2024
---

# Public folder permissions and settings don't propagate to all subfolders

You try to use the Exchange admin center (EAC) to update the permissions or other settings of a public folder and all its subfolders. However, you encounter any of the following issues:

- Microsoft Exchange Server (on-premises):
   - The EAC doesn't apply your changes to all subfolders.
   - The EAC displays an error message and the operation fails.

- Microsoft Exchange Online:
   - The EAC doesn't provide an option to apply your changes to subfolders.

The following sections provide PowerShell workarounds for various issues.

## Permissions aren't applied to all subfolders

The EAC in Exchange Online doesn't provide an option to update subfolders when you change permissions on a public folder. This functionality is by design.

The EAC in Exchange Server provides an option to **Apply changes to this public folder and all its subfolders** when you update permissions on a public folder. However, for subfolders that are in a different public folder mailbox than the parent public folder, the operation might silently fail or not work reliably, depending on the number of public folder mailboxes in your organization.

### Workaround

Select one of the following workarounds, depending on the Exchange environment for the affected public folders:

- For public folders in Exchange Online, run the [Update-PublicFolderPermissions.ps1](https://aka.ms/PFPermissionScript) script in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell). Include the PowerShell parameters that are shown in the following example:

   ```PowerShell
   .\Update-PublicFolderPermissions.ps1 -Users user1@contoso.com -AccessRights Owner -IncludeFolders "\FolderA" -Recurse -Confirm:$false
   ```

   This command grants `user1@contoso.com` the Owner role on the `\FolderA` public folder and its entire subtree.

- For public folders in Exchange Server, run the [Update-PublicFolderPermissions.ps1](https://www.microsoft.com/download/details.aspx?id=48689) script in the Exchange Management Shell (EMS). Include the PowerShell parameters that are shown in the following example:

   ```PowerShell
   .\Update-PublicFolderPermissions.ps1 -IncludeFolders "\FolderA" -AccessRights "Owner" -Users "user1@contoso.com", "user2@contoso.com" -Recurse -Confirm:$false
   ```

   This command grants `user1@contoso.com` and `user2@contoso.com` the Owner role on the `\FolderA` public folder and its entire subtree.

## Maintain per-user read setting isn't applied to all subfolders

The EAC in Exchange Online doesn't provide an option to update the **Maintain per-user** **read and unread information** setting.

The EAC in Exchange Server provides an option to **Apply changes to this public folder and all its subfolders** when you update the **Maintain per-user** **read and unread information** setting for a public folder. However, the operation might fail and return the following error message:

> The operation couldn't be performed because '\<\public folder\>' couldn't be found.

### Workaround

To work around this issue, follow these steps:

1. Open PowerShell in [Exchange Server](/powershell/exchange/open-the-exchange-management-shell) or [Exchange Online](/powershell/exchange/connect-to-exchange-online-powershell), depending on the Exchange environment in which the public folders are active.

2. Run the following cmdlet. The cmdlet uses the [PerUserReadStateEnabled](/powershell/module/exchange/set-publicfolder#-peruserreadstateenabled) parameter to apply a **Maintain per-user read and unread information** setting for the parent public folder and all child public folders. Set the parameter value to `$true` or `$false`, depending on your requirement.

   ```PowerShell
   Get-PublicFolder -Identity "<\ParentPF>" -Recurse -ResultSize Unlimited | Set-PublicFolder -PerUserReadStateEnabled <$true or $false>
   ```

   **Note**: Replace \<\ParentPF\> with the identity of the parent public folder.

## Age limit setting isn't applied to subfolders

The EAC in Exchange Online doesn't provide an option to update subfolders when you change the **Age limit for folder content** setting for a public folder.

The EAC in Exchange Server provides an option to **Apply changes to this public folder and all its subfolders** when you update the **Age limit for folder content** setting for a public folder. However, the operation might fail and return the following error message:

> The operation couldn't be performed because '\<\public folder\>' couldn't be found.

### Workaround

To work around this issue, follow these steps:

1. Open PowerShell in [Exchange Server](/powershell/exchange/open-the-exchange-management-shell) or [Exchange Online](/powershell/exchange/connect-to-exchange-online-powershell), depending on the Exchange environment in which the public folders are active.

2. Run the following cmdlet. The cmdlet uses the [AgeLimit](/powershell/module/exchange/set-publicfolder#-agelimit) parameter to apply an **Age limit for folder content** setting on the parent public folder and all child public folders. For example, set the parameter value to `10.00:00:00` to specify 10 days.

   ```PowerShell
   Get-PublicFolder "<\ParentPF>" -Recurse -ResultSize Unlimited | Set-PublicFolder -AgeLimit <age limit>
   ```

   **Note**: Replace \<\ParentPF\> with the identity of the parent public folder.

## Retain deleted items setting isn't applied to subfolders

The EAC in Exchange Online doesn't provide an option to update subfolders when you change the **Retain deleted items** setting for a public folder.

The EAC in Exchange Server provides an option to **Apply changes to this public folder and all its subfolders** when you update the **Retain deleted items** setting for a public folder. However, the operation might fail and return the following error message:

> The operation couldn't be performed because '\<\public folder\>' couldn't be found.

### Workaround

To work around this issue, follow these steps:

1. Open PowerShell in [Exchange Server](/powershell/exchange/open-the-exchange-management-shell) or [Exchange Online](/powershell/exchange/connect-to-exchange-online-powershell), depending on the Exchange environment in which the public folders are active.

2. Run the following cmdlet. The cmdlet uses the [RetainDeletedItemsFor](/powershell/module/exchange/set-publicfolder#-retaindeleteditemsfor) parameter to apply a **Retain deleted items** setting on the parent public folder and all child public folders. Set the parameter value depending on your requirement. For example, set the value to `30.00:00:00` to specify 30 days.

   ```PowerShell
   Get-PublicFolder "<\ParentPF>" -Recurse -ResultSize Unlimited | Set-PublicFolder -RetainDeletedItemsFor <retention period>
   ```

   **Note**: Replace \<\ParentPF\> with the identity of the parent public folder.
