---
title: Error 0x8007016a when copying files in OneDrive
description: Fixes an issue in which you can't copy files in OneDrive with the error code 0x8007016a.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 168515
  - CSSTroubleshoot
ms.reviewer: bpeterse
appliesto: 
  - OneDrive for Business
search.appverid: 
  - MET150
ms.date: 12/1/2022
---

# Error 0x8007016a when copying files in OneDrive

## Symptoms

You can't copy files in Microsoft OneDrive and receive the following error message:

> Error 0x8007016a: The cloud file provider is not running.

## Cause

This error occurs if OneDrive is misconfigured.

## Resolution

To resolve this issue, try the following options. If one option doesn't work, move on to the next option.

### Option 1: Turn off OneDrive Files On-Demand and reset OneDrive

1. Sign in to OneDrive on your device, and then select the OneDrive icon (:::image type="icon" source="media/copy-files-error-0x8007016a/onedrive-icon.png":::) in the taskbar notification area.  
2. Select **Help & Settings** (:::image type="icon" source="media/copy-files-error-0x8007016a/settings-icon.png":::) > **Settings**.

    1. If you have a **Settings** tab, clear **Save space and download files as you use them** box.

       :::image type="content" source="media/copy-files-error-0x8007016a/files-on-demand.png" alt-text="Screenshot of the old OneDrive settings page in which Save space and download files as you use them option is highlighted.":::

    1. If you don't have a **Settings** tab, select **Sync and back up** > **Advanced settings**. Then, under **Files On-Demand**, select **Download all OneDrive files now**.

       :::image type="content" source="media/copy-files-error-0x8007016a/new-files-on-demand-ui.png" alt-text="Screenshot of the latest OneDrive settings page in which Download all OneDrive files option is highlighted.":::

3. [Reset OneDrive](https://support.microsoft.com/office/reset-onedrive-34701e00-bf7b-42db-b960-84905399050c).  
4. (Optional) After resetting OneDrive, [turn on Files On-Demand](https://support.microsoft.com/office/save-disk-space-with-onedrive-files-on-demand-for-windows-0e6860d3-d9f3-4971-b321-7092438fb38e#bkmk_turnonfond) if you need it.  
5. Try to copy files in OneDrive again.  

### Option 2: Install available Windows updates

1. Select **Start** (:::image type="icon" source="media/copy-files-error-0x8007016a/windows-icon.png":::), type *updates*, and then select [Check for updates](https://aka.ms/WindowsSettingsLaunch).  
2. Install all available Windows updates.
3. Try to copy files in OneDrive again.  
