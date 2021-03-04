---
title: Unable to apply read setting to public folders
description: Fixes an issue in which you can't apply the read and unread setting to a parent public folder and all its subfolders.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: exchange-online
localization_priority: Normal
ms.custom:
- CI 143403
- Exchange Online
- CSSTroubleshoot
ms.reviewer: haembab
appliesto: 
- Exchange Online
search.appverid: MET150
---
# Unable to apply read setting to public folders

## Symptoms

In Exchange admin center, when you select the **Apply the read and unread setting to this folder and all its subfolders** check box on a parent public folder, you receive the following error message:

> The operation couldn't be performed because '\public folder identity' couldn't be found.

:::image type="content" source="media/cannot-apply-read-unread-setting/public-folder-error.png" alt-text="Screenshot of the error when selecting the check box.":::

## Workaround

Here's how to apply the read and unread information tracking to users by using PowerShell:

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell#connect-to-exchange-online-powershell-using-mfa-and-modern-authentication).
2. Apply the read and unread information tracking on the parent public folder by setting the `PerUserReadStateEnabled` value to **True** in the following cmdlet:

   ```powershell
   Set-PublicFolder -Identity "<\PF>" -PerUserReadStateEnabled $True
   ```

   **Note:** Replace \<\PF> with your parent public folder identity.

   Here's an example:

   ```powershell
   Set-PublicFolder -Identity \Marketing -PerUserReadStateEnabled $true
   ```

3. Apply read and unread information tracking on the child public folders by setting the `PerUserReadStateEnabled` value to **True** in the following cmdlet:

   ```powershell
   Get-PublicFolder "<\PF>" -GetChildren | foreach{Set-PublicFolder -Identity $_.identity -PerUserReadStateEnabled $True}
   ```

   **Note:** Replace \<\PF> with your parent public folder identity.

   Here's an example:

   ```powershell
   Get-PublicFolder \Marketing -GetChildren | foreach{Set-PublicFolder -Identity $_.identity -PerUserReadStateEnabled $True}
   ```

## Status

This issue is under investigation and this article will be updated when it's fixed.
