---
title: OneDrive local folder name isn't updated with the changed organization name
description: The OneDrive local folder name in configured clients isn't updated after the organization name is changed.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 164410
  - CSSTroubleshoot
ms.reviewer: salarson
appliesto: 
  - OneDrive for Business
search.appverid: 
  - MET150
  - SPO160
ms.date: 12/17/2023
---
# OneDrive local folder name isn't updated after changing the organization name

## Symptoms  

After the [organization name is updated](/microsoft-365/admin/manage/change-address-contact-and-more#edit-organization-information) in the Microsoft 365 admin center, the OneDrive folder on your local computer still shows the old organization name.  

## Cause

Updating the organization name in the Microsoft 365 admin center doesn't update the name in configured clients automatically. 

## Resolution  

If the name hasn't been corrected on a local machine after **14** days, unlink OneDrive. Before you do this, make sure that OneDrive isn't syncing files. If OneDrive is syncing files, wait for the process to finish or [pause the sync](https://support.microsoft.com/office/how-to-pause-and-resume-sync-in-onedrive-2152bfa4-a2a5-4d3a-ace8-92912fb4421e).  

**Note:** Disabling, uninstalling, or unlinking OneDrive on your computer won't cause you to lose files or data. You can always access your files by signing in to your OneDrive account online.  

### Unlink OneDrive in Windows  

1. In the taskbar notification area, select the OneDrive icon (:::image type="icon" source="media/onedrive-local-folder-name-not-updated/onedrive-icon.png":::).  

    **Note**  To see the **OneDrive** icon, you might have to select the **Show hidden icons** arrow (:::image type="icon" source="media/onedrive-local-folder-name-not-updated/arrow-icon.png":::) next to the notification area. If the icon doesn't appear, OneDrive might not be running. To start OneDrive, select **Start**, type *OneDrive* in the search box, and then select **OneDrive** in the search results.

2. Select **Help & Settings** (:::image type="icon" source="media/onedrive-local-folder-name-not-updated/gear-icon.png":::), and then select **Settings**.

    :::image type="content" source="media/onedrive-local-folder-name-not-updated/onedrive-settings-in-windows.png" alt-text="Screenshot of the OneDrive settings page in Windows showing the Settings option highlighted on the Help & Settings icon.":::

3. On the **Account** tab, select **Unlink this PC** > **Unlink account**.

   > [!IMPORTANT]
   > At this point you should consider deleting OneDrive cached credentials.
   >
   > 1. Select **Start**, type *credentials*, and then select **Credential Manager** from the results.
   > 2. Select the **Windows Credentials** tab. Under **Generic Credentials**, remove any entries that contain *OneDrive Cached Credentials*.
   > 
   > You may also consider removing the OneDrive folder through the registry before re-linking the account. 
   > Before you modify the regsitry, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.
   >
   > 1. Start Registry Editor.  
   > 2. Locate the `HKEY_CURRENT_USER\Software\Microsoft\OneDrive` registry key.
   > 3. Right-click **OneDrive**, and then select **Delete**.  

4. When the **Set up OneDrive** window opens, close it instead of selecting **Sign in**.

    :::image type="content" source="media/onedrive-local-folder-name-not-updated/set-up-onedrive-window.png" alt-text="Screenshot of the Set up OneDrive window that you have to close directly.":::

5. Go to your OneDrive site, and select **Sync**.

    :::image type="content" source="media/onedrive-local-folder-name-not-updated/onedrive-site.png" alt-text="Screenshot of the OneDrive site in which the Sync tab is highlighted.":::

### Unlink OneDrive in macOS  

1. On the menu bar, select the OneDrive icon (:::image type="icon" source="media/onedrive-local-folder-name-not-updated/onedrive-icon.png":::).

2. Select **More** > **Preferences**.

    :::image type="content" source="media/onedrive-local-folder-name-not-updated/onedrive-preferences-in-macos.png" alt-text="Screenshot of the OneDrive settings page in macOS, showing the Preferences option highlighted on the More tab.":::

3. On the **Account** tab, select **Unlink this Mac** > **Unlink account**.  

4. When the **Set up OneDrive** window opens, close it instead of selecting **Sign in**.  

5. Go to your OneDrive site, and select **Sync**.
