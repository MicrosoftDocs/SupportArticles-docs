---
title: Issues that affect meeting recordings
description: Provides guides to troubleshoot meeting recording issues, such as a missing recording button or recording link.
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
ms.date: 01/13/2025
---
# Issues that affect meeting recordings

Users experience one of the following issues in Microsoft Teams:

- The meeting recording button is missing.
- The meeting recording link isn't included or visible in a chat window.

To determine whether these issues are caused by the user account, run the [Teams Meeting Recording Test](https://aka.ms/MRCA-TMR). This diagnostic checks whether the account meets all requirements to record a meeting in Teams. If the issue persists, try the following troubleshooting methods.

If you see a Lock icon on the recording button, hover over the icon to see a tooltip that explains [why the button is unavailable](https://support.microsoft.com/en-us/office/i-can-t-record-a-meeting-in-microsoft-teams-f35329c2-57b1-487f-b5e3-70a7efb0945b).

Administrators can run the [Meeting Recording Support Diagnostic](https://techcommunity.microsoft.com/t5/microsoft-teams-support/new-diagnostic-for-teams-meeting-recording/ba-p/1918982) that's available in the Microsoft 365 admin center.

The diagnostic can check the following prerequisites for Teams meeting recordings:

- Users must be assigned the correct license.
- Users must have the correct meeting policies.

For more information about user requirements for Teams meeting recording, see [Prerequisites for Teams cloud meeting recording](/microsoftteams/cloud-recording#prerequisites-for-teams-cloud-meeting-recording).

## Run the Meeting Recording Support Diagnostic

Microsoft 365 administrators can run diagnostic tools within the tenant to verify that the user is correctly configured to record a meeting in Teams.

> [!NOTE]
> This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

1. Select the **Run Tests** link. This will populate the diagnostic in the Microsoft 365 admin center.

   > [!div class="nextstepaction"]
   > [Run Tests: Meeting Recording](https://aka.ms/MeetingRecordingDiag)
1. In the **Run diagnostic** pane, enter the email address of the user who can't record meetings in the **Username or Email** field, and then select **Run Tests**.

The tests will suggest next steps to address any tenant or policy configurations in order to validate that the user is correctly configured to record a meeting in Teams.

## Workaround

Begin by making sure that the user has the [latest Teams updates](https://support.microsoft.com/office/update-microsoft-teams-535a8e4b-45f0-4f6c-8b3d-91bca7a51db1) installed.

If the issue isn't resolved by an update, review the following issues, and use the workaround for the appropriate issue.

### Issue 1: The Meeting recording button is missing

- Leave and rejoin the meeting. This might restore the recording functionality.
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

1. Select the **Run Tests** link. This will populate the diagnostic in the Microsoft 365 admin center.

   > [!div class="nextstepaction"]
   > [Run Tests: Missing Meeting Recording](https://aka.ms/MissingRecordingDiag)

1. In the **Run diagnostic** pane, enter the URL of the meeting in the **URL of the meeting that was recorded** field (usually located in the meeting invitation) and the date of the meeting in the **When was the meeting recorded?** field, and then select **Run Tests**.

The tests confirm that the meeting recording finished successfully and that it was uploaded to SharePoint or OneDrive.
