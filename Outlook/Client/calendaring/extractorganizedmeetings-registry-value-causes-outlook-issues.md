---
title: Outlook issues because of the ExtractOrganizedMeetings registry value
description: Describes meeting issues that may occur with Outlook when the ExtractOrganizedMeetings registry value is present.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans, sercast
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 10/30/2023
---
# Outlook issues that occur when you use the ExtractOrganizedMeetings registry value

_Original KB number:_ &nbsp; 2646698

## Symptoms

When working with your calendar in Outlook, you may experience the following symptoms:

- When you use direct booking to schedule a resource, the meeting is not automatically declined when your meeting time conflicts with another meeting already on the calendar of the resource mailbox.
- Meetings that delegates create for their manager appear on the delegate's calendar even though the delegate was not invited to the meeting.
- Updates to single occurrences of a recurring meeting on a manager's calendar where the delegate is also invited don't get reflected on the delegate's calendar.

## Cause

These problems can occur if you have the following data in the Windows registry.

- Key: `HKEY_CURRENT_USER\Software\Microsoft\Office\xx.0\Outlook\Options\Calendar`  
  or `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\xx.0\Outlook\Options\Calendar`  
- DWORD: `ExtractOrganizedMeetings`  
- Value: **1**

> [!NOTE]
> In the above registry key path, *xx.0* is 12.0 for Outlook 2007, 14.0 for Outlook 2010 and 15.0 for Outlook 2013.

## Resolution

If you don't need to use the `ExtractOrganizedMeetings` registry value, it's recommended to remove it from your registry. See the articles listed in the [More information](#more-information) section of this article for details on scenarios when the `ExtractOrganizedMeetings` registry value should be used.

## More information

The following article reference the `ExtractOrganizedMeetings` registry value and the situation where it was designed to be used.

[A new meeting request is not saved to your Calendar folder after you create the meeting request under a public Calendar folder in Outlook 2007](https://support.microsoft.com/help/940403)

The following steps can be used to reproduce the issues listed in the [Symptoms](#symptoms) section of this article.

- When you use direct booking to schedule a resource, the meeting is not automatically declined when your meeting time conflicts with another meeting already on the calendar of the resource mailbox.

  1. Configure a direct booking resource to decline conflicting meetings.
  2. Schedule a meeting with the direct booking resource.
  3. Open a new meeting invite and set the same start and end times as the meeting organized in step 2.
  4. Add the direct booking resource to the meeting as a resource and send the meeting invite.

  The meeting is not automatically declined.

- Meetings that delegates create for their manager appear on the delegate's calendar even though the delegate was not invited to the meeting.

  1. Delegate creates and sends a meeting request (to another user) from the manager's calendar.
  2. Delegate deletes the meeting invite from the Sent Items folder that moves the meeting request to the Deleted Items folder.
  3. Delegate opens or previews the meeting invite from the Deleted Items folder.

  At this point, the meeting is now on the delegate's calendar.

- Updates to single occurrences of a recurring meeting on a manager's calendar where the delegate is also invited don't get reflected on the delegate's calendar.

  1. Delegate creates a recurring meeting request on the manager's calendar.
  2. Delegate adds their name to the attendee list and sends out the meeting invite.
  3. Delegate makes an update to a single occurrence of the meeting on the manager's calendar and selects the **Send Update** button.

  The delegate gets the meeting update in their Inbox, but the meeting changes do not get reflected on the delegate's calendar.
