---
title: Cannot open a shared calendar
description: Describes an issue in which you cannot open one or more shared calendars in Outlook for Mac. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendar
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: tasitae, tsimon
appliesto: 
  - Outlook 2016 for Mac
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 01/30/2024
---
# You cannot open a shared calendar in Outlook for Mac

_Original KB number:_ &nbsp; 2743766

## Symptoms

When you have access to multiple shared Calendar folders, you cannot open one or more of the shared Calendar folders in Outlook 2016 for Mac or Outlook for Mac 2011.

## Cause

In Outlook 2016 for Mac and Outlook for Mac 2011, you cannot open a shared Calendar folder that is not a subcalendar of the user's shared default Calendar folder.

For example, a user shares the following Calendar folders with you:

- Calendar
- Second Calendar
- Third Calendar

:::image type="content" source="media/cannot-open-shared-calendar/third-calendar.png" alt-text="Screenshot of the Third Calender folder in the left pane in Outlook." border="false":::

In this example, the Second Calendar folder is a subcalendar of the user's shared default Calendar folder. Therefore, you can open the Second Calendar folder in Outlook for Mac. However, the Third Calendar folder is not a subcalendar under the default Calendar folder. Therefore, you cannot open this folder in Outlook for Mac.

## Resolution

To resolve this issue, have the calendar owner create all shared calendars under the default Calendar folder.
