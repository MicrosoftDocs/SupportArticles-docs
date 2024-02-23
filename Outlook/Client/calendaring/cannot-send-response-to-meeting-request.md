---
title: Cannot send a response to a meeting request
description: Describes an issue that prevents you from responding to a meeting request in Microsoft Outlook. A workaround is provided.
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
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# You can't send a response to a meeting request in Outlook

_Original KB number:_ &nbsp; 3185258

## Symptoms

When you try to send a response to a meeting request in Microsoft Outlook, the option is not available. The **Accept**, **Tentative**, and **Decline** buttons do not triggers the expected drop-down options of **Edit the response before sending**, **Send the response now**, and **Do not send a response**.

:::image type="content" source="media/cannot-send-response-to-meeting-request/options-of-meeting-tab.png" alt-text="Screenshot of the Accept, Tentative, and Decline buttons on the Meeting ribbon in Outlook." border="false":::

Because you can't send a response, the meeting organizer doesn't receive one from you, and the meeting tracking feature is not updated as expected.

## Cause

This issue occurs if the meeting organizer added you as a resource to the meeting and you are external to the meeting organizers domain.

## Resolution

To work around this behavior, ask the meeting organizer to add you as a required or optional attendee instead of as a resource.
