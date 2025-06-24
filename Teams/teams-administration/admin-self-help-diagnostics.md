---
title: Self-help diagnostics for Teams administrators
manager: dcscontentpm
ms.date: 02/27/2025
audience: Admin|ITPro|Developer
ms.topic: troubleshooting
search.appverid:
  - SPO160
  - MET150
appliesto:
  - Teams
ms.custom:
  - sap:Teams Admin\TAC (Teams Admin Center)
  - CI 124054
  - CI 188816
  - CI 193380
  - CSSTroubleshoot
ms.reviewer: salarson
description: Describes how to run self-help diagnostics for Teams administrators.
---

# Self-help diagnostics for Microsoft Teams administrators

To keep pace with the growth in usage of Microsoft Teams, Microsoft has developed Teams-specific diagnostics that cover top support issues and configuration tasks for which administrators most commonly request help. These diagnostics can't make changes to your tenant, but they provide insights into the issues that affect them and instructions to fix the issues quickly.

Administrators can run the diagnostics from the Microsoft 365 admin center. For users who don't have administrator permissions, a set of connectivity tests are available in the Microsoft Remote Connectivity Analyzer tool that's used to troubleshoot connectivity issues that affect Teams.  

> [!NOTE]
>
> - The diagnostics in the admin center aren't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.
> - The Microsoft Remote Connectivity Analyzer tool isn't available for the GCC and GCC High Microsoft 365 Government environments.

## Run diagnostics in the Microsoft 365 admin center

1. Sign in to the [Microsoft 365 admin center](https://portal.office.com/AdminPortal/Home) as an administrator.
1. Select the **Help & Support** floating button in the bottom right corner of the screen to open the **Help** pane.
1. In the text box, type a brief description of the issue you need help to resolve.
1. Follow the prompts, and then select **Run tests**.

After the diagnostic checks finish and the issue is found, you're provided instructions to resolve the issue. If you implement a fix that's based upon the instructions, it's a good practive to rerun the diagnostic to make sure that the issue is completely resolved.

When an IT admin runs customer diagnostics in the Microsoft 365 admin center to resolve issues without logging support requests, Microsoft makes a donation to a global nonprofit organization. For more information, see [Diagnostics for Social Good](https://aka.ms/DiagnosticsforSocialGood).

## Run connectivity tests in the Microsoft Remote Connectivity Analyzer tool

1. Open a web browser and navigate to [Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/tests/teams).
1. From the list of available tests, select one that applies to your issue.
1. Provide the required information.
1. Enter the verification code that's displayed, and then select **Verify**.
1. Select the checkbox to accept the terms of agreement, and then select **Perform Test**.

After the test finishes, the screen will display details about the checks that were performed and whether the test succeeded, failed, or was successful but displayed a few warnings. A link is provided to get details about warnings and failures and how to resolve them.

## Scenarios covered by diagnostics and connectivity tests

The following tables list the diagnostics that are currently available in the Microsoft 365 admin center and the connectivity tests that are available in the Microsoft Remote Connectivity Analyzer tool. The diagnostics are organized by category together with links to access the diagnostics and connectivity tests directly, scenario descriptions, and help articles about the scenarios.

### Authentication

| Description |  Diagnostic shortcut | Connectivity test shortcut | Support article |
|---|---|---|---|
|Checks whether a user can sign in to the Teams app.|[Run Tests: Teams Sign-In](https://aka.ms/TeamsSignInDiag)|[Teams Sign in](https://testconnectivity.microsoft.com/tests/TeamsSignin/input)|[Resolve sign-in errors in Teams](../teams-sign-in/resolve-sign-in-errors.md)|
|Checks whether a user account meets the requirements for a Microsoft Teams user to be able to sign in to a Teams Android desk phone.||[Teams Android Desk Phone Sign in](https://testconnectivity.microsoft.com/tests/TeamsAndroidDeskPhone/input)|[Certified Android devices get signed out of Teams](../teams-rooms-and-devices/signed-out-of-teams-android-devices.md)|
|Checks whether a user account meets the requirements for a Microsoft Teams user to be able to sign in to a Microsoft Teams Rooms device.||[Microsoft Teams Rooms Sign in](https://testconnectivity.microsoft.com/tests/TeamsMTRDeviceSignIn/input)|[Fix Conditional Access-related issues for Teams Android devices](../teams-rooms-and-devices/teams-android-devices-conditional-access-issues.md)<br/><br/>[Fix Teams Rooms resource account sign-in issues](../teams-rooms-and-devices/teams-rooms-resource-account-sign-in-issues.md)|
|Checks whether the Teams user can communicate with a federated Teams user.|[Run Tests: Teams Federation](https://aka.ms/TeamsFederationDiag)|[Teams Federation and Interoperability](https://testconnectivity.microsoft.com/tests/TeamsFederation/input)|[Manage external access (federation)](/microsoftteams/manage-external-access#federation-diagnostic-tool)<br/><br/>[External federated contacts don't appear in Teams search](../exchange-integration/external-contacts-not-in-search.md)|

### Exchange integration

| Description |  Diagnostic shortcut | Connectivity test shortcut | Support article |
|---|---|---|---|
|Determines the ability of Teams to interact with Microsoft Exchange Server. For Exchange Hybrid, run the test two times by using a Microsoft 365 mailbox and an on-premises mailbox. This is useful for IT administrators who want to troubleshoot Teams and Exchange integration.||[Teams Exchange Integration](https://testconnectivity.microsoft.com/tests/TeamsExchangeIntegration/input)|[Resolve interaction issues between Teams and Exchange Server](../exchange-integration/teams-exchange-interaction-issue.md)|

### Devices

| Description |  Diagnostic shortcut | Connectivity test shortcut | Support article |
|---|---|---|---|
|Checks whether a user account meets the requirements for a Microsoft Teams user to be able to sign in to a Teams Android desk phone.|[Run Tests: Teams Android Desk Phone Sign in](https://aka.ms/TeamsAndroidDeskPhoneDiag)|[Teams Android Desk Phone Sign in](https://testconnectivity.microsoft.com/tests/TeamsPhoneDeviceSignIn/input)|[Certified Android devices get signed out of Teams](../teams-rooms-and-devices/signed-out-of-teams-android-devices.md)|
|Checks whether a user account meets the requirements for a Microsoft Teams user to be able to sign in to the following Microsoft Teams Rooms devices: <ul><li>Teams Rooms on Android</li><li>Teams Rooms on Windows</li><li>Teams panels</li></ul>|<ul><li>[Run Tests: Teams Rooms Android Sign in](https://aka.ms/TeamsRoomsAndroidDiag)</li><li>[Run Tests: Teams Rooms Windows Sign in](https://aka.ms/TeamsRoomsWindowsDiag)</li><li>[Run Tests: Teams Panel Sign in](https://aka.ms/TeamsPanelDiag)</li></ul>|[Microsoft Teams Rooms Sign in](https://testconnectivity.microsoft.com/tests/TeamsMTRDeviceSignIn/input)|[Fix Conditional Access-related issues for Teams Android devices](../teams-rooms-and-devices/teams-android-devices-conditional-access-issues.md)<br/><br/>[Fix Teams Rooms resource account sign-in issues](../teams-rooms-and-devices/teams-rooms-resource-account-sign-in-issues.md)|

### Files

| Description |  Diagnostic shortcut | Connectivity test shortcut | Support article |
|---|---|---|---|
|Checks whether guest users can be added to Teams and the Team is shared with the user.|[Run Tests: Teams Files Guest Access](https://aka.ms/TeamsFilesGuestAccessDiag)||[Guests can't access Files tab for shared files in Teams](../files/guests-cannot-access-files.md)|
|Checks whether the specified user can upload files in Teams chat.|[Run Tests: Unable to upload files to Teams chat](https://aka.ms/TeamsUploadFilesInChat)||[Error when uploading files to a Teams chat](../files/cannot-upload-files-or-access-onedrive.md)|
|Checks whether a specified user can't access files that are shared by another user in chats.|[Run Tests: Unable to access files shared in Teams chat](https://aka.ms/TeamsSharedFilesInChat)||[Error (You don't have access to this file) when opening a file in Teams](../files/do-not-have-access-to-this-file-teams.md)|
|Checks whether a specified user has access to files in the team.|[Run Tests: Unable to access files in a team](https://aka.ms/TeamsAccessFilesInChat)||[Can't access the Files tab on a Teams channel](../files/access-files-tab-errors.md)|

### Meetings

| Description |  Diagnostic shortcut | Connectivity test shortcut | Support article |
|---|---|---|---|
|Checks whether the prerequisites are correctly configured for the Microsoft Teams calendar app to function.||[Teams Calendar App](https://testconnectivity.microsoft.com/tests/TeamsCalendarMissing/input)|[Resolve interaction issues between Teams and Exchange Server](../exchange-integration/teams-exchange-interaction-issue.md)|
|Tries to locate a missing Teams Meeting Recording.|[Run Tests: Missing Recording](https://aka.ms/MissingRecordingDiag)||[Teams cloud meeting recording](/microsoftteams/cloud-recording#meeting-recording-diagnostic-tools)|
|Checks a user's policy for 1:1 Call Recording capability|[Run Tests: Teams 1:1 Call Recording](https://aka.ms/Teams11CallRecDiag)||[Issues with meeting recordings](../meetings/troubleshoot-meeting-recording-issues.md)|
|Checks whether a user has the correct policies to enable the Teams Outlook add-in.|[Run Tests: Teams Add-in Missing in Outlook](https://aka.ms/TeamsAdd-inDiag)||[Resolve issues with Teams Meeting add-in for Outlook](../meetings/resolve-teams-meeting-add-in-issues.md)|
|Checks whether the user is correctly configured to record a meeting in Teams.|[Run Tests: Meeting Recording](https://aka.ms/MeetingRecordingDiag)|[Teams Meeting Recording](https://testconnectivity.microsoft.com/tests/TeamsRecording/input)|[Teams cloud meeting recording](/microsoftteams/cloud-recording#meeting-recording-diagnostic-tools)<br/><br/>[Issues with meeting recordings](../meetings/troubleshoot-meeting-recording-issues.md)|
|Checks whether a user account meets the requirements to schedule a Teams Meeting on behalf of a delegator.||[Teams Meeting Delegation](https://testconnectivity.microsoft.com/tests/TeamsMeetingDelegation/input)|[Resolve interaction issues between Teams and Exchange Server](../exchange-integration/teams-exchange-interaction-issue.md)|
|Checks whether a user account meets the requirements to transcribe a Teams meeting.|[Run Tests: Unable to transcribe a meeting in Teams](https://aka.ms/MeetingTranscribeDiag)||[Admins- Manage transcription and captions for Teams meetings](/microsoftteams/meeting-transcription-captions)|

### Presence

| Description |  Diagnostic shortcut | Connectivity test shortcut | Support article |
|---|---|---|---|
|Checks whether a user's Teams presence can be correctly displayed.|[Run Tests: Teams presence](https://aka.ms/TeamsPresenceDiag)|[Teams Calendar Events Based Presence](https://testconnectivity.microsoft.com/tests/TeamsCalendarPresence/input)|[Your actual presence status isn't displayed in Teams](/microsoftteams/troubleshoot/teams-im-presence/presence-not-show-actual-status)|

### Voice

| Description |  Diagnostic shortcut | Connectivity test shortcut | Support article |
|---|---|---|---|
|Checks whether a user is correctly configured for direct routing.|[Run Tests: Teams Direct Routing](https://aka.ms/TeamsDirectRoutingDiag)||[Diagnose issues with Direct Routing](../phone-system/direct-routing/diagnose-direct-routing-issues.md)|
|Checks whether a call queue is able to receive calls.|[Run Tests: Teams Call Queue](https://aka.ms/TeamsCallQueueDiag)||[Create a call queue in Microsoft Teams](/microsoftteams/create-a-phone-system-call-queue#call-queue-diagnostic-tool)|
|Checks whether the dial pad is visible within Teams.|[Run Tests: Teams Dial Pad Missing](https://aka.ms/TeamsDialPadMissingDiag)|[Teams PSTN Calling Dial Pad](https://testconnectivity.microsoft.com/tests/TeamsDialpadMissing/input)|[Dial pad configuration](/microsoftteams/dial-pad-configuration)|
|Checks whether a user has the ability to make or receive domestic or international PSTN calls.|[Run Tests: Teams PSTN](https://aka.ms/TeamsPSTNDiag)||[Set up Microsoft Calling Plans](/microsoftteams/set-up-calling-plans)|
|Checks whether a user has the ability to create a PSTN conference call.|[Run Tests: Teams Conference](https://aka.ms/TeasConfDiag)||[See a list of users that are enabled for Audio Conferencing in Microsoft Teams](/microsoftteams/see-a-list-of-users-that-are-enabled-for-audio-conferencing-in-teams)|
|Checks whether an auto attendant is able to receive calls.|[Run Tests: Teams Auto Attendant](https://aka.ms/TeamsAADiag)||[Set up an auto attendant for Microsoft Teams](/microsoftteams/create-a-phone-system-auto-attendant#auto-attendant-diagnostic-tool)|
|Checks whether a user is correctly configured to use Voicemail in Teams.|[Run Tests: Voicemail](https://aka.ms/TeamsVoicemailDiag)|[Teams Voicemail](https://testconnectivity.microsoft.com/tests/TeamsVoicemail/input)|[Set up Cloud Voicemail](/microsoftteams/set-up-phone-system-voicemail)|
|Checks whether a user is correctly configured to forward calls to a specified number.|[Run Tests: Teams Call Forwarding](https://aka.ms/TeamsCallForwardingDiag)||[Configure call settings for your users](/microsoftteams/user-call-settings)|
