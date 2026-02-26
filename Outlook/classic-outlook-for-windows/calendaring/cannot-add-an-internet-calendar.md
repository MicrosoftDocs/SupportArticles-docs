---
title: Can't add an Internet calendar
description: Fixes an issue in which you can't add an Internet calendar in Outlook 2016, Outlook 2019, and Outlook for Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendar\SharePoint or Internet-based calendars
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae, tylewis
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365
  - New Outlook for Windows
search.appverid: MET150
ms.date: 02/25/2026
---
# You can't add an Internet calendar in Outlook 2019, Outlook 2016, Outlook for Microsoft 365, and new Outlook

_Original KB number:_ &nbsp; 4025591

## Symptoms

You try to add an Internet calendar in Microsoft Outlook 2016, Outlook 2019, or Outlook for Microsoft 365 by following these steps:

1. Switch to the Calendar module.
1. In the **Manage Calendars** group on the toolbar, select **Open Calendar**.
1. Select the **From Internet** option.
1. Add the path to your Internet calendar file.
1. Select **OK**.

or 

you try to add an Internet calendar in new Outlook for Windows by following these steps:

1. Switch to the Calendar module.
1. Select **Add Calendar** from the navigation menu.
1. In the **Add Calendar** window, select **Subscribe from web** in the navigation pane.
1. Add the path to your Internet calendar file.
1. Select **Import**.

When you use either of these methods for some Internet servers, the calendar isn't added successfully. After a progress window opens briefly, you're returned to the calendar module without a new calendar added. Additionally, you don't receive any error message.

## Cause

By default, Outlook 2016, Outlook 2019, Outlook for Microsoft 365, and new Outlook use a new modern authentication stack. Even if the Internet calendar file that you try to open doesn't require authentication, Outlook broadcasts its ability to do modern authentication on the server that contains the calendar. Most server software responds to this broadcast by supporting modern authentication. However, some servers consider the broadcast to be an invalid client request. Therefore, they return a response that causes Outlook to cancel the attempt to add the calendar.

For example, server software that's running on Amazon Web Services (AWS) mighty consider the authentication broadcast to be invalid and refuse the connection.

## Workaround

To work around this issue, use Outlook on the web. This app doesn't have the authentication header behavior described in the Cause section. Therefore, it opens the Internet calendar that you want to add.

To use Outlook on the web to add an Internet calendar, follow these steps:

1. Sign in to Outlook on the web.
2. Switch to the **Calendar** module.
3. Select the **Add calendar** menu.
4. Select the **From internet** option.
5. Add the path to your Internet calendar file and an optional calendar name.
6. Select **Save**.

## More information

When you add an Internet calendar by using Outlook on the web, the server that's running Exchange Server manages the calendar subscription and updates. Calendar updates sync approximately every four hours.

The calendar that's added from Outlook on the web doesn't appear in the Outlook desktop application as an Internet calendar. Instead, it's displayed as a calendar entry in the **Other Calendars** group. Because no subscription information is handled or controlled by the Outlook desktop application, you don't have to configure any client-side Internet calendar options for the calendar that's added through Outlook on the web.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
