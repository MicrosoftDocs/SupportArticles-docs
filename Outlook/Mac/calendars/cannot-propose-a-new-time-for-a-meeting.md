---
title: Cannot propose a new time for a meeting
description: Describes an issue that blocks you from proposing a new time for a meeting in Outlook for Mac. A workaround and a resolution are provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: tasitae, jmckinn
appliesto: 
  - Outlook 2016 for Mac
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 10/30/2023
---
# You cannot propose a new time for a meeting in Outlook for Mac

_Original KB number:_ &nbsp; 2935213

## Symptoms

In Outlook 2016 for Mac or Outlook for Mac 2011, you cannot propose a new time when you respond to a meeting request.

## Cause

This feature is not available in Outlook for Mac 2011 and in Outlook 2016 for Mac versions 15.8.2 and earlier.

## Resolution

The Propose New Time feature is available in Outlook 2016 for Mac version 15.9 and later versions when you are connected to Microsoft Exchange Server 2013 SP1 or a later version.

To use this feature, view a meeting request, select the **Propose New Time** button, and then select either **Tentative and Propose New Time** or **Decline and Propose New Time**.

:::image type="content" source="media/cannot-propose-a-new-time-for-a-meeting/how-to-use-propse-new-time-feature.png" alt-text="Screenshot of a meeting request, showing the Tentative, Decline, and Propose New Time options.":::

> [!NOTE]
> If you are running Outlook 2016 for Mac version 15.9 or a later version and you are connected to a version of Exchange Server that is earlier than Exchange 2013 Service Pack 1 (SP1), the **Propose New Time** button does not appear on meeting requests.

## Workaround

This workaround applies if either of the following conditions is true:

- You are running Outlook for Mac 2011 or Outlook 2016 for Mac version 15.8.2 or an earlier version.
- You are running Outlook 2016 for Mac version 15.9 or a later version and you are connected to a version of Exchange Server that's earlier than Exchange 2013 SP1.

To work around this issue, select either **Tentative** or **Decline** in the meeting request, and then select **Respond with Comments**. In the body of the response, add text that advises the meeting organizer of the time that you propose for the meeting, and then send the response.

The meeting organizer will receive this response, and they can then modify the meeting and send you an updated meeting request.

## More information

For more information about accepting a new time proposal in Outlook for Mac, see [You cannot accept new meeting time proposals in Outlook for Mac](cannot-accept-new-meeting-time-proposals.md).
