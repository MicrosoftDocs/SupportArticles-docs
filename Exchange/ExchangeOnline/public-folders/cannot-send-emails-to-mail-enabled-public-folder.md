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
# "550 5.7.13 STOREDRV.AuthenticationRequiredForPublicFolder" error for messages sent to a mail-enabled public folder

## Symptoms

When users send email messages to a mail-enabled public folder, they receive a non-delivery report (NDR) with the following code and description:

> 550 5.7.13 STOREDRV.AuthenticationRequiredForPublicFolder

The part of the NDR message with details about the error resembles the following detailed example.

:::image type="content" source="media/cannot-send-emails-to-mail-enabled-public-folder/ndr-error.png" alt-text="Screenshot of the NDR error message.":::

## Cause

This error occurs in the following scenarios:

- When the mail-enabled public folder gets email messages from an internal user:

    In this scenario, the mail-enabled public folder and the users sending email messages to it are in the same organization. Users send messages from a shared mailbox on which they have **Send As** or **Send on Behalf** access rights. The permissions set on the mail-enabled public folder identify these users with the **Default** user permission.

- When the mail-enabled public folder gets email messages from an external user:

    In this scenario, the permissions set on the mail-enabled public folder identify these users with the **Anonymous** user permission.

In these scenarios, both the **Default** and **Anonymous** user permissions are not enabled for creating items and therefore not sufficient to write the messages to the public folder store.

To check all the user permissions set on a mail-enabled public folder, run the [Get-PublicFolderClientPermission](/powershell/module/exchange/get-publicfolderclientpermission) cmdlet as follows:

```powershell
Get-PublicFolderClientPermission \<name_of_public_folder>
```

**Note:** Replace \<name_of_public_folder> with the name of your mail-enabled public folder.

Here's an example of the output for the public folder named PF2:

   :::image type="content" source="media/cannot-send-emails-to-mail-enabled-public-folder/pf-permissions.png" alt-text="Screenshot of the Default and Anonymous user permissions.":::

## Resolution

**Note:** You must have administrator permissions to make the following changes.

To fix the error, use these steps to enable the Default or the Anonymous user permissions, as appropriate for your scenario, to create items in the mail-enabled public folder.

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Run the [Add-PublicFolderClientPermission](/powershell/module/exchange/add-publicfolderclientpermission) cmdlet as follows:

    For the Default user permission:

    ```powershell
    Add-PublicFolderClientPermission -Identity "\<name_of_public_folder>" -User Default -AccessRights CreateItems
    ```

    For the Anonymous user permission:

    ```powershell
    Add-PublicFolderClientPermission -Identity "\<name_of_public_folder>" -User Anonymous -AccessRights CreateItems
    ```

    **Note:** Replace \<name_of_public_folder> with the name of your mail-enabled public folder.
