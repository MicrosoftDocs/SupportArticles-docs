---
title: Can't install or access OneDrive with error 0x80070005
description: Fixes an issue in which you can't install or access OneDrive, and you receive error code 0x80070005.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 168512
  - CSSTroubleshoot
ms.reviewer: bpeterse
appliesto: 
  - OneDrive for Business
search.appverid: 
  - MET150
ms.date: 12/17/2023
---
# Error 0x80070005 when you install or access OneDrive

## Symptoms  

When you try to install or access Microsoft OneDrive, the attempt fails and returns error code 0x80070005.

**Note** This issue might also occur when you set up the [folder backup (Known Folder Move)](https://support.microsoft.com/office/back-up-your-folders-with-onedrive-d61a7930-a6fb-4b95-b28a-6552e77c3057) feature in OneDrive for your work or school account.

## Cause  

This error occurs for the following reasons:

- OneDrive isn't updated or can't be updated.
- A Group Policy setting prevents you from setting up the [folder backup (Known Folder Move)](https://support.microsoft.com/office/back-up-your-folders-with-onedrive-d61a7930-a6fb-4b95-b28a-6552e77c3057) feature in OneDrive.  

To resolve this issue, try the following methods in the given order.  

## Option 1: Install available Windows Updates  

1. Select **Start**, enter *updates*, and then select [Check for updates](https://aka.ms/WindowsSettingsLaunch).  
2. Install all available Windows updates.  
3. After the updates are installed, press the Windows logo key (:::image type="icon" source="media/install-or-access-onedrive-error-0x80070005/windows-icon.png":::)+R to open the **Run** dialog box.
4. Enter `%localappdata%\Microsoft\OneDrive\update`, and select **OK**.  
5. Double-click **OneDriveSetup.exe** to install the latest version of OneDrive.  

## Option 2: Configure the Group Policy setting to allow Known Folder Move

1. Select **Start**, and enter *gpedit.msc* in the search box to open the **Local Group Policy Editor**.  
2. Locate **User Configuration** > **Administrative Templates** > **Desktop**.
3. In the right pane, double-click **Prohibit User from manually redirecting Profile Folders**.  
4. Select **Not Configured**, and then select **OK**.

**Note** If this Group Policy setting is set to **Enabled** in your organization, the local Group Policy setting will be overwritten.

## Option 3: Reset OneDrive  

[Resetting OneDrive](https://support.microsoft.com/office/reset-onedrive-34701e00-bf7b-42db-b960-84905399050c) can sometimes resolve sync issues. This action resets all OneDrive settings. OneDrive will perform a full sync after the reset.

## Option 4: Reinstall OneDrive  

[Reinstalling OneDrive](https://support.microsoft.com/office/reinstall-onedrive-0660f354-6a69-46eb-b817-7f4e0d7b45b5) also resets all OneDrive settings, and it can sometimes resolve sync issues. OneDrive will perform a full sync after the reinstallation.
