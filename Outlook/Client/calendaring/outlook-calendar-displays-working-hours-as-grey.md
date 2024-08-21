---
title: Calendar shows working hours as grey
description: This article describes an issue in which the Outlook Calendar displays working hours as grey instead of white.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendar\Working with meetings or appointments
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013 Service Pack 1
  - Outlook 2013
  - Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---

# Outlook Calendar displays working hours as grey

In the Calendar module of Microsoft Outlook and when you use the Scheduling Assistant, some calendars of shared mailboxes or rooms display working hours as having a grey background while other calendars display working hours as having a white background. This issue occurs while Outlook is connected to Microsoft Exchange Server. In other clients, such as Outlook Web App (OWA), the working hours of all calendars are displayed as white.

_Original KB number:_ &nbsp; 4488050

## More information

This behavior is expected if the following conditions are true:

- Outlook is connected to a newer version of Microsoft Exchange Server that hosts mailboxes and calendars.
- The working hours of the client and the mailbox are in the same time zone.
Outlook cannot yet handle all the new elements that are used by newer versions of Exchange Server. These elements include WeekDays, WeekendDays, and AllDays.
For more information about the new elements in Exchange Server, see [DaysOfWeek Enumeration](/previous-versions/office/developer/exchange-server-2010/ff343675(v=exchg.140).

## Status

This issue is fixed in Outlook build 16.0.16626.20196. The fix has been rolled out to all production channels except the Semi-Annual Enterprise Channel.
