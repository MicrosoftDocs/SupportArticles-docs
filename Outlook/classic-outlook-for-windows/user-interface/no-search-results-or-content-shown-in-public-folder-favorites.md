---
title: No search results or content shown in favorites
description: Describes an Outlook 2016 issue in which no search results are displayed when you search public folder favorites, or no content is displayed in public folder favorites. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Rules, search and Printing\Search results
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2016
search.appverid: MET150
ms.date: 01/30/2024
---
# No search results or content displayed in public folder favorites in Outlook 2016

_Original KB number:_ &nbsp; 3169741

## Symptoms

In Microsoft Outlook 2016, you experience one of the following symptoms:

- When you search in a public folder that you have added to your favorites, no search results are returned.
- No content is displayed in a public folder that you have added to your favorites.

## Cause

This issue can occur when the option to download public folder favorites is enabled.

## Resolution

This issue is fixed in Current Channel build 16.0.7766.2060, which was released on February 23, 2017. For more information, see [Update history for Microsoft 365 Apps (listed by date)](/officeupdates/update-history-microsoft365-apps-by-date).

## Workaround

To work around this issue until the fix of Deferred Channel is available, use one of the following methods.

### Method 1 - Do not cache public folder favorites

1. In Outlook, on the **File** tab, select **Account Settings**, and then select **Account Settings**.
2. Select the Microsoft Exchange account, and then select **Change**.
3. Select **More Settings**.
4. On the **Advanced** tab, clear the **Download Public Folder Favorites** check box.
5. Select **OK**, select **Next**, select **Finish**, and then select **Close**.
6. Exit and restart Outlook.

### Method 2 - Remove public folders from your favorites

1. In Outlook, open your Folders list. To do this, select the ellipsis (**...**) in the navigation pane, and then select **Folders**.
2. Expand **Public Folders**, and then expand **Favorites**.
3. Right-click the public folder that is listed under **Favorites**, and then select **Delete Folder**.

    > [!NOTE]
    > Selecting **Delete Folder** does not delete the folder from the server. This action only removes the folder from your favorites.

4. Repeat step 3 for any public folders that you want to remove from your favorites.

### Method 3 - Revert the Office 2016 Click-to-Run installation to an earlier version

This method is a workaround for the symptom of content not being displayed in the public folder favorites folder and is not meant for the symptom of no search results.

> [!NOTE]
> To determine whether your Office installation is Click-to-Run or MSI-based, see the More Information section.

Revert the Office 2016 Click-to-Run installation to the 16.0.7070.2036 version. To do this, follow these steps.

1. Exit all Office applications.
2. Open an elevated command prompt as administrator.

    Windows 10

      1. Go to **Start**, enter **Run** in the **Search Windows** box, and then press Enter.
      2. Type *cmd* in the **Run** box, and then select **OK**.

    Windows 8 and Windows 8.1

    1. Swipe in from the right edge of the screen, and then select **Search**. If you're using a mouse, point to the lower-right corner of the screen, and then select **Search**.
    2. Enter **Run**.
    3. Type *cmd* in the **Run** box, and then select **OK**.

    Windows 7 SP1

    1. Select **Start**, type *cmd* in the **Start Search** box.
    2. Right-click **Command Prompt** or cmd.exe, and then select **Run as administrator**.
3. At the command prompt, type the following command, and then press Enter:

    ```console
    cd %programfiles%\Common Files\Microsoft Shared\ClickToRun
    ```

4. Type the following command, and then press Enter:

    ```console
    officec2rclient.exe /update user updatetoversion=16.0.7070.2036
    ```

5. When the repair dialog box appears, select **Online Repair**.
6. Select **Repair**, and then select **Repair** again.
7. After the repair is complete, start Outlook.
8. Select **File**, and then select **Office Account**.
9. In the **Product Information** column, select **Update Options**, and then select **Disable Updates**.

    > [!IMPORTANT]
    > This step is very important. The repair process re-enables automatic updates. To prevent the newest version of Office Click-to-Run from being automatically reinstalled, make sure that you follow this step.

10. Set a reminder in your calendar for a future date at which to check this article for a resolution for this issue. Enable automatic updates in Office again after this issue is fixed. Enabling automatic updates again will make sure that you don't miss future updates.

For more information about update channels for Microsoft 365 clients, see [Update history for Microsoft 365 Apps (listed by date)](/officeupdates/update-history-microsoft365-apps-by-date).

For more information about reverting to an earlier version of Office Click-to-Run, see [How to revert to an earlier version of Office](https://support.microsoft.com/help/2770432).

## Status

This issue is now fixed, per the information in the Resolution section.

## More information

To determine whether your Office installation is Click-to-Run or MSI-based, follow these steps:

1. Start Outlook.
2. On the **File** menu, select **Office Account**.
3. For Office Click-to-Run installations, an Update Options item is displayed. For MSI-based installations, the Update Options item is not displayed.

   :::image type="content" source="media/no-search-results-or-content-shown-in-public-folder-favorites/determine-office-installation.png" alt-text="Screenshot of the Office Account page for Click-to-Run and MSI-based Office installations.":::
