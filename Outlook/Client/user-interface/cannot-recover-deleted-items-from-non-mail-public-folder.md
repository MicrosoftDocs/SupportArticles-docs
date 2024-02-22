---
title: Cannot recover deleted items from non-mail public folder
description: Discusses an issue in which the Recover Deleted Items option does not appear in Outlook. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# You can't recover deleted items from a non-mail public folder in Outlook 2016

_Original KB number:_ &nbsp; 4010160

## Symptoms

When you try to recover deleted items from a non-mail public folder (such as a calendar public folder or a contacts public folder) in Microsoft Outlook 2016, the **Recover Deleted Items** option does not appear in the following situations:

- You right-click the public folder.
- You select the **Folder** tab on the Outlook ribbon.

## Cause

This behavior is by design. In Outlook 2010 or later versions, the **Recover Deleted Items** option is removed from the **Folder** tab on the ribbon for non-mail public folders. In Outlook 2016, the **Recover Deleted Items** option is also removed from the shortcut menu.

## Workaround

To recover deleted items from a non-mail public folder, you can add the **Recover Deleted Items** action by customizing either the [Quick Access Toolbar](https://support.microsoft.com/office/customize-the-quick-access-toolbar-43fff1c9-ebc4-4963-bdbd-c2b6b0739e52) or the [ribbon](https://support.microsoft.com/office/customize-the-ribbon-in-office-00f24ca7-6021-48d3-9514-a31a460ecb31) in Outlook 2016, as follows.

### Customize the Quick Access Toolbar

To add the **Recover Deleted Items** command to the Quick Access Toolbar, follow these steps:

1. Select **File** > **Options** > **Quick Access Toolbar**.
2. On the **Choose commands from** menu, select **All Commands**.
3. Select **Recover Deleted Items** > **Add**.

    > [!NOTE]
    > Don't add the **Recover Deleted Items from Server** command. This command is unavailable (dimmed) for non-mail public folders.

### Customize the ribbon

To add the **Recover Deleted Items** command to the ribbon, you must either add a group to an existing tab or create a tab that has a new group. In these steps, a new group is added to the **Folder** tab. To add the command, follow these steps:

1. Select **File** > **Options** > **Customize Ribbon**.
2. In the details pane, select the **Folder** tab, and then select **New Group**.

    > [!NOTE]
    > This creates **New Group (Custom)**.

3. Press and hold (or right-click) the **New Group (Custom)** group, select **Rename**, and then enter a name (such as **Recover**).
4. In the **Choose commands from** list, select **All Commands**.
5. Select **Recover Deleted Items** > **Add**.

    > [!IMPORTANT]
    > Don't add the **Recover Deleted Items from Server** command. The command is unavailable (dimmed) for non-mail public folders.
