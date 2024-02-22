---
title: Send Update button is missing when you import or copy Outlook meetings
description: If you migrate or copy Outlook calendar meetings, you lose the option to Send Update. This article discusses why the GlobalObjectID isn't kept when you import or copy an Outlook meeting. Additionally, it details how the Copy prefix is added to the subject line of a copied meeting.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: laurentc
appliesto: 
  - Microsoft Office Outlook 2003
  - Microsoft Office Outlook 2007
  - Microsoft Outlook 2010
  - Exchange Online
search.appverid: MET150
ms.date: 10/30/2023
---
# How to move Outlook meetings without losing the option to send update

_Original KB number:_ &nbsp;2167170

## Symptoms

You use Microsoft Office Outlook 2003, Microsoft Office Outlook 2007, or Microsoft Outlook 2010 to import or copy meetings to your mailbox. When you open a meeting, you notice that the **Send Update** button is missing. Additionally, newer versions of Outlook add the prefix "Copy:" to the meeting subject, and the Info Bar shows the following message:

> This meeting was copied to your calendar and will not receive updates. To receive updates, contact the organizer, **organizer_name**.

In this message, **organizer_name** represents the name of the meeting organizer.

> [!NOTE]
> If you originally created the meeting that was imported, your name appears here. In that case, this seems to be counterintuitive because you're viewing the meeting in your own calendar.

## Cause

When meetings are exported to or imported from an Outlook Personal Folder or Outlook Data (.pst) file, the `GlobalObjectID` (GOID) property of the meeting isn't included. When you copy and paste meetings from one calendar to another, Outlook generates new `GlobalObjectID` values for the meetings that are newly created.

The `GlobalObjectID` is a unique identifier for a meeting. All meeting invitations, responses, and updates that are associated with any single meeting contain the same `GlobalObjectID`. Outlook doesn't create meetings that have duplicate `GlobalObjectID` properties. To do this, Outlook excludes the property during import and export and generates a new `GlobalObjectID` value when a meeting is copied. This prevents anyone who imported or copied your meetings from assuming the organizer role and sending updates for meetings that you own.

## Resolution

To maintain the full meeting functionality as the meeting organizer, move meetings from one calendar folder to another. To move a meeting or series of meetings, use the cut-and-paste method. Because the original meeting is deleted, as soon as the paste process is complete, the meeting no longer exists in the original location. Because the meeting that's pasted to the new location is unique, the `GlobalObjectID` value is maintained.

To move all the Calendar items to another folder, you must first display all the items in a tabular view. To display the items in the folder in a tabular view, use one of the following methods:

- Temporarily clear the filter from an existing tabular view.
- Define a new and permanent tabular view of all calendar items.

### How to clear the filter from an existing tabular view

#### For Outlook 2010

1. Click to select the calendar folder that contains the meetings that you want to move.
1. On the **View** tab, click **Change view**, and then click to select one of the tabular views such as **By List** or **By Category**.
1. On the **View** menu, click **Reset View**.
1. Click **Yes** to reset the view to the original settings.

#### For Outlook 2007 and Outlook 2003

1. Click to select the Outlook calendar folder that contains the meetings you want to move.
2. On the **View** menu, point to **Current View**, and then click to select one of the tabular views such as **Events** or **By Category**.
3. On the **View** menu, point to **Current View**, and then click **Customize Current View**.
4. In the **View Summary** dialog box, click **Filter** > **Clear All** > **OK**, and then click **OK** again.

### How to define a new and permanent tabular view

#### For Outlook 2010

1. Click to select the calendar folder that contains the meetings that you want to move.
1. On the **View** tab, click **Change view** > **Manage Views** > **New**.
1. Type a name for the new view, click to select **Table**, and then click **OK**.
1. In **Advanced View Settings**, click **Sort**.
1. In the **Sort items by** list, click to select **Start and Ascending**.
1. In the **Then By** list, click to select **(none)**, and then click **OK**.
1. Click **OK** > **Apply View**.

Both of these procedures will display a list of all calendar items.

After all items are displayed, follow these steps:

1. To select all items, use the keyboard shortcut, Ctrl+A.
    > [!NOTE]
    > If you only want to copy specific meetings, hold the Ctrl key, and then click to select individual meetings.
2. To copy and then delete the items, use the keyboard shortcut, Ctrl+X.
3. Click to select the destination calendar folder.
4. To paste the items, use the keyboard shortcut, Ctrl+V.

This process moves the selected calendar items into the destination folder.

#### For Outlook 2007 and for Outlook 2003

1. Click to select the calendar folder that contains the meetings that you want to move.
2. On the **View** menu, point to **Current View**, click **Define Views** > **New**.
3. Type a name for the new view, click to select **Table**, and then click **OK**.
4. In **View Summary**, click **Sort**.
5. In the **Sort items by** list, click to select **Start**, and then click **Ascending**.
6. In the **Then By** list, click to select **(none)**, and then click **OK**.
7. Click **OK** > **Apply View**.

Both of these procedures will display a list of all calendar items.

After all items are displayed, follow these steps:

1. On the **Edit** menu, click **Select All**.
2. On the **Edit** menu, click **Cut**.
3. Click to select the destination folder.
4. On the **Edit** menu, click **Paste**.

This process moves the selected calendar items into the destination folder.

## More information

You can also drag the meetings by holding down the right mouse button. When you drop the meetings in the wanted target calendar, select the **Move** option from the shortcut menu.

For more information about the `GlobalObjectID` property, visit the Microsoft MSDN website: [3.1.4.3 Copying a Calendar Object](https://msdn.microsoft.com/library/ee201844%28v=exchg.80%29.aspx).
