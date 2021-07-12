---
title: All members' free/busy data of a group is displayed
description: Fixes an issue in which free/busy information for all users of an Office 365 modern group is displayed when you try to view the modern group calendar in Outlook.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: tasitae
appliesto:
- Outlook 2016
- Outlook 2013
- Outlook for Office 365
- Outlook 2019  
search.appverid: MET150
---
# All users' free/busy info shows in Office 365 modern group calendar

_Original KB number:_ &nbsp; 4057584

## Symptoms

When you view a Microsoft Office 365 modern group calendar in Microsoft Outlook, the free/busy data of all members of the group is displayed, rather than just calendar events. There may be so much data displayed that the calendar is difficult to use.

## Cause

This issue may occur when you open the O365 modern group calendar in this way:

1. Open Outlook.
2. In the **Calendar** view, select **Home** > **Open Calendar** > **From Address Book**.

When you do this, the Office 365 modern group is treated as a distribution list, and the free/busy data of all users is displayed.

## Resolution

To resolve this issue, open the Office 365 modern group calendar in the following way:

Open the **Calendar** view in Outlook, expand **All Group Calendars**, and then select the modern group.

The issue won't occur when you view the calendar.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
