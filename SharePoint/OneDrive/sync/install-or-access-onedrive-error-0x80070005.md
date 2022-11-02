---
title: Can't install or access OneDrive with error 0x80070005
description: Fixes an in which you can't install or access OneDrive with the error code 0x80070005.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 168512
  - CSSTroubleshoot
ms.reviewer: bpeterse
appliesto: 
  - OneDrive for Business
search.appverid: 
  - MET150
ms.date: 11/2/2022
---
# Error 0x80070005 when you install or access OneDrive

## Symptoms  

When you try to install or access Microsoft OneDrive, you receive the error code 0x80070005.

**Note** This issue may also occur when you set up the [folder backup (Known Folder Move)](https://support.microsoft.com/office/back-up-your-folders-with-onedrive-d61a7930-a6fb-4b95-b28a-6552e77c3057) in OneDrive for your work or school account.

## Cause  

This error may occur for the following reasons:

- OneDrive isn't updated or can't be updated.
- A Group Policy setting prevents you from setting up the [folder backup (Known Folder Move)](https://support.microsoft.com/office/back-up-your-folders-with-onedrive-d61a7930-a6fb-4b95-b28a-6552e77c3057) in OneDrive.  

To resolve this issue, try the following options. If one option doesn't work, move on to the next option.  

## Option 1: Install available Windows Updates  

1. Select **Start**, type *updates*, and then select [Check for updates](https://aka.ms/WindowsSettingsLaunch).  
2. Install all available Windows Updates.  
3. After updates are installed, press Windows logon key (:::image type="icon" source="media/install-or-access-onedrive-error-0x80070005/windows-icon.png":::) + R to open the **Run** dialog box.
4. Type `%localappdata%\Microsoft\OneDrive\update` and select **OK**.  
5. Double-click **OneDriveSetup.exe** to install the latest version of OneDrive.  

## Option 2: Configure the Group Policy setting to allow Known Folder Move

1. Select **Start**, and type *gpedit.msc* in the search box to open the **Local Group Policy Editor**.  
2. Locate **User Configuration** > **Administrative Templates** > **Desktop**.
3. In the right pane, double-click **Prohibit User from manually redirecting Profile Folders**.  
4. Select **Not Configured**, and then select **OK**.

**Note** If this Group Policy setting is set to **Enabled** in your organization, the local Group Policy setting will be overwritten.

## Option 3: Reset OneDrive  

[Resetting OneDrive](https://support.microsoft.com/office/reset-onedrive-34701e00-bf7b-42db-b960-84905399050c) can sometimes resolve sync issues. It resets all OneDrive settings and OneDrive will perform a full sync after the reset.

## Option 4: Reinstall OneDrive  

[Reinstalling OneDrive](https://support.microsoft.com/office/reinstall-onedrive-0660f354-6a69-46eb-b817-7f4e0d7b45b5) also resets all OneDrive settings and can sometimes resolve sync issues. OneDrive will perform a full sync after reinstallation.
