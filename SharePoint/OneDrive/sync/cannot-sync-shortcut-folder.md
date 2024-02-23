---
title: Can't sync a shortcut folder with OneDrive
description: Fixes an issue in which you can use the OneDrive sync app to sync a shared folder that's set as a shortcut.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 168013
ms.reviewer: bpterse
appliesto: 
  - Microsoft OneDrive
  - OneDrive for Business
search.appverid: MET150
ms.date: 12/17/2023
---

# You can't sync a shared folder that's set as a shortcut in OneDrive sync app

## Symptoms  

You [create a shortcut to a folder](https://support.microsoft.com/en-us/office/add-shortcuts-to-shared-folders-in-onedrive-for-work-or-school-d66b1347-99b7-4470-9360-ffc048d35a33) that's stored in a SharePoint Online document library, and then you add the shortcut to OneDrive. When you try to sync the SharePoint Online document library with the Microsoft OneDrive sync app, the sync stops working, and you receive the following error message:

> Sorry, we can't sync this folder. You're already syncing a shortcut to a folder from this shared library.  

## Cause  

This behavior is by design. You can't sync a document library that's already set as a shortcut in OneDrive. Similarly, you can't use the **Add shortcut to My files** option if the document library is already synced.  

**Note:** For a SharePoint document library, you can't use both the **Sync** and **Add shortcut to My files** features.  

## Resolution

To fix this issue, use one of the following methods to remove the shortcut.

### Method 1: Remove the shortcut from the OneDrive folder  

1. Open the OneDrive folder on your device.  
1. Find the shortcut folder that has a small link icon (:::image type="icon" source="media/cannot-sync-shortcut-folder/shortcut-icon.png":::).  
1. Right-click the shortcut folder, and select **Delete**.  

If you can't remove the shortcut folder, [pause syncing in the OneDrive sync app](https://support.microsoft.com/office/how-to-pause-and-resume-sync-in-onedrive-2152bfa4-a2a5-4d3a-ace8-92912fb4421e), and then try again to delete the shortcut.  

### Method 2: Remove the shortcut from the OneDrive site  

1. Sign in to your [Microsoft 365 account](https://www.office.com/signin), and then select **OneDrive** from the app launcher (:::image type="icon" source="media/cannot-sync-shortcut-folder/app-launcher-icon.png":::). Or, open your [OneDrive site URL](/sharepoint/list-onedrive-urls#about-onedrive-urls) directly.  
1. In the upper-left corner, select **My files**.
1. Find the shortcut folder that has a small link icon (:::image type="icon" source="media/cannot-sync-shortcut-folder/shortcut-icon.png":::).  
1. Right-click the folder, or select the three dots icon (:::image type="icon" source="media/cannot-sync-shortcut-folder/three-dots-icon.png":::) that's next to the folder, and then select **Remove**.

If you can't remove the shortcut, [pause syncing in the OneDrive sync app](https://support.microsoft.com/office/how-to-pause-and-resume-sync-in-onedrive-2152bfa4-a2a5-4d3a-ace8-92912fb4421e), and then try again to delete the shortcut.
