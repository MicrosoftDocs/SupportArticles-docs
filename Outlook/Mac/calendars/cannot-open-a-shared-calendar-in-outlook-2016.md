---
title: Open Shared Calendar option is unavailable
description: Describes a scenario in which you cannot open a shared calendar in Outlook 2016 for Mac. Provides several workarounds.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2016 for Mac
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 01/30/2024
---
# You can't open a shared calendar in Outlook 2016 for Mac

_Original KB number:_ &nbsp; 3007307

## Symptoms

When you open your Calendar in Microsoft Outlook 2016 for Mac, the **Open Shared Calendar** button on the ribbon is unavailable.

:::image type="content" source="media/cannot-open-a-shared-calendar-in-outlook-2016/open-shared-calendar-not-available.png" alt-text="Screenshot shows that the Open Shared Calendar button on the Calendar ribbon is unavailable.":::

Additionally, when you point to **Open** on the **File** menu, the **Calendar** option is unavailable.

:::image type="content" source="media/cannot-open-a-shared-calendar-in-outlook-2016/calendar-is-not-available.png" alt-text="Screenshot shows that the Calendar option is unavailable.":::

## Cause

This issue occurs if the **Group similar folders, such as Inboxes, from different accounts** check box is selected and the **Hide On My Computer folders** check box is cleared in **General Preferences**.

:::image type="content" source="media/cannot-open-a-shared-calendar-in-outlook-2016/clear-hide-on-my-computer-folders.png" alt-text="Screenshot shows that the Hide On My Computer folders check box is cleared in General Preferences.":::

## Workaround

To work around this issue, use one of the following methods:

- Select the Exchange folder in My Calendars.
  1. Open the calendar.
  2. Expand **My Calendars** to display the Exchange mailbox calendar, the On My Computer calendar, and calendars that are associated with any other accounts that are open in Outlook for Mac.
  3. Select the **Exchange** check box.

     :::image type="content" source="media/cannot-open-a-shared-calendar-in-outlook-2016/the-exchange-checkbox.png" alt-text="Screenshot shows that the Exchange check box is selected.":::

     After you do this, the **Open Shared Calendar** button on the ribbon is available.

- Open another user's Calendar.

  1. On the **File** menu, point to **Open**, and then select **Other Users Folder**.

     :::image type="content" source="media/cannot-open-a-shared-calendar-in-outlook-2016/other-users-folder-option.png" alt-text="Screenshot shows several options including the Other User's Folder option under Open on the File menu.":::

  2. Search for and then select the user whose calendar you want to open.
  3. In the **Folder Type** box, select **Calendar**.

     :::image type="content" source="media/cannot-open-a-shared-calendar-in-outlook-2016/open-other-user-folder.png" alt-text="Screenshot of the Open Other User's Folder window with the Calendar option selected in the Folder Type.":::

  4. Select **Open**.

- Change the preferences settings that are related to the On My Computer folders.
  1. On the **Outlook** menu, select **Preferences**.
  2. Select **General**.
  3. Clear the **Group similar folders, such as Inboxes, from different accounts** check box.
  
     > [!NOTE]
     > If you're using Outlook 2019 for Mac, clear the **Show all mail account folders** check box.

  4. If you want, select the **Hide On My Computer folders** check box.

## More information

- [The new Outlook for Mac](https://support.microsoft.com/office/6283be54-e74d-434e-babb-b70cefc77439)
- [Shared calendars in "New outlook"](https://answers.microsoft.com/en-US/msoffice/forum/all/shared-calendars-in-new-outlook/7094d0fb-5675-41fc-9ea7-d76bbe43eb97?auth=1)
- [Viewing People's Calendars in New Outlook for Mac](https://answers.microsoft.com/en-US/msoffice/forum/all/viewing-peoples-calendars-in-new-outlook-for-mac/04f94323-cf88-404a-98fe-d08ab31f32f6?auth=1)
