---
title: UPLOAD BLOCKED when saving files to OneDrive
ms.author: meerak
author: Cloud-Writer
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - OneDrive for Business
ms.custom: 
  - CI 120653
  - CI 169119
  - CSSTroubleshoot
ms.reviewer: dumitrim, bpeterse
description: How to resolve an upload blocked error in Microsoft 365 when two different accounts sync files to OneDrive.
---

# "UPLOAD BLOCKED" error when you save OneDrive-synced files in Microsoft 365 apps

## Symptoms

You open and edit a Microsoft OneDrive-synced file in a Microsoft 365 app, such as Microsoft Word, Microsoft PowerPoint, or Microsoft Excel. When you try to save the file, you receive the following error message:

> UPLOAD BLOCKED: We couldn't verify you have the necessary permissions to upload the file.

:::image type="content" source="media/upload-blocked-error-in-o365/upload-blocked-error-message.png" alt-text="Screenshot of the Upload blocked error message.":::

## Cause

This issue occurs if you sign in to the Microsoft 365 app by using an account that doesn't have permission to upload files to OneDrive.

For example, you use the *user@fabrikam.onmicrosoft.com* account to sync files to OneDrive. However, you sign in to the Microsoft 365 app by using the *user@contoso.onmicrosoft.com* account, and this account doesn't have permission to upload files to OneDrive. In this case, you receive the error message when you try to save the file to OneDrive.

## Resolution

To fix this issue, try the following methods in the given order. If one method doesn't fix the issue, try the next one.

### Method 1: Use the same account to sign in to the Microsoft 365 app and OneDrive

1. Select the OneDrive icon (:::image type="icon" source="media/upload-blocked-error-in-o365/onedrive-icon.png":::) in the taskbar notification area.
1. Select **Help & Settings** (:::image type="icon" source="media/upload-blocked-error-in-o365/setting-icon.png":::) > **Settings**.

   :::image type="content" source="media/upload-blocked-error-in-o365/onedrive-settings.png" alt-text="Screenshot of the OneDrive window in which the Settings icon and Settings menu option are highlighted.":::

1. On the **Account** tab, note the signed-in account.
1. Open the affected Microsoft 365 app, and then select **File** > **Account**.
1. Under **Connected Services**, select **Remove** to remove all accounts except the account that you noted in step 3.
1. Select the OneDrive icon, select **Help & Settings** (:::image type="icon" source="media/upload-blocked-error-in-o365/setting-icon.png":::) > **Pause syncing**, and then select how much time you want to pause for: **2 hours**, **8 hours**, or **24 hours**.
1. Select **Help & Settings** (:::image type="icon" source="media/upload-blocked-error-in-o365/setting-icon.png":::) > **Quit OneDrive**.
1. Close all Microsoft 365 apps.
1. Restart OneDrive and the affected Microsoft 365 app.
1. Try again to save the files to OneDrive.  

### Method 2: Remove credentials related to OneDrive and Microsoft 365 apps

1. Open the affected Microsoft 365 app, and then select **File** > **Account**.
1. Under **User Information**, select **Sign out** for all accounts.
1. Close all Microsoft 365 apps.
1. Select **Start** (:::image type="icon" source="media/upload-blocked-error-in-o365/windows-icon.png":::), enter *credentials*, and then select **Credential Manager**.
1. Select **Windows Credentials**.
1. Under **Generic Credentials**, select the credentials that are related to OneDrive, MicrosoftOffice16, and MicrosoftOffice15, and then select **Remove**.

   :::image type="content" source="media/upload-blocked-error-in-o365/remove-credentials.png" alt-text="Screenshot of the Generic Credentials pane in which the Remove button is highlighted for credentials.":::

1. Restart OneDrive and the affected Microsoft 365 app, and then sign in to them again by using the same account.
1. Try again to save the files to OneDrive.

### Method 3: Unlink and relink OneDrive

This method can fix OneDrive configuration issues. For the detailed steps, see [Unlink and re-link OneDrive](https://support.microsoft.com/office/unlink-and-re-link-onedrive-3c4680bf-cc36-4204-9ca5-e7b24cdd23ea). Then, try again to save the files to OneDrive.

### Method 4: Install available Windows updates

To check and install all available updates, see [Update Windows](https://support.microsoft.com/windows/update-windows-3c5ae7fc-9fb6-9af1-1984-b5e0412c556a). After all updates are installed, restart the affected Microsoft 365 app, and then try again to save the files to OneDrive.
