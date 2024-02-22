---
title: Can't delete a mail-enabled public folder
description: Fixes an issue in which you can't delete a public folder from Outlook clients because the public folder is mail-enabled.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 162531
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: batre
appliesto: 
  - Exchange Online via Office 365 E Plans
  - Exchange Online via Office 365 P Plans
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when deleting a public folder from Outlook clients

## Symptoms

When you try to delete a public folder from a Microsoft Outlook client, you receive one of the following error messages even if you have appropriate permissions:

- **In Outlook for Windows**
    > Cannot delete this folder. Right-click the folder, and then click Properties to check your permissions for this folder. See the folder owner or administrator to change your permissions. Some items cannot be deleted. They were either moved or already deleted, or access was denied.

- **In Outlook for Mac**
    > Outlook cannot complete the action because of an error on the Exchange server.  
    > HTTP error. Access to the resource has not been authorised.

## Cause

This issue occurs because the public folder is mail-enabled. Public folders must be mail-disabled before you can delete them.

## Resolution

To resolve this issue, mail-disable the public folder by using the following steps.

**Note:** You must have administrator permissions to do these steps.

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Remove the public folder by using the following command:

    ```powershell
    Remove-PublicFolder <identity of PF>
    ```

    In the output, you see an error message that indicates that the public folder should be mail-disabled before you can continue.

    :::image type="content" source="media/cannot-delete-public-folder/remove-pf-cmdlet.png" alt-text="Screenshot of the removing public folder cmdlet. An error that indicates a public folder should be mail-disabled before removing is displayed.":::

3. Mail-disable the public folder by using the following command:

    ```powershell
    Disable-MailPublicFolder <identity of PF>
    ```

    When you're prompted to confirm this action, enter **Y**.

    :::image type="content" source="media/cannot-delete-public-folder/mail-disable-pf.png" alt-text="Screenshot of cmdlet to mail-disable a public folder.":::

After you complete these steps, you can remove the public folder from Exchange Online PowerShell, or the user can remove it from the Outlook client.
