---
title: Resolve Direct Guest Join issues in Teams Rooms
description: Discusses Direct Guest Join issues in Microsoft Teams Rooms and provides resolutions.
ms.topic: troubleshooting
audience: Admin
applies to: Microsoft Teams Rooms for Windows, Microsoft Teams Rooms for Android
ms.reviewer: joshj, iztoth, taherr, gurug, miaitelh
ms.date: 10/16/2026
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
ms.custom: 
  - sap: Teams Meetings\Meeting Join
ai-usage: ai-assisted
---

# Resolve Direct Guest Join issues in Teams Rooms

## Summary

This article describes common issues when you use Direct Guest Join in Microsoft Teams Rooms. The issues include a missing Join button, forwarding limitations, camera behavior, and requirements for Webex web app. The article also provides a possible cause for the issues and instructions to resolve them. 

For issues that occur during a third-party meeting that are specific to the meeting provider, collect the meeting URL or meeting ID, the device model, the meeting date and time, a description of the issue, screenshots if available, and steps to reproduce the issue.

## Symptoms

When you use Direct Guest Join (DGJ) on Microsoft Teams Rooms on Windows or Android to join third-party meetings such as Zoom or Webex, you may see one or more of the following issues:

- The Join button for a third-party meeting doesn't appear on the room calendar.
- A forwarded Zoom meeting doesn't join correctly, or the meeting details appear incomplete.
- The camera doesn't turn on automatically after the room joins a Zoom meeting.
- A Webex meeting fails to join, and the device indicates that the Webex site doesn't support joining from the Webex web app.

## Cause

These issues can occur for different reasons, depending on the scenario:

- The Teams Rooms device isn't configured to allow Zoom or Webex meetings.
- Calendar processing settings for the room mailbox remove or alter third-party meeting details.
- The third-party meeting URL isn't included correctly in the meeting invitation body.
- Forwarding a third-party meeting invitation can change the meeting details in a way that DGJ can't parse correctly.
- The Zoom meeting host setting for participant video is turned off.
- The Webex site doesn't have Webex web app support enabled.

## Resolution

### Missing Join button for a third-party meeting

1. Open the Teams Rooms device settings, and make sure the Zoom and Webex meeting options are enabled under **Meetings**.
1. Verify that calendar processing is configured to preserve third-party meeting details. In Exchange Online PowerShell, run the following command for the room mailbox:

   ```powershell
   Set-CalendarProcessing <UserPrincipalName> -ProcessExternalMeetingMessages $True -DeleteComments $False -DeleteSubject $False
   ```

1. Make sure the third-party meeting URL is pasted correctly in the body of the meeting invitation.
1. For more guidance about preparing room mailboxes for third-party meetings, see the Microsoft Teams Rooms documentation for third-party join.

### Forwarded Zoom meeting doesn't work correctly on Teams Rooms on Android

1. Don't rely on forwarding a third-party meeting invitation to the room mailbox, because this scenario isn't officially supported.
1. Create a new Outlook meeting invitation for the room, and paste the Zoom or Webex meeting URL directly into the meeting body.
1. If you must test a forwarded Zoom invitation and password parsing fails, add a space after the meeting URL as a workaround.

> [!NOTE]
> Forwarding third-party meetings, including meetings created through some Google Calendar Zoom add-ins, may result in incomplete or incorrectly parsed meeting details.

### Camera doesn't turn on automatically in a Zoom meeting

1. Ask the Zoom meeting host to turn on the participant video setting for the meeting.
1. Rejoin the meeting after the host updates the setting, if needed.

### Webex meeting can't join because the site doesn't support the Webex web app

1. Confirm that the Webex site has Webex web app capability enabled.
1. If the capability isn't enabled, contact your Webex administrator or Cisco support to enable and deploy Webex web app support for the site.
1. Try joining the meeting again after the Webex site configuration is updated.

## Send a report to Zoom from the device

For Zoom-specific issues, you can send a problem report from the affected device and provide the tracking ID to Zoom Support by using the following steps.

1. Open **Settings** on the device while you're in the meeting.
1. Open **About**.
1. Select **Send a Report**.
1. Enter details about the issue.
1. **Copy the tracking ID** and share it with Zoom.
1. Select **Send**.

For general information about sending logs and reports to Zoom, refer to the public Zoom support documentation.
