---
title: Troubleshoot Meeting Recording Problems
description: Learn how to troubleshoot and fix meeting recording problems in Microsoft Teams, including missing Record buttons and recording links.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Meetings\Recording and Transcription
  - CI 125645
  - CSSTroubleshoot
ms.reviewer: corbinm
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 07/13/2026
ai-usage: ai-assisted
---

# Issues that affect meeting recordings

## Summary

Describes how to troubleshoot Microsoft Teams meeting recording problems, including a missing Record button and missing recording links in meeting recap or chat. The article explains how to use Teams recording diagnostics to verify user licensing, meeting policies, and recording prerequisites. It also provides guidance for resolving common problems related to meeting roles, meeting options, account context, and recording storage locations in OneDrive and SharePoint. It includes steps to locate missing recordings and run diagnostics to confirm that recordings were processed and uploaded successfully.

## Symptoms

Users might experience one of the following problems in Microsoft Teams:

- The meeting recording button is missing.
- The recording is complete, but the recording is missing in meeting recap.

## Cause

The problems might be caused either by issues with the user account, the license assigned to the user or due to meeting policies that are configured.

To determine whether these problems are caused by the user account, run the [Teams Meeting Recording Test](https://aka.ms/MRCA-TMR). This diagnostic checks whether the account meets all requirements to record a meeting in Teams. If the problem persists, try the following troubleshooting methods.

If you see a Lock icon on the recording button, hover over the icon to see a tooltip that explains [why the button is unavailable](https://support.microsoft.com/teams/meetings/i-can-t-record-a-meeting-in-microsoft-teams).

Administrators can run the [Meeting Recording Support Diagnostic](https://techcommunity.microsoft.com/t5/microsoft-teams-support/new-diagnostic-for-teams-meeting-recording/ba-p/1918982) that's available in the Microsoft 365 admin center.

The diagnostic can check the following prerequisites for Teams meeting recordings:

- Users must be assigned the correct license.
- Users must have the correct meeting policies.

For more information about user requirements for Teams meeting recording, see [Prerequisites for Teams cloud meeting recording](/microsoftteams/cloud-recording#prerequisites-for-teams-cloud-meeting-recording).

### Run the Meeting Recording Support Diagnostic

Microsoft 365 administrators can run diagnostic tools within the tenant to verify that the user is correctly configured to record a meeting in Teams. This diagnostic tool validates license assignment, meeting policy eligibility, and tenant-level recording prerequisites.

> [!NOTE]
> This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

1. Select the **Run Tests** link. This action adds the diagnostic to the Microsoft 365 admin center.

   > [!div class="nextstepaction"]
   > [Run Tests: Meeting Recording](https://aka.ms/MeetingRecordingDiag)
1. In the **Run diagnostic** pane, enter the email address of the user who can't record meetings in the **Username or Email** field, and then select **Run Tests**.

The tests suggest next steps to address any tenant or policy configurations to validate that the user is correctly configured to record a meeting in Teams.

## Workaround

Make sure that the user has the [latest Teams updates](https://support.microsoft.com/teams/notifications-settings/update-microsoft-teams) installed.

If an update doesn't resolve the issue, review the following list of problems and use the workaround for the appropriate problem.

### Issue 1: The Meeting recording button is missing

| Check | Why it matters | Action |
 |---|---|---|
 | Meeting vs. 1:1 call | Recording controls differ by workload. Meeting recording and 1:1 call recording use different policy paths. | Confirm the user is in a meeting. If it’s a 1:1 or PSTN call, troubleshoot calling policy (`AllowCloudRecordingForCalls`) and run the 1:1 call recording diagnostic. |
 | Meeting role | Recording can be restricted by role. Attendees might not be allowed to start recording. | Verify whether the user is organizer, co-organizer, presenter, or attendee. If needed, have organizer assign presenter or co-organizer role. |
 | Organizer meeting options | Meeting options can explicitly block recording and transcription for participants or everyone. | Ask organizer to review **Meeting options** > **Recording & transcription** and adjust **Who can record and transcribe** as needed. |
 | Account and tenant context | Anonymous, guest, or external users might not be allowed to start recording in organizer’s tenant context. | Ensure user is signed in with the expected authenticated account. If needed, have a participant from organizer’s org start recording. |

- Leave and rejoin the meeting. This action might restore the recording functionality.
- Use the [Teams web client](https://teams.microsoft.com/) to join and record the meeting.
- Make sure that the user is trying to record a meeting, not a 1:1 call. Call recording is controlled by the `AllowCloudRecordingForCalls` parameter of Teams calling policies.
- Run the 1:1 Call Recording Diagnostic for an affected user:

   1. Sign in to Microsoft 365 admin center, and type **Diag: Teams 1:1 Call Recording** in the **Need Help?** search box.
   1. Enter the email address of the affected user in the **Username or Email** field, and then select **Run Tests**.

Try again to record the meeting. If the issue still isn't resolved, open a service request for Microsoft Support.

### Issue 2: The meeting recording link isn't visible in a chat window

In high-volume chat sessions, a known issue prevents the meeting recording link from appearing for one or more users.

Try scrolling up to the top of the chat window and then scrolling back to the bottom. This action might trigger a chat service event and restore the meeting recording link.

If the meeting recording link still isn't visible, manually locate the meeting recording:

- For non-channel meetings, the recording is stored in the **Recordings** folder under **My files**.

  Example: <*Recording user's OneDrive for Business*>/My files/Recordings

  :::image type="content" source="media/troubleshoot-meeting-recording-issues/onedrive-location.png" alt-text="Screenshot of the OneDrive location for storing meeting recordings.":::

- For channel meetings, the recording is stored in the Teams site documentation library in the **Recordings** folder in SharePoint.

  To find the recording link in the Teams channel, select **Files** > **Recordings** > **Open in SharePoint**.

  Example in Teams: <*Teams channel name*>/Files/Recordings

  :::image type="content" source="media/troubleshoot-meeting-recording-issues/teams-channel-location.png" alt-text="Screenshot of the Teams location for storing meeting recordings.":::
  
  Administrators can also find the recording link for users directly in SharePoint in the **Recordings** folder under **Documents**.
  
  Example in SharePoint: <*SharePoint/Documents/Channel name*>/Recordings
  
  :::image type="content" source="media/troubleshoot-meeting-recording-issues/sharepoint-location.png" alt-text="Screenshot of the SharePoint location for storing meeting recordings.":::

If you still can't find the meeting recording, run the Missing Recording Diagnostic.

> [!NOTE]
> This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

1. Select the **Run Tests** link. This action adds the diagnostic to the Microsoft 365 admin center.

   > [!div class="nextstepaction"]
   > [Run Tests: Missing Meeting Recording](https://aka.ms/MissingRecordingDiag)

1. In the **Run diagnostic** pane, enter the URL of the meeting in the **URL of the meeting that was recorded** field (usually located in the meeting invitation) and the date of the meeting in the **When was the meeting recorded?** field, and then select **Run Tests**.

The tests confirm that the meeting recording finished successfully and that it was uploaded to SharePoint or OneDrive.
