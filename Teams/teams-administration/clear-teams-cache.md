---
title: Clear Teams cache
description: Describes how to clear the Microsoft Teams client cache on Windows and macOS devices.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI160649
  - CI184319
  - CSSTroubleshoot
ms.reviewer: hdonald, lehill, corbinm
appliesto: 
  - Classic Microsoft Teams
  - New Microsoft Teams
search.appverid: 
  - MET150
ms.date: 12/04/2023
---
# Clear the Teams client cache

If you're experiencing issues that affect Microsoft Teams, clearing the cache on your device may help. After you clear the cache, restart Teams.

> [!NOTE]
> Restarting Teams after you clear the cache might take longer than usual because the Teams cache files have to be rebuilt.

## Clear Teams cache in Windows

### Classic Teams

1. If Teams is still running, right-click the Teams icon in the taskbar, and then select **Quit**.
1. Open the **Run** dialog box by pressing the Windows logo key :::image type="icon" source="media\clear-teams-cache\windows-logo-key.png"::: +R.
1. In the **Run** dialog box, enter *%appdata%\Microsoft\Teams*, and then select **OK**.
1. Delete all files and folders in the %appdata%\Microsoft\Teams directory.
1. Restart Teams.

### New Teams

#### Method 1: Reset the app

> [!NOTE]
> The app's data will be deleted by resetting the app.

1. Type *settings* in the search box, and then select the **Settings** app from the result.
1. Select **Apps** > **Installed apps**, and then type *Microsoft Teams* in the search box.
1. Locate the New Microsoft Teams app from the result, select the three dots (...), and then select **Advanced options**.
1. Under the **Reset** section, select **Reset**.
1. Restart Teams.

#### Method 2: Delete the files

1. If Teams is still running, right-click the Teams icon in the taskbar, and then select **Quit**.
1. Open the **Run** dialog box by pressing the Windows logo key :::image type="icon" source="media\clear-teams-cache\windows-logo-key.png"::: +R.
1. In the **Run** dialog box, enter the following path, and then select **OK**.

   ```console
   %userprofile%\appdata\local\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams
   ```

1. Delete all files and folders in the directory.
1. Restart Teams.

## Clear Teams cache in macOS

### Classic Teams

1. If Teams is still running, right-click the Teams icon in the dock, and then select **Quit**, or press Command (⌘)-Q.
1. In the **Finder**, open the /Applications/Utilities folder, and then double-click **Terminal**.
1. Enter the following command, and then press Return:

   ```console
   rm -r ~/Library/Application\ Support/Microsoft/Teams
   ```

1. Restart Teams.

### New Teams

1. If Teams is still running, right-click the Teams icon in the dock, and then select **Quit**, or press Command (⌘)-Q.
1. In the **Finder**, open the /Applications/Utilities folder, and then double-click **Terminal**.
1. Enter the following commands. Press Return after each command.

   ```console
   rm -rf ~/Library/Group Containers/UBF8T346G9.com.microsoft.teams
   rm -rf ~/Library/Containers/com.microsoft.teams2
   ```

1. Restart Teams.
