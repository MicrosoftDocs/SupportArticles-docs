---
title: Calendar items for the next year may display an incorrect time in Outlook
description: After time zone or daylight savings time changes, some calendar items scheduled for the next year may appear with an incorrect time in Outlook.
author: TobyTu
ms.author: Tasita Ebacher
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: CI 109336
ms.reviewer: tasitae, sbradley, randyto, gbratton
appliesto:
- Outlook 2013
- Outlook 2016
- Outlook 2019
search.appverid: 
- MET150
---

# Calendar items for next year may display an incorrect time in Outlook

## Symptoms

After time zone or daylight savings time changes are made by a government, some calendar items scheduled for in the next year may appear at an incorrect time when viewed in Outlook.

## Cause

This happens because Outlook doesn't apply time zone rules for recurring meetings until the year that the time zone definition changes are set to occur.

## Resolution

There's no fix or update needed. As soon as it's the year of the time zone definition change, your meetings will display at the correct time in Outlook. As a workaround, you can use Outlook on the web (OWA) to view the Outlook calendar items. OWA isn't affected by this situation.

## More information

For example, in 2019 the government of Brazil announced that it would not change its clocks for the upcoming daylight savings time period, which was scheduled to last from November 3, 2019, to February 16, 2020. Recurring meetings for January 7, 2020, through February 15, 2020, received by users in 2019 in the Brazil time zone may appear one hour off when viewed in the Outlook calendar until December 31, 2019. These meetings will then appear at the correct time on or after January 1, 2020. 
