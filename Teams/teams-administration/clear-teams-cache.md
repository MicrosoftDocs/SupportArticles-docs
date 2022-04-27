---
title: Clear Teams cache
description: Describes how to clear the Microsoft Teams client cache on Windows and macOS devices.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CI 160649, CSSTroubleshoot
ms.reviewer: hdonald, lehill
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 3/31/2022
---
# Clear the Teams client cache

If you're experiencing issues that affect Microsoft Teams, clearing the cache on your device may help. After you clear the cache, restart Teams.

> [!NOTE]
>
> - You won't lose any user data by clearing the cache.
> - Restarting Teams after you clear the cache might take longer than usual because the Teams cache files have to be rebuilt.

## Clear Teams cache in Windows

1. If Teams is still running, right-click the Teams icon in the taskbar, and then select **Quit**.
2. Open the **Run** dialog box by pressing the Windows logo key :::image type="icon" source="media\clear-teams-cache\windows-logo-key.png"::: +R.
3. In the **Run** dialog box, enter *%appdata%\Microsoft\Teams*, and then select **OK**.
4. Delete all files and folders in the %appdata%\Microsoft\Teams directory.
5. Restart Teams.

## Clear Teams cache in macOS

1. If Teams is still running, right-click the Teams icon in the dock, and then select **Quit**, or press Command (⌘)-Q.
2. In the **Finder**, open the /Applications/Utilities folder, and then double-click **Terminal**.
3. Enter the following command, and then press Return:

   ```console
   rm -r ~/Library/Application\ Support/Microsoft/Teams
   ```

4. Restart Teams.
