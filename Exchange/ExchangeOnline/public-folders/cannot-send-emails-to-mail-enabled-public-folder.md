---
title: Can't send emails to a mail-enabled public folder
description: Fixes an issue in which users can't send email messages to a mail-enabled public folder because they have insufficient permissions on the folder.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: exchange-online
localization_priority: Normal
ms.custom:
- CI 149096
- Exchange Online
- CSSTroubleshoot
ms.reviewer: haembab
appliesto: 
- Exchange Online
search.appverid: MET150
---
# "550 5.7.13 STOREDRV.AuthenticationRequiredForPublicFolder" error when users send emails to a mail-enabled public folder

## Symptoms

When users send email messages to a mail-enabled public folder, they receive the following error message:

> 550 5.7.13 STOREDRV.AuthenticationRequiredForPublicFolder

For example, the detailed error message shows as in the following screenshot:

:::image type="content" source="media/cannot-send-emails-to-mail-enabled-public-folder/ndr-error.png" alt-text="Screenshot of the NDR error message.":::

This issue occurs in either of the following scenarios:

## Scenario 1: Users send email messages from a shared mailbox in the same organization

In this scenario, users have the **Send As** or **Send on Behalf** access rights on the shared mailbox. This issue occurs because the **Default** user permission on the mail-enabled public folder isn't sufficient to write the messages to the public folder store.

### Resolution

**Note:** You must have administrator permission to make the following changes.

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
1. Check the **Default** user permission on the mail-enabled public folder by running the [Get-PublicFolderClientPermission](/powershell/module/exchange/get-publicfolderclientpermission) command. Here's an example of the command and output.

   :::image type="content" source="media/cannot-send-emails-to-mail-enabled-public-folder/default-permission.png" alt-text="Screenshot of the Default user permission.":::

1. Grant the **Default** user sufficient permission on the mail-enabled public folder by running the following command:

   ```powershell
   Add-PublicFolderClientPermission -Identity "\<My Public Folder>" -User Default -AccessRights CreateItems
   ```

   **Note:** Replace \<My Public Folder> with the actual name of the public folder. For more information about the command, see [Add-PublicFolderClientPermission](/powershell/module/exchange/add-publicfolderclientpermission).

## Scenario 2: Users send email messages from outside the organization

In this scenario, this issue occurs because the **Anonymous** user permission on the mail-enabled public folder isn't sufficient to write the messages to the public folder store.

### Resolution

**Note:** You must have administrator permission to make the following changes.

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
1. Check the **Anonymous** user permission on the mail-enabled public folder by running the [Get-PublicFolderClientPermission](/powershell/module/exchange/get-publicfolderclientpermission) command. Here's an example of the command and output.

      :::image type="content" source="media/cannot-send-emails-to-mail-enabled-public-folder/anonymous-permission.png" alt-text="Screenshot of the Anonymous user permission.":::

1. Grant the **Anonymous** user sufficient permission on the mail-enabled public folder by running the following command:

   ```powershell
   Add-PublicFolderClientPermission -Identity "\My Public Folder" -User Anonymous  -AccessRights CreateItems
   ```

   **Note:** Replace \<My Public Folder> with the actual name of the public folder. For more information about the command, see [Add-PublicFolderClientPermission](/powershell/module/exchange/add-publicfolderclientpermission).
