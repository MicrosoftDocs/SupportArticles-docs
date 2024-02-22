---
title: Cannot add an Internet calendar
description: Fixes an issue in which you can't add an Internet calendar in Outlook 2016, Outlook 2019, and Outlook for Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# You can't add an Internet calendar in Outlook 2019, Outlook 2016, and Outlook for Microsoft 365

_Original KB number:_ &nbsp; 4025591

## Symptoms

You try to add an Internet calendar in Microsoft Outlook 2016, Outlook 2019, or Outlook for Microsoft 365 by following these steps:

1. Switch to the calendar module.
2. In the **Manage Calendars** group on the toolbar, select **Open Calendar**.
3. Select the **From Internet** option.
4. Provide the path of your Internet calendar file.
5. Select **OK**.

When you use this method for some Internet servers, the calendar is not added successfully. After a progress window opens briefly, you are returned to the calendar module without a new calendar added. Additionally, you don't receive any error message.

## Cause

By default, Outlook 2016, Outlook 2019, and Outlook for Microsoft 365 use a new modern authentication stack. Even if the Internet calendar file that you are trying to open does not require authentication, Outlook broadcasts its ability to do modern authentication on the server that contains the calendar. Most server software responds to this broadcast by supporting modern authentication. However, some servers consider the broadcast to be an invalid client request. Therefore, they return a response that causes Outlook to cancel the attempt to add the calendar.

For example, server software that's running on Amazon Web Services (AWS) may consider the authentication broadcast to be invalid and refuse the connection.

## Workaround

To work around this issue, use Outlook Web App (OWA). OWA doesn't have this authentication header behavior. Therefore, it will successfully open the Internet calendar that you want to add.

To use OWA to add the calendar, follow these steps:

1. Sign in to OWA.
2. Switch to the Calendar module.
3. Select the **Add calendar** menu.
4. Select the **From internet** option.
5. Provide the URL and an optional calendar name.
6. Select **Save**.

## More information

When you add the Internet calendar by using OWA, the server that's running Exchange Server manages the calendar subscription and updates. Calendar updates sync approximately every four hours.

The calendar that's added from OWA does not appear in the Outlook desktop application as an Internet calendar. Instead, it is displayed as a calendar entry in the **Other Calendars** group. Because no subscription information is handled or controlled by the Outlook desktop application, you don't have to configure any client-side Internet calendar options for the calendar that's added through OWA.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
