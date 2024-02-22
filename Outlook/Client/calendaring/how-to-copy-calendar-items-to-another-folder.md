---
title: How to copy Calendar items to another folder
description: This article provides steps about how to copy Outlook Calendar items from one folder to another folder.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
search.appverid: MET150
ms.date: 10/30/2023
---
# How to copy Outlook Calendar items from one folder to another

_Original KB number:_ &nbsp; 197038

## Summary

In Microsoft Office Outlook, you cannot copy all the items in a Calendar folder when you right-click the folder, select **Copy Calendar**, and then you paste in another top-level folder. Instead, this method creates a new subfolder under the destination folder.

To copy all of the items from a Calendar folder to another folder, you must select each item and then copy and paste it to the target folder.

## More information

To copy all the Calendar items to another folder, you must first display all the items in a tabular view.

To display the items in the folder in a tabular view, use one of the following methods:

- Temporarily clear the filter from an existing tabular view.
- Define a new permanent, tabular view of all calendar items.

### For Outlook 2010 and Outlook 2013

#### Clearing the filter from an existing view

To clear the filter from an existing tabular view, follow these steps:

1. Select the **Outlook Calendar** folder.
2. On the **View** tab, select **Change View**, and then select one of the tabular views such as **List** or **Active**.
3. On the **View** menu, select **Reset View**.
4. Select **Yes** to reset the view to the original settings.

#### Defining a new tabular view

To define a new permanent tabular view, follow these steps:

1. Select the **Calendar** folder.
2. On the **View** tab, select **Change View**, select **Manage Views**, and then select **New**.
3. Type a name for the new view, select **Table**, and then select **OK**.
4. In **Advanced View Settings**, select **Sort**.
5. In the **Sort items by** list, select **Start and Ascending**.
6. In the **Then By** list, select **(none)**, and then select **OK**.
7. Select **OK**, and then select **Apply View**.

Either of the previous procedures will display a list of all Calendar items.

After all items are displayed, follow these steps:

1. To select all items, use the keyboard shortcut, Ctrl+A.
2. To copy the items, use the keyboard shortcut, Ctrl+C.

3. Select the destination folder.
    > [!NOTE]
    > To paste the items correctly, the destination folder must be a calendar folder.

4. To paste the items, use the keyboard shortcut, Ctrl+V.

This process inserts a copy of all the Calendar items into the destination folder.

#### Additional option for Outlook 2010 and Outlook 2013

1. On the **Folder** tab, select **Copy Calendar**.
2. Select the folder location where you want the calendar to be saved, and then select **OK**.

> [!NOTE]
> To copy the items correctly, the destination folder must be a calendar folder.

### For Outlook 2007, Outlook 2003, Outlook 2002, and Outlook 2000

#### Clearing the filter from an existing view

To clear the filter from an existing tabular view, follow these steps:

1. Select the Outlook Calendar folder.

2. On the **View** menu, point to **Current View**, and then select one of the tabular views such as **Events** or **By Category**.

3. On the **View** menu, point to **Current View**, and then select **Customize Current View**.

4. In the **View Summary** dialog box, select **Filter**, select **Clear All**, and then select **OK** twice.

#### Defining a new tabular view

To define a new permanent, tabular view, follow these steps:

1. Select the **Calendar** folder.

2. On the **View** menu, point to **Current View**, select **Define Views**, and then select **New**.

3. Type a name for the new view, select **Table**, and then select **OK**.

4. In **View Summary**, select **Sort**.

5. In the **Sort items** by list, select **Start** and **Ascending**.

6. In the **Then By** list, select **(none)**, and then select **OK**.

7. Select **OK**, and then select **Apply View**.

Either one of the previous procedures will display a list of all Calendar items.

After all items are displayed, follow these steps:

1. On the **Edit** menu, select **Select All**.

2. On the **Edit** menu, select **Copy**.

3. Select the destination folder.

4. On the **Edit** menu, select **Paste**.

This process inserts a copy of all the Calendar items into the destination folder.

## References

For more information about defining views, select **Microsoft Outlook Help** on the **Help** menu, type Views in the Office Assistant or the Answer Wizard, and then select **Search** to the view the topics returned.
