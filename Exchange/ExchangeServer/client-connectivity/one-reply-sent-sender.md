---
title: Only one reply is sent to each sender when Out of Office Assistant is enabled
description: Describes an issue in which only one reply is sent to each sender when the Out of Office Assistant is enabled. Provides a solution.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Online
ms.date: 01/24/2024
ms.reviewer: v-six
---

# Only one reply is sent to each sender when the Out of Office Assistant is enabled

## Summary

When the Out of Office Assistant is enabled, only one reply is sent to each sender, even if you receive multiple messages from that person.

## More Information

The Out of Office Assistant sends an automatic reply to notify users who send you messages that you are away from the office. Your reply is only sent once to a message sender. The count is reset when you toggle the Out of Office Assistant. Microsoft Exchange clears its internal "sent to" list when you disable the Out of Office Assistant.

If you would like to have a reply sent for every message, use Rules instead of the Out of Office Assistant.