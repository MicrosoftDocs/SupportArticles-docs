---
title: No confirmation after successfully scheduling a meeting
description: Fixes an issue in which you don't receive any confirmation after you schedule a meeting or an appointment for an on-premises room mailbox in either Outlook client or Outlook Web App (OWA) in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Microsoft 365 Apps for enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# You don't receive any confirmation after you successfully schedule a meeting or an appointment

_Original KB number:_ &nbsp; 2951074

## Problem

When you schedule a meeting or an appointment for an on-premises room mailbox in either Microsoft Office Outlook client or Microsoft Outlook Web App (OWA) in Microsoft 365, the meeting is successfully booked, and the calendar of the room mailbox is blocked or marked as **Tentative**. However, you don't receive any confirmation that states that the room mailbox is successfully booked.

## Cause

This issue occurs if the `ProcessExternalMeetingMessages` parameter for the room mailbox is set to **False**.

## Solution

To resolve this issue, set the `ProcessExternalMeetingMessages` parameter to **True**. To do this, run the following cmdlet in Microsoft Exchange Management Shell:

```powershell
Set-CalendarProcessing "<Room Name>" -ProcessExternalMeetingMessages $True
```

> [!NOTE]
> This setting will affects non-hybrid users.

For more information about this cmdlet, see [Set-CalendarProcessing](/powershell/module/exchange/set-calendarprocessing).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
