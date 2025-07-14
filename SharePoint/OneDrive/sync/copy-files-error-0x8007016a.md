---
title: Error 0x8007016a when copying files in OneDrive
description: Fixes an issue in which you can't copy files in OneDrive and error code 0x8007016a is returned.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 168515
  - CSSTroubleshoot
ms.reviewer: bpeterse
appliesto: 
  - OneDrive for Business
search.appverid: 
  - MET150
ms.date: 12/17/2023
---

# Error 0x8007016a when copying files in OneDrive

## Symptoms

When you try to copy files in Microsoft OneDrive, you receive the following error message:

> Error 0x8007016a: The cloud file provider is not running.

## Cause

This error occurs if OneDrive is misconfigured.

## Resolution

To resolve this issue, try the following options in the given order.

### Option 1: Turn off OneDrive Files On-Demand and reset OneDrive

1. Sign in to OneDrive on your device, and then select the OneDrive icon (:::image type="icon" source="media/copy-files-error-0x8007016a/onedrive-icon.png":::) in the taskbar notification area.  
2. Select **Help & Settings** (:::image type="icon" source="media/copy-files-error-0x8007016a/settings-icon.png":::) > **Settings**.

    1. If you have a **Settings** tab, clear the **Save space and download files as you use them** checkbox.

       :::image type="content" source="media/copy-files-error-0x8007016a/files-on-demand.png" alt-text="Screenshot of the old OneDrive settings page in which the Save space and download files as you use them option is highlighted.":::

    1. If you don't have a **Settings** tab, select **Sync and back up** > **Advanced settings**. Then, look under **Files On-Demand**, and select **Download all OneDrive files now**.

       :::image type="content" source="media/copy-files-error-0x8007016a/new-files-on-demand-ui.png" alt-text="Screenshot of the latest OneDrive settings page in which the Download all OneDrive files option is highlighted.":::

3. [Reset OneDrive](https://support.microsoft.com/office/reset-onedrive-34701e00-bf7b-42db-b960-84905399050c).  
4. (Optional) After you reset OneDrive, [turn on Files On-Demand](https://support.microsoft.com/office/save-disk-space-with-onedrive-files-on-demand-for-windows-0e6860d3-d9f3-4971-b321-7092438fb38e#bkmk_turnonfond) if you need it.  
5. Try again to copy files in OneDrive.  

### Option 2: Install available Windows updates

1. Select **Start** (:::image type="icon" source="media/copy-files-error-0x8007016a/windows-icon.png":::), type *updates*, and then select [Check for updates](https://aka.ms/WindowsSettingsLaunch).  
2. Install all available Windows updates.
3. Try again to copy files in OneDrive.  
