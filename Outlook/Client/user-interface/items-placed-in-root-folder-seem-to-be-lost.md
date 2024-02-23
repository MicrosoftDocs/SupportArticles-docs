---
title: Items placed in root folder seem to be lost
description: Provides a resolution to show the items that's placed in root folder.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: TasitaE, GregMans
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# Items placed in root folder seem to be lost in Outlook

_Original KB number:_ &nbsp; 2979451

## Symptoms

When you move items to the root folder of your mailbox, you cannot see the items in either the Folder List or the Outlook Today pane.

> [!NOTE]
> The root folder in your Outlook mailbox is the folder at the top of your folder list. In Outlook 2010 and later versions the root folder is displayed as your email address, and in Outlook 2007 the root folder is displayed as **Mailbox - username**. In the following figure the root folder is displayed as `e15user1@wingtiptoys.com`.

:::image type="content" source="media/items-placed-in-root-folder-seem-to-be-lost/sample.png" alt-text="Screenshot of the root folder in the mailbox folder list in Outlook." border="false":::

## Cause

By default, Microsoft Outlook replaces the root folder of the default messaging store with the Outlook Today feature. Therefore, when you select it you cannot see any items that you placed in the folder as the Outlook Today feature is displayed.

## Resolution Method 1 - Disable Outlook Today

To disable Outlook Today, follow these steps for your version of Outlook:

### Outlook 2010 and later versions

1. Right-click the root folder and select **Data File Properties**.
2. Select the **Home Page** tab.
3. Clear **Show home page by default for this folder**, and then select **OK**.

   :::image type="content" source="media/items-placed-in-root-folder-seem-to-be-lost/show-home-page-by-default-for-this-folder-option.png" alt-text="Screenshot of the Show home page by default for this folder option." border="false":::

4. Select the root folder to view the contents.

### Outlook 2007

1. Right-click the root folder and select **Properties for "Mailbox - username"**.

   :::image type="content" source="media/items-placed-in-root-folder-seem-to-be-lost/properties-for-mailbox.png" alt-text="Screenshot of the Properties for Mailbox - username option." border="false":::

2. Select the **Home Page** tab.
3. Clear **Show home page by default for this folder**, and then select **OK**.

   :::image type="content" source="media/items-placed-in-root-folder-seem-to-be-lost/clear-show-home-page-by-default-for-this-folder-option.png" alt-text="Screenshot of the option of Show home page by default for this folder." border="false":::

4. Select the root folder to view the contents.

> [!NOTE]
> If you prefer, you can enable Outlook Today again after you move the items from the root folder to another folder.

## Resolution Method 2 - Use Advanced Find to locate the items and move them to a different folder

To use Advanced Find to locate the items in the root folder and move them to a different folder, follow these steps for your version of Outlook:

### Outlook 2010 and later versions

1. Select the **Inbox** folder.
2. Select into the **Instant Search** bar, which will display the **Search** tab on the ribbon.
3. On the **Search Ribbon**, select **Search Tools**, and then select **Advanced Find**.
4. In the **Look for** list, select **Any type of Outlook item**.
5. Select **Browse**.
6. Select only the root folder, which is typically displayed as your email address.
7. Disable **Search subfolders**, and then select **OK**.

   :::image type="content" source="media/items-placed-in-root-folder-seem-to-be-lost/disable-search-subfolders.png" alt-text="Screenshot of the Select Folder(s) dialog box." border="false":::

8. Select **Find Now**.
9. Messages and items found will be displayed in the results window.
10. Move the items to a different folder by right-clicking them and selecting **Move**, **Other Folder**, selecting the intended folder, and then select **OK**.

### Outlook 2007

1. Select the **Tools** menu, then select **Instant Search**, and then select **Advanced Find**.
2. In the **Look for** list, select **Any type of Outlook item**.
3. Select **Browse**.
4. Select only the root folder, which is typically displayed as **Mailbox - \<your username>**.
5. Disable **Search subfolders**, and then select **OK**.

   :::image type="content" source="media/items-placed-in-root-folder-seem-to-be-lost/disable-search-subfolders.png" alt-text="Screenshot of the Select Folder(s) dialog box in Outlook 2007." border="false":::

6. Select **Find Now**.
7. Messages and items found will be displayed in the results window.
8. Move the items to a different folder by right-clicking them and selecting **Move to Folder**, selecting the intended folder, and then select **OK**.

