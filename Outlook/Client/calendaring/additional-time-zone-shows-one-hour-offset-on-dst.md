---
title: Multiple time zones show an incorrect time difference when DST starts and ends
description: Provides a workaround for an issue in which multiple time zones on the Calendar time bar show an incorrect time difference on DST start and end days.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendar\Other
  - CSSTroubleshoot
  - CI 1948
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2024
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
  - New Outlook for Windows
  - Outlook on the web
search.appverid: MET150
ms.reviewer: brrogers, laboro, randyto, meerak, v-shorestris
author: cloud-writer
ms.author: meerak
ms.date: 10/25/2024
---

# Multiple time zones show an incorrect time difference when DST starts and ends

## Symptoms

Consider the following scenario:

- You use the [multiple time zones](https://support.microsoft.com/office/manage-time-zone-settings-in-outlook-65239869-12e7-4a9d-bca1-76b0ad7ce273#ID0EDFBBFBBF) feature in Microsoft Outlook to display a primary and a secondary time zone on the time bar in your Calendar.

- You use a Calendar view that displays the time bar.

- Daylight saving time (DST) begins or ends on different dates in each time zone, or DST isn't observed in one of the time zones.

For this scenario, on the first and last day of DST in either time zone, you notice both of the following symptoms:

- The time difference between the primary and secondary time zones in the time bar doesn't reflect the DST change.

- Calendar events that are scheduled on the day when DST starts or ends, and on any subsequent day in your Calendar view, are shown as scheduled for the wrong time.

> [!NOTE]
> If the Calendar time bar displays more than two time zones, this issue affects all displayed time zones.

### Example

Your Calendar displays the **Week** view. The first day of that view is Sunday. The primary time zone in your Calendar is **(UTC-05:00) Eastern Time (US & Canada)**, and the secondary time zone is **(UTC+00:00) (Dublin, Edinburgh, Lisbon, London)**.

On the day that DST starts in the **(UTC-05:00) Eastern Time (US & Canada)** time zone (for example, on Sunday, March 10, 2024), you notice that the time bar incorrectly shows a five-hour difference between the time zones. Calendar events on all days in the **Week** view are shown as scheduled for the wrong time (for example, a 12 PM **(UTC+00:00) (Dublin, Edinburgh, Lisbon, London)** meeting might align with 1 PM in the time bar).

In the following week's view (for example, the week that starts on Sunday, March 17, 2024), you notice that the time bar correctly shows a four-hour time difference between the time zones. Calendar events on all days in the view are shown as scheduled for the correct time.

## Workaround

Select either of the following workarounds:

- Use a Calendar view in which the days when DST starts and ends aren't displayed in the view. For example, if DST starts and ends on Sundays, and your work week is Monday through Friday, use the **Work Week** view.

- For users of the new Outlook for Windows or Outlook on the web, the following workaround is also possible:

   If the days when DST starts and ends are Sundays, and the first day of your **Week** view is Sunday, you can use the **Week** view to avoid the issue.

   > [!NOTE]
   > This additional workaround for the new Outlook for Windows and Outlook on the web is being rolled out gradually and might not be released in your organization yet.

> [!TIP]
> The DST start and end days for most regions around the world are Sundays.
