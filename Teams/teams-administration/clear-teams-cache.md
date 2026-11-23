---
title: Clear the Teams client cache
description: Clear the Teams client cache in minutes with these guided steps for Windows and macOS. Discover which issues cache clearing fixes and which ones it won't resolve.
#customer intent: As a Teams user experiencing app issues, I want to clear the Teams client cache, so that I can restore normal app behavior.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Admin\
  - CI160649
  - CI184319
  - CSSTroubleshoot
ms.reviewer: hdonald, corbinm, sreeps, v-kccross
appliesto: 
  - Classic Microsoft Teams
  - New Microsoft Teams
search.appverid: 
  - MET150
ms.date: 09/14/2026
---
# Clear the Teams client cache

## Summary

This article lists the types of issues for which you shouldn't clear the Teams cache and provides the steps to delete the cache both in Teams for Windows and Teams for Mac when appropriate. 

## Is clearing the Teams cache the right option to resolve your issue?

> [!IMPORTANT]
> We don't recommend that you clear the cache for issues with Microsoft Teams chats or channels such as missing messages, chat history not loading, a channel or team not appearing, or notifications and unread counts being wrong. Clearing the Teams cache doesn't fix these issues but deletes the diagnostic logs that are needed to find the cause.

You can clear the Teams cache as a targeted step for a small number of problems with the local client. However, it is not a general first step for all issues that you see in the Teams app. After you clear the cache, restart Teams. The restart process after you clear the cache might take longer than usual because the Teams cache files have to be rebuilt.

## Clear the cache in Teams for Windows

### Classic Teams

1. If Teams is still running, right-click the Teams icon on the taskbar, and then select **Quit**.
1. Open the **Run** dialog box by pressing the Windows logo key :::image type="icon" source="media/clear-teams-cache/windows-logo-key.png"::: +R.
1. In the **Run** dialog box, enter the following path, and then select **OK**:

   ```console
   %appdata%\Microsoft\Teams
   ```

1. Delete all files and folders in the directory.
1. Restart Teams.

### New Teams

#### Method 1: Reset the app

> [!NOTE]
> When you reset the Teams app, the app data is deleted. This data includes any personalization settings that you configured.

1. Type *settings* in the search box, and then select the **Settings** app from the results.
1. Select **Apps** > **Installed apps**, and then type *Microsoft Teams* in the search box.
1. Locate the New Microsoft Teams app from the results, select the **More options** button (...) on the right, and then select **Advanced options**.
1. In the **Reset** section, select **Reset**.
1. Restart Teams.

#### Method 2: Delete the files

1. If Teams is still running, right-click the Teams icon on the taskbar, and then select **Quit**.
1. Open the **Run** dialog box by pressing the Windows logo key :::image type="icon" source="media/clear-teams-cache/windows-logo-key.png"::: +R.
1. In the **Run** dialog box, enter the following path, and then select **OK**.

   ```console
   %userprofile%\appdata\local\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams
   ```

1. Delete all files and folders in the directory.
1. Restart Teams.

## Clear the cache in Teams for macOS

### Classic Teams

1. If Teams is still running, right-click the Teams icon in the dock, and then select **Quit** or press Command (⌘)-Q.
1. In the **Finder**, open the /Applications/Utilities folder, and then double-click **Terminal**.
1. Enter the following command, and then press Return:

   ```console
   rm -r ~/Library/Application\ Support/Microsoft/Teams
   ```

1. Restart Teams.

### New Teams

1. If Teams is still running, right-click the Teams icon in the dock, and then select **Quit** or press Command (⌘)-Q.
1. In the **Finder**, open the /Applications/Utilities folder, and then double-click **Terminal**.
1. Enter the following commands, and press Return after each command:

   ```console
   rm -rf ~/Library/Group Containers/UBF8T346G9.com.microsoft.teams
   rm -rf ~/Library/Containers/com.microsoft.teams2
   ```

1. Restart Teams.
