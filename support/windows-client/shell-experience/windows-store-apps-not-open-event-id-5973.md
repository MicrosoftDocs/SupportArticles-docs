---
title: Event ID 5973 when you open Windows Store apps
description: Windows Modern Applications quit immediately with Event ID 5973.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, xiangwu
ms.custom: sap:modern-inbox-and-microsoft-store-apps, csstroubleshoot
---
# Windows Store apps may not open and Event ID 5973 is logged in the Application log

This article provides a solution to fix Event ID 5973 that's logged when Windows Store apps can't be opened.

_Applies to:_ &nbsp; Windows 8.1  
_Original KB number:_ &nbsp; 3064045

## Symptoms

On a device that is running Windows 8.1, all Windows Store apps do not open and an error that resembles the following is logged in the Application log:

> Log Name: Application  
Source: Microsoft-Windows-Immersive-Shell  
Date: *Date and time*  
Event ID: 5973  
Task Category: (5973)  
Level: Error  
Keywords:  
User: *User ID*  
Computer: *Computer name*  
Description:  
Activation of app *AppID* failed with error: This app does not support the contract specified or is not installed. See the Microsoft-Windows-TWinUI/Operational log for additional information.

## Cause

Abnormal shutdown may corrupt the user application cache in `C:\Users\<username>\AppData\Local\Packages`.

## Resolution

To test if you have the issue, [create a new user account](https://support.microsoft.com/windows/20de74e0-ac7f-3502-a866-32915af2a34d) and sign into the new account. If the problem disappears, recreate your user profile to resolve the problem.

1. Back up the user profile data files on the old user account:

    - Swipe in from the right edge of the screen, and then tap Search. (If you're using a mouse, point to the lower-right corner of the screen, move the mouse pointer up, and then click **Search**.)
    - In the **Search** box, type *Show hidden files and folders* and press Enter.
    - In the **Folder Options** dialog, in the **View** tab, look under **Advanced settings**, and set the following settings:
      - **Show hidden files, folders, and drives** button needs to be selected.
      - **Hide extensions for known file types** needs to be unchecked.
      - **Hide protected operating system files (Recommended)** needs to be unchecked.

    - In File Explorer, locate the `C:\Users\Old_Username` folder, where C is the drive that Windows is installed on, and *Old_Username* is the name of the profile you want to back up.

    - Select and copy all of the files and folders in this folder, expect for the following files:
      - NtUser.dat
      - NtUser.ini
      - NtUser.log (or if it does not exist, instead exclude the two log files called ntuser.dat.log1 and ntuser.dat.log2)

    - Paste the files in a backup location of your choosing. You can retrieve your old user account profile from this backup location if needed, however you should be aware that the files that were under `C:\Users\<Old_Username>\AppData\Local\Packages` were likely corrupted, and there may be other files corrupted as well.

2. Sign out of the old user account. If you have e‑mail messages in an e‑mail program, you must import your e‑mail messages and addresses to the new user profile before you delete the old profile. If everything is working properly, you can delete the old profile.
