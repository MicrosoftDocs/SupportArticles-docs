---
title: How time zone normalization works
description: This article introduces how time zone normalization works in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendar\Meetings are off by one hour (DST related)
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans, jel, sercast
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 03/19/2025
---
# How time zone normalization works in Microsoft Outlook

_Original KB number:_ &nbsp; 2642044

Although *time* may seem like a simple human concept that lets everyone across the globe receive a meeting request and then attend the meeting at the same time, the concept is actually very complex. This article describes how Microsoft Outlook 2010 and later versions achieve this goal by using a combination of items such as Coordinated Universal Time (UTC), time zone offset, daylight saving time (DST) rules, and Windows time zone settings.

Before we examine the details of how time zone normalization works in Outlook, it is important to define some important terms.

- UTC

    UTC signifies Coordinated Universal Time. Think of this as the true time on planet Earth that *never* changes (except for minor leap seconds here and there to account for changes in the planet's rotation).

    For more information about UTC, see [Coordinated Universal Time](https://en.wikipedia.org/wiki/Coordinated_Universal_Time).

- Time zone offset

  Time zone offset is the time for your geographic region in relation to UTC. For example, the Pacific Time zone is 8 hours behind UTC. Therefore, if it is 8 P.M. UTC, the time in the Pacific Time zone is noon.

- Daylight saving time rules

  Daylight saving time rules are the rules by which certain regions seasonally change their time zone offset. These rules include both a start date and an end date for the DST period and also the number of hours for the time zone offset. For example, in the summer, the time in the Pacific Time Zone may be calculated as UTC ‒ 7 hours, whereas for the rest year, the time is calculated as UTC ‒ 8 hours.

- Windows global time zone database

    Windows stores all time zone and DST rules for the whole planet in the Windows global time zone database. The database is stored in the Windows registry under the following subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones`

- Windows current time zone settings

    Windows current time zone settings are the settings Windows is currently using to determine the time for your computer. Of all the rules in the Windows global time zone database, only one set of DST rules can be applied. The Windows current time stores the set of rules that is currently being used to calculate time on your computer.

  The Windows current time zone settings are stored in the Windows registry under the following subkey:

  `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation`

- Computer time

    Computer time is the actual time that is displayed by Windows, as seen in the following screenshot of the notification area.

    :::image type="content" source="media/how-time-zone-normalization-works-in-outlook/notification-area-in-windows.png" alt-text="Screenshot of the notification area in the task bar." border="false":::

    If you select this part of the Windows notification area, an enhanced calendar and clock are displayed.

    :::image type="content" source="media/how-time-zone-normalization-works-in-outlook/enhanced-calendar-and-clock.png" alt-text="Screenshot that shows an enhanced calendar and clock." border="false":::

    You can select Change date and time settings to examine the current time zone settings for your computer (Screenshot for this step is listed below).

    :::image type="content" source="media/how-time-zone-normalization-works-in-outlook/date-and-time.png" alt-text="Screenshot of the Date and Time settings dialog box." border="false":::

### How computer time is calculated

Computer time is calculated by taking UTC time, adding an offset that is based on the time zone configured for your computer, and then optionally adjusting the offset for daylight saving time (depending on the DST rules). The formula that is used to calculate computer time is as follows:

UTC + Time zone offset + DST offset

Be aware that this method represents how people have agreed to think about the concept of time. This method is a world standard, and it is how Microsoft implements time on your computer.

### How Outlook handles time zone offset and DST rules in calendar items

It might seem like a simple task to make sure that two people who have the same meeting request attend the meeting at the same time. However, when you add scenarios in which time zones are changing with different daylight saving time rules, the calculation becomes complex.

To see how Outlook handles this situation, consider the following scenario:

- The meeting organizer has the following Windows current time zone settings:

  Pacific Time zone (UTC‒8; DST starts on March 13, 2011; DST ends on November 6, 2011)

- The meeting attendee has the following Windows current time zone settings:

  Eastern Time zone (UTC‒5; DST starts on March 13, 2011; DST ends on November 6, 2011)

- The meeting organizer is creating a meeting on their calendar for November 20, 2011, at 7 A.M.

#### Step 1 - Organizer sends meeting request with time zone information

On the organizer's computer, the meeting in the request is created to start at 7 A.M.

On the organizer's computer, Outlook sends the meeting request. The request contains the following information in the message properties:

> Meeting is at 3 P.M. UTC on November 20, 2011  
> My time zone is Pacific (UTC‒8)  
> DST starts on March 13, 2011, DST ends on November 6, 2011, and the offset is +1

After the meeting is created, the government mandates a new law according to which, in the Pacific Time Zone, DST starts on February 2, 2011, and ends on December 1, 2011. Because there are new time zone rules, and the appointment falls in the time period in which a new time zone rule is applied, normalization occurs (steps 2 and 3). This normalization is depicted in the following figure.

:::image type="content" source="media/how-time-zone-normalization-works-in-outlook/normalization-figure.png" alt-text="Figure of the timeline of normalization.":::

#### Step 2 - Attendee's Outlook determines intended local time

On the attendee's computer, Outlook calculates the intended *local* time of the meeting based on the information that is included the meeting request:

Intended local time = UTC at meeting creation + offset for time zone + offset for DST at meeting creation

- UTC at meeting creation is 3 P.M. UTC
- Offset for creation time zone (Pacific) is ‒8
- Offset for DST for Pacific Time at meeting creation is 0

Intended local time = 3 P.M. UTC + (‒8 hours for time zone offset) + (0 hours for DST offset) = 7 A.M. Pacific Time

#### Step 3 - Attendee's Outlook determines normalized UTC time

On the attendee's computer, Outlook normalizes the time of the meeting based on the Windows global time zone database on the attendee's computer to determine the UTC time.

UTC at meeting start = intended local time ‒ offset for time zone ‒ offset for DST

- Intended local time is 7 A.M. Pacific Time (based on the calculation in step 2)
- Offset for creation time zone (Pacific) is ‒8
- Offset for DST for Pacific Time at meeting start is +1
- UTC at meeting start = 7 A.M. intended local time ‒ (‒8 hours for time zone) ‒ (1 hour for DST)

UTC at meeting start = 7 A.M. + 8 hours ‒ 1 hour = 2 P.M. UTC

#### Step 4 - Attendee determines correct time for this appointment for the attendee's time settings

On the attendee's computer, Outlook converts UTC to the local computer time by using the Windows current time zone settings.

Local start time = UTC at meeting start + offset for local time zone + offset for DST at meeting start

- UTC at meeting start is 2 P.M. UTC (based on the calculation in step 3)
- Offset for local time zone (Eastern) is ‒5
- Offset for DST in Eastern Time at meeting start for local time zone is +1

Local start time = 2 P.M. UTC + (‒5 hours for time zone) + 1 hour for DST

This equates to 10 A.M. Eastern Time, attendee's local computer time, and this is the time for which the meeting is scheduled on the attendee's calendar.

> [!NOTE]
> One core issue is that if you do not select **Automatically adjust clock for Daylight Saving Time** on the attendee's computer, there can be a mismatch in the UTC offset (off by one hour) between the time zone rules in the Windows global time zone database and the Windows current time zone settings. To select **Automatically adjust clock for Daylight Saving Time**, select **Change time zone** in the **Date and Time** dialog box to display the **Time Zone Settings** dialog box (Screen shot for this step is listed below).

:::image type="content" source="media/how-time-zone-normalization-works-in-outlook/select-the-automatically-adjust-clock-for-daylight-saving-time.png" alt-text="Screenshot of the Time Zone Settings dialog box." border="false":::

For more information about how to manage daylight saving time and time zone configurations and updates, see [Daylight Saving Time Help and Support Center](https://support.microsoft.com/help/22803/daylight-saving-time).
