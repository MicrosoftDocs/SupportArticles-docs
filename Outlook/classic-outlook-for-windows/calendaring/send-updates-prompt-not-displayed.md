---
title: Send Update To Attendees Prompt Not Displayed When Updating Meetings
description: Discusses the scenarios in which Outlook doesn't display the Send Update to Attendees prompt when a meeting is updated.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendar\Working with meetings or appointments
  - Exchange Online
  - CSSTroubleshoot
  - CI 159761
  - CI 191039
  - CI 6446
ms.reviewer: juforan, tylewis, meerak, v-shorestris
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
search.appverid: MET150
ms.date: 07/02/2025
---

# "Send update to attendees" prompt not displayed when updating meetings

When a meeting organizer updates a meeting, Microsoft Outlook sometimes displays the following **Send Update to Attendees** prompt.

:::image type="content" source="media/send-updates-prompt-not-displayed/send-update-prompt.png" border="false" alt-text="Screenshot of the Send Update to Attendees prompt.":::

However, if the organizer updates a meeting in any of the following scenarios, Outlook doesn't display the prompt.

> [!NOTE]
> Attendees from outside your organization always receive meeting message updates for attendee changes so that they have the complete and current attendee list. This occurs regardless of whether Outlook displays the prompt, or which option the meeting organizer selects if the prompt is displayed. For internal attendees, changes to the attendee list are automatically synced, as described in [Attendees can see others’ responses to a meeting invitation](https://support.microsoft.com/office/attendees-can-see-others-responses-to-a-meeting-invitation-f51437e5-352c-4223-b7d8-7020cd71f3c8).

## Scenario 1

Outlook doesn't display the **Send Update to Attendees** prompt if all the following conditions apply. Instead, the Exchange server automatically sends a meeting update request to the Inbox of the attendees.

- The meeting organizer has version 2305 (current channel build 16501.20000) or a later version of Outlook.

- The organizer adds or removes attendees.

- Any of the following are true:

  - No attendees respond to the meeting.

  - The organizer cancels the meeting.

  - The organizer selects **Response Options** > **Request Responses** for the meeting.

  - All the meeting attendees are group mailboxes.

  - A delegate receives a copy of the meeting message on behalf of the attendee.

  - The organizer changes meeting options that are [full updates](/office/client-developer/outlook/auxiliary/about-meeting-requests-as-informational-updates-and-full-updates#full-updates), such as the subject, start time, end time, location (including adding, removing, or changing a room), recurrence, time zone, do not forward, hide attendee list, or sensitivity labels.

  - The organizer changes [organization settings](/powershell/module/exchange/set-organizationconfig#-visiblemeetingupdateproperties) that affect meeting updates.

## Scenario 2

Outlook doesn't display the **Send Update to Attendees** prompt or send a notification to the attendees if the following conditions apply:

- The meeting organizer has version 2305 (current channel build 16501.20000) or a later version of Outlook.

- Any of the following are true:

  - The organizer doesn't change the attendees.

  - The meeting has no attendees, but the organizer books a room or resource.

  - The organizer removes all attendees.

  - The organizer removes an attendee whose delegate can respond to nonprivate meeting requests on behalf of the attendee.

  - The organizer cancels the meeting or makes some other change that doesn't update the meeting.

## Scenario 3

Outlook doesn't display the **Send Update to Attendees** prompt if all the following conditions apply. Instead, the Exchange server automatically sends a meeting update request to the Inbox of only the added or deleted attendees.

- The meeting organizer has a version of Outlook that is earlier than version 2305 (current channel build 16501.20000).

- The organizer only adds or removes attendees.

- The organizer's Outlook client has [shared calendar improvements](https://support.microsoft.com/office/how-to-enable-and-disable-the-outlook-calendar-sharing-updates-c3aec5d3-55ce-4cea-84b0-80aab6d8dc26) enabled.

The meeting organizer can resolve the issue in this scenario by updating their Outlook client to the latest version.
