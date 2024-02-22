---
title: Contents of Public Folder Favorites folder not removed
description: Explains that the Public Folder Favorites folder still has contents even if the Download Public Folder Favorites option is turned off in Outlook. You must manually clear the items from your local folders to work around this problem.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: shanw
appliesto: 
  - Outlook 2007
  - Outlook 2003
search.appverid: MET150
ms.date: 10/30/2023
---
# Contents of Public Folder Favorites folder not removed from offline folder files if Download Public Folder Favorites is turn off

_Original KB number:_ &nbsp; 822507

## Symptoms

If you turn off the **Download Public Folder Favorites** option in Microsoft Outlook 2003 or in Outlook 2007, the contents of the Public Folder Favorites folder are not removed from your offline folder files (`.ost`).

## Cause

This behavior occurs because all future synchronization stops when you turn off the **Download Public Folder Favorites** option. This prevents the `.ost` from receiving new files and growing larger, but it does not remove the files that have already been downloaded.

## Workaround

To work around this behavior, turn off the **Download Public Folder Favorites** option, and then clear offline items from each Public Folder Favorite folder that is in your `.ost` file. To do this, follow these steps:

1. Start Outlook.
2. Select **Tools**, select **E-Mail Accounts**, select **View or change existing e-mail accounts**, and then select **Next**.
3. In the **Name** list, select your Microsoft Exchange server, and then select **Change**.
4. Select **More Settings**, and then select the **Advanced** tab.
5. Under **Cached Exchange Mode Settings**, clear the **Download Public Folder Favorites** check box, and then select **OK**.
6. In the Outlook navigation pane, right-click a Public Folder Favorites folder, and then select **Properties**.
7. On the **General** tab, select **Clear Offline Items**.
8. Repeat steps 6 and 7 for each Public Folder Favorites folder that you want to clear.
