---
title: Offline Address Book isn't downloaded
description: Outlook 2013 and later versions don't support downloading the Offline Address Book from a Microsoft Exchange Server public folder. The Exchange server must be configured to enable Offline Address Book files to be downloaded through web-based distribution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: aruiz, batre
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
ms.date: 01/30/2024
---
# Error 0x80070057 and no Offline Address Book is downloaded in Outlook 2013 or later versions

_Original KB number:_ &nbsp; 2845987

## Symptoms

When you use Microsoft Outlook 2013 and later versions, the Offline Address Book (.oab) isn't downloaded. Additionally, you see an error message that resembles the following message:

> Task john@contoso.com reported error (0x80070057): 'Sorry, something went wrong. You may want to try again'

> [!NOTE]
> In this message, the placeholder *john@contoso.com* represents your SMTP address.

## Cause

The Exchange server is configured to enable .oab download by using Public Folder distribution only. Outlook 2013 and later version don't support downloading the Offline Address Book from an Exchange server public folder. The Exchange server must be configured to enable .oab download by using web-based distribution.

## Resolution

Your Exchange server administrator must make sure that the Offline Address Book can be downloaded by using web-based distribution. Additionally, web-based distribution requires the Autodiscover service to be configured correctly for the Exchange server organization.

> [!IMPORTANT]
> Outlook 2013 and later versions support only OAB version 4.

## More information

For more information about the Exchange Offline Address Book, OAB versions, and web-based distribution, see the following articles:

- [How to Create an Offline Address Book](/previous-versions/office/exchange-server-2007/bb124270(v=exchg.80))

- [Understanding Offline Address Books](/previous-versions/office/exchange-server-2010/bb232155(v=exchg.141))

- [Offline Address Books](/exchange/offline-address-books-exchange-2013-help)

- [Autodiscover Service](/exchange/autodiscover-service-for-exchange-2013)

- [Understanding the Autodiscover Service](/previous-versions/office/exchange-server-2010/bb124251(v=exchg.141))

- [Overview of the Autodiscover Service](/previous-versions/office/exchange-server-2007/bb124251(v=exchg.80))
