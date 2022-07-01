---
title: OneDrive local folder name isn't updated with the changed organization name
description: The OneDrive local folder name in configured clients isn't updated after the organization name is changed.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 164410
  - CSSTroubleshoot
ms.reviewer: salarson
appliesto: 
  - OneDrive for Business
search.appverid: 
  - MET150
  - SPO160
ms.date: 7/1/2022
---
# OneDrive local folder name isn't updated after changing the organization name

## Symptoms  

After the [organization name is updated](/microsoft-365/admin/manage/change-address-contact-and-more#edit-organization-information) in the Microsoft 365 admin center, the OneDrive folder on your local computer still shows the old organization name.  

## Cause

Updating the organization name in the Microsoft 365 admin center doesn't update the name in configured clients.

## Resolution  

To resolve this issue, unlink OneDrive. Before you do it, make sure that OneDrive is not syncing files. If OneDrive is syncing files, wait for the sync to finish or [pause the sync](https://support.microsoft.com/office/how-to-pause-and-resume-sync-in-onedrive-2152bfa4-a2a5-4d3a-ace8-92912fb4421e).  

**Note** You won't lose files or data by disabling, uninstalling or unlinking OneDrive on your computer. You can always access your files by signing in to your OneDrive account online.  

### Unlink OneDrive in Windows  

1. Select the OneDrive icon (:::image type="icon" source="media/onedrive-local-folder-name-not-updated/onedrive-icon.png":::) in the taskbar notification area.  

    **Note** You might need to select the **Show hidden icons** arrow (:::image type="icon" source="media/onedrive-local-folder-name-not-updated/arrow-icon.png":::) next to the notification area to see the **OneDrive** icon. If the icon doesn't appear, OneDrive might not be running. To start OneDrive, select **Start**, type *OneDrive* in the search box, and then select **OneDrive** in the search results.

2. Select Help & Settings (:::image type="icon" source="media/onedrive-local-folder-name-not-updated/gear-icon.png":::), and then select **Settings**.

    :::image type="content" source="media/onedrive-local-folder-name-not-updated/onedrive-settings-in-windows.png" alt-text="Screenshot of the OneDrive settings page in Windows, and the Settings option is highlighted in the Help & Settings icon.":::

3. On the **Account** tab, select **Unlink this PC** > **Unlink account**.

4. When the **Set up OneDrive** window opens, close it instead of selecting **Sign in**.

    :::image type="content" source="media/onedrive-local-folder-name-not-updated/set-up-onedrive-window.png" alt-text="Screenshot of the Set up OneDrive window which you need to close directly.":::

5. Go to your OneDrive site and select **Sync**.

    :::image type="content" source="media/onedrive-local-folder-name-not-updated/onedrive-site.png" alt-text="Screenshot of the OneDrive site in which the Sync tab is highlighted.":::

### Unlink OneDrive in macOS  

1. Select the OneDrive icon (:::image type="icon" source="media/onedrive-local-folder-name-not-updated/onedrive-icon.png":::) in the menu bar.

2. Select **More** > **Preferences**.

    :::image type="content" source="media/onedrive-local-folder-name-not-updated/onedrive-preferences-in-macos.png" alt-text="Screenshot of the OneDrive settings page in macOS, and the Preferences option is highlighted in More tab.":::

3. On the **Account** tab, select **Unlink this Mac** > **Unlink account**.  

4. When the **Set up OneDrive** window opens, close it instead of selecting **Sign in**.  

5. Go to your OneDrive site and select **Sync**.
