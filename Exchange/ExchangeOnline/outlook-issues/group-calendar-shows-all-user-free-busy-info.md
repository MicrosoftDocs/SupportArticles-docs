---
title: All members' free/busy data of a group is displayed
description: Fixes an issue in which free/busy information for all users of a Microsoft 365 modern group is displayed when you try to view the modern group calendar in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Client Connectivity
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: tasitae, v-six
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Outlook for Microsoft 365
  - Outlook 2019
search.appverid: MET150
ms.date: 01/24/2024
---
# All users' free/busy info shows in Microsoft 365 modern group calendar

_Original KB number:_ &nbsp; 4057584

## Symptoms

When you view a Microsoft 365 modern group calendar in Microsoft Outlook, the free/busy data of all members of the group is displayed, rather than just calendar events. There may be so much data displayed that the calendar is difficult to use.

## Cause

This issue may occur when you open the O365 modern group calendar in this way:

1. Open Outlook.
2. In the **Calendar** view, select **Home** > **Open Calendar** > **From Address Book**.

When you do this, the Microsoft 365 modern group is treated as a distribution list, and the free/busy data of all users is displayed.

## Resolution

To resolve this issue, open the Microsoft 365 modern group calendar in the following way:

Open the **Calendar** view in Outlook, expand **All Group Calendars**, and then select the modern group.

The issue won't occur when you view the calendar.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
