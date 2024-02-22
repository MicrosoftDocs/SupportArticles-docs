---
title: Additional time zone shows a one-hour offset on DST start day in Outlook
description: Discusses a problem in which an additional time zone shows a one-hour difference on the DST start day in the Outlook Calendar. Provides a workaround.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto: 
- Outlook 2013
- Outlook 2016 
- Outlook 2019 
- Outlook for Microsoft 365 
- Microsoft Outlook 2010
search.appverid: MET150
ms.reviewer: randyto, v-six
author: cloud-writer
ms.author: meerak
ms.date: 10/30/2023
---
# Additional time zone shows a one-hour offset on DST start day in Outlook

## Symptoms

You use the feature in Microsoft Outlook that displays multiple time zones on the time bar in your Calendar. On the day that the time setting changes for daylight saving time (DST), you might notice that the time difference between your primary and secondary time zones doesn't change.

Additionally, if you use the **Full Week** view in the Calendar, the whole week shows the incorrect offset between time zones.

 **Example:**  

The first time zone in your Calendar is **(UTC-05:00) Eastern Time (US & Canada)**, and the second time zone is **(UTC-00:00) (Dublin, Edinburgh, Lisbon, London)**. When the time setting changes for Eastern Time (for example, on March 8, 2020), the time bar in Outlook on that Sunday still shows a seven-hour difference between the two time zones. However, on March 9, 2020, the two time displays show the correct offset between time zones.

## Cause

This problem occurs because of how Outlook calculates these differences for display in the Outlook user interface.

## Workaround

To work around this problem use the **Work Week** view. This view starts on a Monday and shows the correct offset between time zones.
This workaround should work in most cases. However, if the time zone that you are located in uses a different DST start day than the other time zone uses, the **Work Week** view might still show the incorrect offset.

## Status

Microsoft is researching this problem and will post more information in this article when the information becomes available.
