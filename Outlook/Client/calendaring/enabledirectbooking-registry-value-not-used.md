---
title: The direct booking feature is removed
description: This article details the deprecation of the Direct Booking functionality in Microsoft Outlook 2013.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans, aruiz
appliesto: 
  - Outlook 2013
search.appverid: MET150
ms.date: 01/30/2024
---
# The EnableDirectBooking registry value isn't used by Outlook 2013

_Original KB number:_ &nbsp; 2788235

## Symptoms

When you send a meeting request in Microsoft Outlook 2013 to a mailbox that's configured for direct booking, the meeting is not successfully booked. You don't receive an error message in this scenario. Additionally, if you open the mailbox that's configured for direct booking, the meeting request is in the Inbox folder.

This problem occurs even if you configure the `EnableDirectBooking` registry value on the Outlook 2013 client by using the following registry data:

Key: `HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Outlook\Options\Calendar`  
or  
Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\15.0\Outlook\Options\Calendar`  
DWORD: `EnableDirectBooking`  
Value: **1**  

## Cause

This problem occurs because the direct booking feature is completely removed from Outlook 2013. Additionally, the `EnableDirectBooking` registry that is available in Outlook 2010 is ignored in Outlook 2013.

## Resolution

To resolve this problem, convert the resource mailbox to an Exchange resource mailbox. The following article for Exchange Server 2007 explains how to migrate a direct booking resource mailbox to an Exchange resource mailbox configured to automatically accept meetings.

[How to Upgrade Outlook Direct Booking Resource Mailboxes to Exchange 2007](/previous-versions/office/exchange-server-2007/bb232195(v=exchg.80))

Similar steps can be used for later versions of Exchange. The main difference between Exchange Server 2007 and later versions of Exchange is in the cmdlet used to configure the Exchange resource mailbox. The following article contains information on how to configure an Exchange 2010 resource mailbox.

[Managing Resource Mailboxes and Scheduling](/previous-versions/office/exchange-server-2010/bb124374(v=exchg.141))

## More information

The following article contains the full Office 2013 feature deprecation list.

[Changes in Office 2013](/previous-versions/office/office-2013-resource-kit/cc178954(v=office.15))
