---
title: Meetings are off by one hour in some time zones
description: Meeting request sent from Exchange to the attendees has an incorrect start time and time zone information. Provides a workaround.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jmartin, v-six
appliesto: 
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Enterprise
search.appverid: MET150
---
# Meetings are off by one hour in certain time zones

_Original KB number:_ &nbsp; 3171495

## Symptoms

When an organizer creates a meeting from an iOS device, the attendees receive a meeting request that is one hour earlier than the scheduled meeting time.

## Cause

The meeting request sent from Exchange to the attendees has an incorrect start time and time zone information. The following is the tine zone information from the meeting request:

```console
This timezone is 180 minutes (3 hours) ahead of UTC.
Its primary / standard time name is "".
The timezone transitions from daylight savings time to standard time 10/26/2016 2:00:00 AM.
During standard time, time is 180 minutes (3 hours) ahead of UTC.
Its daylight time name is "".
The timezone transitions from standard time to daylight savings time 3/5/2016 2:00:00 AM.
During daylight savings time, time is 240 minutes (4 hours) ahead of UTC.

bias -180 standardbias 0 daylightbias -60 standardName standardDate y2016m10dow0d26h2mi0s0ms0 daylightName daylightdate y2016m3dow0d5h2mi0s0ms0
```

## Workaround

Modify the time zone on the EAS client to another region with the same time offset until the DST period ends.

## More information

To get help with the date and time on your iPhone, iPad, and iPod touch, see [If you can't change the time or time zone on your iPhone, iPad, or iPod touch](https://support.apple.com/HT203483).
