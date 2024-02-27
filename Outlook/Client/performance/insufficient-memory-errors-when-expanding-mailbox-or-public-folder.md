---
title: Insufficient memory errors and sent mail stuck
description: Describes an issue that occurs when you have lots of cached public folders.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: meshel, laurentc, aruiz
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# You receive insufficient memory errors when you expand a mailbox or public folder in Outlook
  
_Original KB number:_ &nbsp; 2968387

## Symptoms

When you expand a mailbox or public folder (except for the Inbox) in Microsoft Outlook or select **Address Book** on the toolbar, you may receive one of the following errors:

> Cannot display the folder. There is not enough free memory to run this program. Quit one or more programs, and then try again.

> Cannot expand the folder. There is not enough memory available to perform the operation.

> The address list could not be accessed. You need more memory or system resources. Close some windows and try again.

When you receive one of these errors, outgoing mail may become stuck in the Outbox folder and may not be sent until you restart Outlook.

## Cause

This problem occurs when your Outlook messaging profile includes a Microsoft Exchange account that is configured to use Cached Exchange Mode, the **Download Public Folder Favorites** option is enabled, and you have lots of cached public folders. Usually, this problem occurs when you have more than approximately 1,000 public folders, or when the cached public folders consume one gigabyte of space.

## Resolution

To prevent this problem, either disable the **Download Public Folder Favorites** option, or keep the number of cached public folders favorites to fewer than 1,000. If the issue continues to occur with fewer than 1,000 public folder favorites, reduce the number of folders until you stop receiving the error or errors. You can typically reduce the number of public folder favorites by deleting them by using the Outlook client. However, in some cases in which you have too many public folder favorites, you may be unable to delete the folders by using the Outlook client because the error occurs when you select the public folder Favorites folder. If this occurs, you can delete the public folder favorites by using MFCMapi instead.

To resolve this issue by disabling the **Download Public Folder Favorites** option, follow these steps:

1. In Outlook, select **File**, select **Account Settings**, and then select **Account Settings**.
2. Select your Microsoft Exchange account, and then select **Change**.
3. Select **More Settings**.
4. On the **Advanced** tab, clear the **Download Public Folder Favorites** check box.
5. Select **OK**.

6. You are prompted to restart Outlook for these changes to take effect. Select **OK**.
7. Select **Next**, select **Finish**, and then select **Close**.
8. Exit Outlook, and then restart Outlook.

To delete the public folder favorites by using MFCMapi, follow these steps:

1. Download [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/).
2. Run MFCMAPI.exe.
3. On the **Session** menu, select **Logon**.
4. Select your Outlook profile name, and then select **OK**.
5. In the top pane, locate the line that corresponds to your mailbox, and then double-click it.
6. In the navigation pane (left-side pane), expand **Root - Mailbox**, and then select the Shortcuts folder.
7. In the details pane (right-side pane), locate the PR_FOLDER_CHILD_COUNT properties. The **Value** column contains the number of public folder favorites.
8. If you want to delete all your public folder favorites, follow these steps:

   1. In the navigation pane. right-click the Shortcuts folder, select **Advanced**, and then select **Empty items and subfolders from folder**.

      :::image type="content" source="media/insufficient-memory-errors-when-expanding-mailbox-or-public-folder/empty-items-and-subfolders-from-folder.png" alt-text="Screenshot of  the Empty items and subfolders from folder option in the right-click menu.":::

   2. Keep the default options, and then select **OK**.
9. If you want to delete specific public folder favorites, follow these steps:
   1. In the navigation pane, expand the Shortcuts folder, right-click the Public Folder favorite that you want to delete, and select **Delete folder**.

      :::image type="content" source="media/insufficient-memory-errors-when-expanding-mailbox-or-public-folder/delete-folder.png" alt-text="Screenshot of the Delete folder option in the right-click menu.":::

   2. Keep the default options, and then select **OK**.
