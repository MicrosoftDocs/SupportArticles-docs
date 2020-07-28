---
title: Read receipt from Office 365 recipient displays incorrect time zone
description: Describes an issue in which the wrong time zone info is displayed on the read receipt from an Office 365 recipient.
author: simonxjx
audience: ITPro
ms.service: exchange-online
ms.topic: article
ms.author: v-six
manager: dcscontentpm
localization_priority: Normal
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Exchange Online
---

# Read receipt from an Office 365 recipient displays incorrect time zone information

## Problem

When an Office 365 user sends an email message to another Office 365 user by using Microsoft Outlook or Microsoft Outlook Web App, the message requests a read receipt. After the recipient reads the message, the read receipt that the sender receives displays a different time zone from the actual time zone setting of the sender. For example, the read receipt shows a time zone of (UTC) Monrovia, Reykjavik.

## Cause 

Office 365 doesn't have access to the time zone of the client computer. The time zone that's used to create the read receipt is taken from the Exchange Online server instead of from the client computer. Therefore, the read receipt displays the date and the time based on the time zone setting of the Exchange Online server.

## More information

In Office 365, the date and time of read receipts is based on the time zone setting of the Exchange Online server. Because Office 365 is a cloud service, and users can be in any one of 24 different time zones, the time stamp uses Coordinated Universal Time (UTC).

For example, if you're the sender and your time zone setting is set to **(UTC-06:00) Central Time (US & Canada**), you have to subtract 6 hours from the UTC time that's on the read receipt to reflect the time in your time zone.

UTC is the primary time standard by which the world regulates clocks and time. UTC is one of several closely related successors to Greenwich Mean Time (GMT).  

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).