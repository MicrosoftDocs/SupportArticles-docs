---
title: Issues with meeting recordings
description: Provides guides to troubleshoot meeting recording issues. For example, the meeting recording button is missing, or the meeting recording link isn't included or visible in a chat.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 125645
  - CSSTroubleshoot
ms.reviewer: corbinm
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---
# Issues with meeting recordings

You experience one of the following issues in Microsoft Teams:

- The meeting recording button is missing.
- The meeting recording link isn't included or visible in a chat window.

To determine if there's a problem with your account, run the [Teams Meeting Recording Test](https://aka.ms/MRCA-TMR). This diagnostic checks if your account meets all requirements to record a meeting in Teams. If the issue persists, continue with the following information.

To troubleshoot the issue, begin by asking your administrator to run the [Meeting Recording Support Diagnostic](https://techcommunity.microsoft.com/t5/microsoft-teams-support/new-diagnostic-for-teams-meeting-recording/ba-p/1918982) that's available in the Microsoft 365 admin center.

The diagnostic can check the following prerequisites for Teams meeting recordings:

- You must be assigned the correct license.
- You must have the correct meeting policies.
- You must have a supported storage location (Stream, OneDrive for Business, or SharePoint).

For more information about user requirements for Teams meeting recording, see [Prerequisites for Teams cloud meeting recording](/microsoftteams/cloud-recording#prerequisites-for-teams-cloud-meeting-recording).

## Run the Meeting Recording Support Diagnostic

Microsoft 365 admin users have access to diagnostic tools that they can run within the tenant to verify that the user is correctly configured to record a meeting in Teams.

> [!NOTE]
> This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

Select the **Run Tests** link. This will populate the diagnostic in the Microsoft 365 admin center.

> [!div class="nextstepaction"]
> [Run Tests: Meeting Recording](https://aka.ms/MeetingRecordingDiag)

:::image type="content" source="media/troubleshoot-meeting-recording-issues/diagnostic.png" alt-text="Screenshot of starting the Meeting Recording Support Diagnostic from Need help panel.":::

If the diagnostic reports that your organization is configured for Microsoft Stream storage, but you're in a country/region that isn't supported yet by Stream, use one of the following options:

- Replace the Stream storage with OneDrive for Business or SharePoint. For more information, see [Use OneDrive for Business and SharePoint or Stream for meeting recordings](/microsoftteams/tmr-meeting-recording-change).
- Set the meeting policy to save recordings outside the local region by using the `-AllowRecordingStorageOutsideRegion` attribute in the [Set-CsTeamsMeetingPolicy](/powershell/module/skype/set-csteamsmeetingpolicy) cmdlet.

## Workaround

Begin by making sure that you have the [latest Teams updates](https://support.microsoft.com/office/update-microsoft-teams-535a8e4b-45f0-4f6c-8b3d-91bca7a51db1) installed.

If the issue isn't resolved by an update, use the following workaround for the appropriate issue.

### Issue 1: The Meeting recording button is missing

- Leave and rejoin the meeting. This might restore the recording functionality.
- Use the [Teams web client](https://teams.microsoft.com/) to join and record the meeting.
- Make sure that you're trying to record a meeting, and not a 1:1 call. Call recording is controlled by the `AllowCloudRecordingForCalls` parameter of Teams calling policies.
- Run the 1:1 Call Recording Diagnostic for an impacted user:
  1. Sign in to Microsoft 365 admin center, and type **Diag: Teams 1:1 Call Recording** in the **Need Help?** search box.
  2. Enter the Session Initiation Protocol (SIP) address, and then select **Run Tests**.

Try again to record the meeting. If the issue still isn't resolved, ask your administrator to open a support ticket with Microsoft.

### Issue 2: The meeting recording link isn't visible in a chat window

In high-volume chat sessions, a known issue prevents the meeting recording link from appearing for one or more users.

Try scrolling up to the top of the chat window and then scrolling back to the bottom. This action might trigger a chat service event and restore the meeting recording link.

If the meeting recording link still isn't visible, use either of the following methods to locate the recording, depending on your storage location. The location is provided in the diagnostic report.

**Method 1: Meeting recordings are stored in Stream**

1. Sign in to [Microsoft Stream](https://stream.microsoft.com).
2. In the Stream navigation bar, select **My content** > **Meetings** to open the Meetings page.

    :::image type="content" source="media/troubleshoot-meeting-recording-issues/stream-meetings.png" alt-text="Screenshot of the Meetings button under My content.":::

   The options from the **My content** menu appear on a bar at the top of each page. You can pivot to Teams meeting recordings from any page by selecting the **Meetings** tab on the bar.

    :::image type="content" source="media/troubleshoot-meeting-recording-issues/meetings-tab.png" alt-text="Screenshot of the Meetings button from other pages under My content.":::

For more information, see [Find meetings in Microsoft Stream](/stream/portal-filter-meetings).

**Method 2: Meeting recordings are stored on OneDrive for Business or in SharePoint**

- For non-channel meetings, the recording is stored in the **Recordings** folder under **My files**.

  Example: <*Recording user's OneDrive for Business*>/My files/Recordings

  :::image type="content" source="media/troubleshoot-meeting-recording-issues/onedrive-location.png" alt-text="Screenshot of the OneDrive location for storing meeting recordings.":::

- For channel meetings, the recording is stored in the Teams site documentation library in the **Recordings** folder in SharePoint.

  To find the recording link in the Teams channel, select **Files** > **Recordings** > **Open in SharePoint**.

  Example in Teams: <*Teams channel name*>/Files/Recordings

    :::image type="content" source="media/troubleshoot-meeting-recording-issues/teams-channel-location.png" alt-text="Screenshot of the Teams location for storing meeting recordings.":::
  
    Administrators can also find the recording link for users directly in SharePoint from the **Recordings** folder under **Documents**.
  
    Example in SharePoint: <*SharePoint/Documents/Channel name*>/Recordings
  
    :::image type="content" source="media/troubleshoot-meeting-recording-issues/sharepoint-location.png" alt-text="Screenshot of the SharePoint location for storing meeting recordings.":::
  