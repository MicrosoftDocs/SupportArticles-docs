---
title: Can't edit an Office 365 Kiosk user's calendar
description: Provides workarounds for a scenario in which a user can't use Outlook to edit the calendar of a user who has an Office 365 Kiosk license.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: alinastr
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 3/31/2022
---
# You can't use Outlook to edit the calendar of an Office 365 Kiosk user

_Original KB number:_ &nbsp; 3203954

## Problem

You can't use Microsoft Outlook to make changes to the calendar of another user who has an Office 365 Kiosk license. This occurs even though you have permissions to the Office 365 Kiosk user's calendar.

## Cause

This behavior is by design. The MAPI and Exchange Web Services (EWS) messaging protocols are disabled in Office 365 Kiosk plans.

## Workaround

To work around this behavior, do one of the following:

- Use Outlook on the web to access the calendar.
- Assign the user a license to an Office 365 subscription in which MAPI is enabled. For more information, see [Office applications service description](/office365/servicedescriptions/office-applications-service-description/office-applications-service-description).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
