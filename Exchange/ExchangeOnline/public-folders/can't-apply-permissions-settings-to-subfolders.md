---
title: Public folder permissions and settings don't propagate to subfolders in the Exchange admin center (EAC)
description: When you apply permissions to a public folder and its subfolders in the EAC, the permissions aren't applied to some or all subfolders. When you apply other settings, you receive errors.
author: helenclu
ms.author: batre
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: exchange-online
localization_priority: Normal
ms.custom: 
- Exchange Online
- CI 150274
- CSSTroubleshoot
ms.reviewer: batre
appliesto:
- Exchange Online
- Exchange Server 2013
- Exchange Server 2016
- Exchange Server 2019
search.appverid: 
- MET150
---
# Public folder permissions and settings don't propagate in EAC

When you use the Exchange admin center (EAC) to apply permissions or settings to a public folder and its subfolders, either the actions don't finish, or you experience errors. This article describes the following issues with common tasks, and provides workarounds to complete them by using PowerShell.

- [Permissions not applied to some or all subfolders](#permissions-not-applied-to-some-or-all-subfolders)
- [The read and unread settings not applied](#the-read-and-unread-settings-not-applied)
- [Age limit settings not applied to subfolders](#age-limit-settings-not-applied-to-subfolders)

## Permissions not applied to some or all subfolders

When you apply permissions to a public folder and its subfolders by selecting the **Apply changes to this public folder and all its subfolders** check box in the EAC, the permissions aren't applied to some or all subfolders.

![Screenshot of applying permissions](./media/can't-apply-permissions-settings-to-subfolders/public-folder-permission.png)

The issue occurs if the parent folder and its subfolders are in different public folder mailboxes.

### Workaround

To work around this issue, follow these steps:

1. Open PowerShell in the Exchange environment where the public folder is active, either in [Exchange Server (on-premises)](/powershell/exchange/open-the-exchange-management-shell?view=exchange-ps&preserve-view=true) or [Exchange Online](/powershell/exchange/connect-to-exchange-online-powershell?view=exchange-ps&preserve-view=true).
1. Run the [Update-PublicFolderPermissions.ps1](https://www.microsoft.com/download/details.aspx?id=48689) script with the parameters shown in the following example:

   ```powershell
   .\Update-PublicFolderPermissions.ps1 -IncludeFolders "\MyFolder" -AccessRights "Owner" -Users "John", "Administrator" -Recurse -Confirm:$false
   ```

   This example script does the following:

   - Replaces the current client permissions on the "\MyFolder" public folder and all its child folders for users "John" and "Administrator".
   - Grants "Owner" access rights to the users.
   - Don't request confirmation from the user.

   The script has detailed help documentation. To view the documentation for the script, run the following command:

   ```powershell
   Get-Help .\Update-PublicFolderPermissions.ps1 -Full
   ```

## The read and unread settings not applied

When you select the **Apply the read and unread setting to this folder and all its subfolders** check box on a parent public folder in the EAC, you receive the following error message:

> The operation couldn't be performed because '\public folder identity' couldn't be found.

:::image type="content" source="media/can't-apply-permissions-settings-to-subfolders/public-folder-error.png" alt-text="Screenshot of the error when selecting the check box.":::

### Workaround

To work around this issue, follow these steps:

1. Open PowerShell in the Exchange environment where the public folder is active, either in [Exchange Server (on-premises)](/powershell/exchange/open-the-exchange-management-shell?view=exchange-ps&preserve-view=true) or [Exchange Online](/powershell/exchange/connect-to-exchange-online-powershell?view=exchange-ps&preserve-view=true).
1. /powershell/exchange/connect-to-exchange-online-powershell?view=exchange-ps
1. Apply read and unread information tracking on the parent public folder by running the following cmdlet to set the `PerUserReadStateEnabled` value to **True**:

   ```powershell
   Set-PublicFolder -Identity "<\PF>" -PerUserReadStateEnabled $True
   ```

   > [!NOTE]
   > Replace \<\PF> with your parent public folder identity.
3. Apply read and unread information tracking on the child public folders by running the following cmdlet to set the `PerUserReadStateEnabled` value to **True**:

   ```powershell
   Get-PublicFolder "<\PF>" -Recurse | foreach {Set-PublicFolder -Identity $_.identity -PerUserReadStateEnabled $True}
   ```

   > [!NOTE]
   > Replace \<\PF> with your parent public folder identity.

## Age limit settings not applied to subfolders

When you apply age limit settings to a public folder and its subfolders by selecting the **Apply setting to this folder and all its subfolders** check box in the EAC, you receive the following error message:

> The operation couldn't be performed because '\public folder identity' couldn't be found.

:::image type="content" source="media/can't-apply-permissions-settings-to-subfolders/set-age-limit-error.png" alt-text="Error when you apply age limit settings":::

### Workaround

To work around this issue, follow these steps:

1. Open PowerShell in the Exchange environment where the public folder is active, either in [Exchange Server (on-premises)](/powershell/exchange/open-the-exchange-management-shell?view=exchange-ps&preserve-view=true) or [Exchange Online](/powershell/exchange/connect-to-exchange-online-powershell?view=exchange-ps&preserve-view=true). 
2. Run the following cmdlet to apply age limit settings to subfolders:

   ```powershell
   Get-PublicFolder "<\ParentPF>" -Recurse | foreach {Set-PublicFolder -Identity $_.identity -AgeLimit "<newagelimit>"}
   ```
  
   > [!NOTE]
   > Replace \<\ParentPF> with your parent public folder identity.

   For example, the following command applies an age limit of 10 days to all subfolders under Root1:

   ```powershell
   Get-PublicFolder \Root1 -Recurse | foreach {Set-PublicFolder -Identity $_.identity -AgeLimit "10.00:00:00"}
   ```

## Status

Microsoft is aware of these issues and will post more information in this article when a fix becomes available.
