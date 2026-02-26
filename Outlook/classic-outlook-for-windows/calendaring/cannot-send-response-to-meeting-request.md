---
title: Can't send a response to a meeting request
description: Describes an issue that prevents you from responding to a meeting request in Microsoft Outlook. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendar\Working with meetings or appointments
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
ms.date: 01/30/2024
---
# You can't send a response to a meeting request in Outlook

_Original KB number:_ &nbsp; 3185258

## Symptoms

When you try to send a response to a meeting request in Microsoft Outlook, the standard response options are not available. The **Accept**, **Tentative**, and **Decline** buttons do not trigger the expected dropdown menu options of **Edit the response before sending**, **Send the response now**, and **Do not send a response**. Therefore, you can't send the response.

:::image type="content" source="media/cannot-send-response-to-meeting-request/options-of-meeting-tab.png" alt-text="Screenshot of the Accept, Tentative, and Decline buttons on the Meeting ribbon in Outlook." border="false":::

Because the meeting organizer doesn't receive a response from you, the meeting tracking feature is not updated as expected.

> [!NOTE]
> The ability to respond to a meeting request by selecting one of the options that are mentioned in the "Symptoms" section is not supported in new Outlook.

## Cause

This issue occurs if the meeting organizer adds you as a resource to the meeting, and you are external to the meeting organizer's domain.

## Resolution

To work around this behavior, ask the meeting organizer to add you as a required or optional attendee instead of as a resource.
