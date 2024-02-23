---
title: Can't send emails to a mail-enabled public folder
description: Fixes an issue in which users can't send email messages to a mail-enabled public folder because they have insufficient permissions on the folder.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 149096
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: haembab
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# "550 5.7.13 STOREDRV.AuthenticationRequiredForPublicFolder" error for messages sent to a mail-enabled public folder

## Symptoms

When users send email messages to a mail-enabled public folder, they receive a non-delivery report (NDR) that includes the following code and description:

> 550 5.7.13 STOREDRV.AuthenticationRequiredForPublicFolder

The part of the NDR message that mentions the error resembles the following detailed example.

:::image type="content" source="media/cannot-send-emails-to-mail-enabled-public-folder/ndr-error.png" alt-text="Screenshot of the NDR error message.":::

## Cause

This error occurs in the following scenarios:

- When the mail-enabled public folder receives messages from an internal user:

    In this scenario, the mail-enabled public folder and the users who are sending email messages to it are in the same organization. Users send messages from a shared mailbox on which they have **Send As** or **Send on Behalf** access rights. The permissions that are set on the mail-enabled public folder identify these users by their **Default** user permission.

- When the mail-enabled public folder receives messages from an external user:

    In this scenario, the permissions that are set on the mail-enabled public folder identify these users by their **Anonymous** user permission.

In these scenarios, neither the **Default** permission nor the **Anonymous** permission is enabled for creating items. Therefore, neither permission is sufficient to write messages to the public folder store.

To check all the user permissions that are set on a mail-enabled public folder, run the [Get-PublicFolderClientPermission](/powershell/module/exchange/get-publicfolderclientpermission) cmdlet, as follows:

```powershell
Get-PublicFolderClientPermission \<name_of_public_folder>
```

**Note:** In this cmdlet, replace \<*name_of_public_folder*> with the name of your mail-enabled public folder.

Here's an example of the output for a public folder that's named PF2:

   :::image type="content" source="media/cannot-send-emails-to-mail-enabled-public-folder/pf-permissions.png" alt-text="Screenshot of the Default and Anonymous user permissions.":::

## Resolution

To fix the error, follow these steps to enable the **Default** or **Anonymous** user permission (as appropriate for your scenario) to be able to create items in the mail-enabled public folder.

**Note:** You must have administrator permissions to make the following changes.

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Run the [Add-PublicFolderClientPermission](/powershell/module/exchange/add-publicfolderclientpermission) cmdlet, as follows:

    For the **Default** user permission:

    ```powershell
    Add-PublicFolderClientPermission -Identity "\<name_of_public_folder>" -User Default -AccessRights CreateItems
    ```

    For the **Anonymous** user permission:

    ```powershell
    Add-PublicFolderClientPermission -Identity "\<name_of_public_folder>" -User Anonymous -AccessRights CreateItems
    ```

    **Note:** In these cmdlets, replace \<*name_of_public_folder*> with the name of your mail-enabled public folder.
