---
title: Time zones that do not observe daylight saving time
description: Describes how to optimally configure Windows in those time zones that do not observe daylight saving time. By disabling daylight saving time in Windows, it may trigger incorrect times for Outlook calendar events and appointments for recipients in time zones that do observe daylight saving time.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook 2010 with Business Contact Manager
search.appverid: MET150
ms.date: 10/30/2023
---
# Time zones that do not observe daylight saving time

## Summary

Assume that you live in a region that does not observe daylight saving time (DST), but the Windows setting for that time zone *does* adjust for daylight saving time. In this situation, we recommend that you do not clear the **Automatically adjust clock for Daylight Saving Time** check box in the **Time Zone Settings** dialog box.

If you disable this daylight saving time functionality, Microsoft Outlook 2010 and Outlook 2013 may assign the wrong time to a Calendar event, appointment, or meeting request for recipients in other time zones that do observe daylight saving time. Instead, we recommend that you select a time zone that does not observe daylight saving time and that has the same Coordinated Universal Time (UTC) offset as the current time zone.

For example, assume that your current time zone is (UTC-06:00) Central Time (US and Canada). There are two time zones that do not observe daylight saving time and that have the same UTC offset (-06:00):

- (UTC-06:00) Central America
- (UTC-06:00) Saskatchewan

## More information

To change your time zone setting, follow these steps:

1. In Control Panel, select **Clock, Language, and Region**.
2. Select **Change the time zone**.
3. In the **Time Zone** area of the **Date and Time** dialog box, select **Change time zone**.
4. In the **Time zone** list, select a time zone that does not observe daylight saving time and has the same UTC offset as your current time zone.
5. Select **OK**.
6. Select **Apply**, and then select **OK**.

### Time Zones that do not observe daylight saving time

The following is a list of time zones that don't observe daylight saving time.

> [!NOTE]
> This list may change at any time. Time zone observance is subject to local government jurisdiction, and this list is current as of August, 2010. For more information, see [Daylight Saving Time Help and Support Center](https://support.microsoft.com/help/22803/daylight-saving-time).

- (UTC) Coordinated Universal Time
- (UTC) Monrovia, Reykjavik
- (UTC+01:00) West Central Africa
- (UTC+02:00) Harare, Pretoria
- (UTC+03:00) Baghdad
- (UTC+03:00) Kuwait, Riyadh
- (UTC+03:00) Nairobi
- (UTC+04:00) Abu Dhabi, Muscat
- (UTC+04:00) Port Louis
- (UTC+04:00) Tbilisi
- (UTC+04:30) Kabul
- (UTC+05:00) Islamabad, Karachi
- (UTC+05:00) Toshkent
- (UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi
- (UTC+05:30) Sri Jayawardenepura
- (UTC+05:45) Kathmandu
- (UTC+06:00) Astana
- (UTC+06:00) Dhaka
- (UTC+06:30) Yangon (Rangoon)
- (UTC+07:00) Bangkok, Hanoi, Jakarta
- (UTC+08:00) Beijing, Chongqing, Hong Kong, Urumqi
- (UTC+08:00) Kuala Lumpur, Singapore
- (UTC+08:00) Perth
- (UTC+08:00) Taipei
- (UTC+08:00) Ulaanbaatar
- (UTC+09:00) Osaka, Sapporo, Tokyo
- (UTC+09:00) Seoul
- (UTC+09:30) Darwin
- (UTC+10:00) Brisbane
- (UTC+10:00) Guam, Port Moresby
- (UTC+11:00) Magadan, Solomon Is., New Caledonia
- (UTC+12:00) Coordinated Universal Time+12
- (UTC+13:00) Nuku'alofa
- (UTC-01:00) Cabo Verde Is.
- (UTC-02:00) Coordinated Universal Time-02
- (UTC-03:00) Buenos Aires
- (UTC-03:00) Cayenne, Fortaleza
- (UTC-04:00) Georgetown, La Paz, Manaus, San Juan
- (UTC-04:30) Caracas
- (UTC-05:00) Bogota, Lima, Quito
- (UTC-06:00) Central America
- (UTC-06:00) Saskatchewan
- (UTC-07:00) Arizona
- (UTC-10:00) Hawaii
- (UTC-11:00) Coordinated Universal Time-1
- (UTC-12:00) International Date Line West
