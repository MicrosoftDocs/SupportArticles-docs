---
title: Cannot accept new meeting time proposals
description: Describes an issue that prevents you from accepting new meeting time proposals in Outlook for Mac. A workaround and a resolution are provided.
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
# You cannot accept new meeting time proposals in Outlook for Mac

_Original KB number:_ &nbsp; 2935220

## Symptoms

In Outlook 2016 for Mac or Outlook for Mac 2011, you cannot accept a New Time Proposal from an attendee. The New Time Proposed email message displays one of the following messages:

> <**Attendee Name**> has tentatively accepted, but proposed that you change the meeting time and then send an update.  
Proposed new time: <**Date**, **time**>

> <*Attendee Name*> has declined, but proposed that you change the meeting time and then send an update.  
Proposed new time: <*Date*, *time*>

## Cause

The Propose New Time feature is not available in Outlook for Mac 2011 and Outlook 2016 for Mac versions 15.8.2 and earlier. Users who have these versions of Outlook for Mac will be unable to accept a proposed new meeting time without manually modifying the meeting request.

## Resolution

The Propose New Time feature is available in Outlook 2016 for Mac version 15.9 and later versions when you are connected to Microsoft Exchange Server 2013 Service Pack 1 (SP1) or a later version.

To use this feature when a new time proposal is received, open the New Time Proposed message, and then select the **Accept Proposal** or **View All Proposals** button.

:::image type="content" source="media/cannot-accept-new-meeting-time-proposals/accept-proposal-and-view-all-proposals-buttons.png" alt-text="Screenshot of the Accept Proposal button and the View All Proposals button.":::

> [!NOTE]
> If you are running Outlook 2016 for Mac version 15.9 or a later version and you are connected to a version of Exchange Server that's earlier than Exchange 2013 SP1, the **Accept Proposal** and **View All Proposals** buttons do not appear.

## Workaround

This workaround applies if either of the following conditions is true:

- You are running Outlook for Mac 2011 or Outlook 2016 for Mac version 15.8.2 or an earlier version.
- You are running Outlook 2016 for Mac version 15.9 or a later version and you are connected to a version of Exchange Server that's earlier than Exchange 2013 SP1.

To work around this issue, open the meeting from your calendar to modify the time, and then send the update to the attendees.

## More information

For more information about proposing a new time in Outlook for Mac, see [You cannot propose a new time for a meeting in Outlook for Mac](cannot-accept-new-meeting-time-proposals.md).
