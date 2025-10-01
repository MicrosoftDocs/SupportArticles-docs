---
title: Outlook 2016 for Mac freezes on email folders
description: Discusses a problem in which Outlook 2016 for Mac freezes on email folders that contain several encrypted messages. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Errors, Crashes, and Performance
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2016 for Mac
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook 2016 for Mac freezes on email folders that contain several encrypted messages

_Original KB number:_ &nbsp; 3172627

## Symptoms

In Outlook 2016 for Mac, when you navigate to a folder in which several encrypted email messages are displayed in the message list, Outlook freezes or experiences other performance issues.

## Resolution

To fix this issue, update Outlook 2016 for Mac to version 15.23 or a later version. Then, disable the preview feature for encrypted email messages by running a command in Terminal. To do this, follow these steps.

### Step 1: Check the Outlook for Mac version number

1. On the Outlook menu, select **About Outlook**.
2. View the version number that is listed.
3. If your Outlook installation is not at version 15.23 or a later version, install the June 14, 2016, update for Outlook 2016 for Mac or a later update. For information about this update, see [MS16-070: Description of the security update for Office 2016 for Mac: June 14, 2016](https://support.microsoft.com/help/3165798/ms16-070-description-of-the-security-update-for-office-2016-for-mac-ju).

### Step 2: Disable the preview feature

1. Exit Outlook.
2. Open **Terminal** by using one of the following methods:

   - Make sure that **Finder** is the selected application, select **Utilities** on the **Go** menu, and then double-click **Terminal**.
   - In **Spotlight Search**, type *Terminal*, and then double-click **Terminal** in the search results.

3. Type the following commands in **Terminal**, and press Enter after each line:

    ```console
    defaults write com.microsoft.Outlook DisablePreviewForSMIME 1

    killall cfprefsd
    ```

4. Exit **Terminal**.
5. Start Outlook.
