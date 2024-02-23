---
title: Self-help diagnostics for Teams administrators
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 10/30/2023
audience: Admin|ITPro|Developer
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Teams
ms.custom: 
  - CI 124054
  - CSSTroubleshoot
ms.reviewer: salarson
description: Describes how to run self-help diagnostics for Teams admins
---

# Self-help diagnostics for Microsoft Teams administrators

To keep pace with the growth in usage of Microsoft Teams, Microsoft has developed Teams-specific diagnostic scenarios that cover top support topics and the most common tasks for which administrators request help with configuration. It is important to note that while these diagnostics can't make changes to your tenant, they do provide insight into known issues and provide  instructions to fix the issues quickly.

> [!NOTE]
> These diagnostics aren't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.

## Run diagnostics

While you’re logged in as an administrator, navigate to the [Microsoft 365 admin center](https://portal.office.com/AdminPortal/Home). In the navigation pane, select **Show all** > **Support** > **New service request**. After you briefly describe your issue (for example, “I can't invite a guest to Teams”), the system determines whether a diagnostic scenario matches your issue.

> [!NOTE]
> As you type search terms, a type-ahead query assists you to find the topics that you’re searching for.

:::image type="content" source="media/admin-self-help-diagnostics/admin-self-help-diagnostics-1.png" alt-text="Screenshot that shows the Teams diagnostic query screen.":::

Enter your organization’s root URL. In the Guest Access diagnostic, select the drop-down arrow, select a pre-populated URL from your tenant, and then select **Run tests**.

After the diagnostic checks finish and the configuration issue is found, the system provides the steps to resolve the issue. In this example, the Tenant Admin had not turned on Guest Access:

:::image type="content" source="media/admin-self-help-diagnostics/admin-self-help-diagnostics-2.png" alt-text="Screenshot that shows the example diagnostics response screen.":::

> [!NOTE]
> If a diagnostic detects an issue, and you implement a fix based on the results, consider rerunning the diagnostic to ensure the issue is completely resolved.

When IT admins run customer diagnostics in the Microsoft 365 admin center to resolve issues without logging support requests, Microsoft makes a donation to global nonprofit organizations.

For more information, see [Diagnostics for Social Good](https://aka.ms/DiagnosticsforSocialGood).

### Scenarios covered by diagnostics

> [!NOTE]
> You must be an M365 Administrator to run diagnostics.

The following diagnostics are currently available with brief scenario descriptions and shortcut commands:

| Category | Diagnostic | Description | Shortcut Link | Support Article |
|---|---|---|---|---|
| Authentication | Teams Sign-in | Validates that a user can sign in to the Teams app. | [Run Tests: Teams Sign-In](https://aka.ms/TeamsSignInDiag) | [Resolve sign-in errors in Teams](/microsoftteams/troubleshoot/teams-sign-in/resolve-sign-in-errors) |
| Authentication | Teams Federation | Validates that the Teams user can communicate with a federated Teams user. | [Run Tests: Teams Federation](https://aka.ms/TeamsFederationDiag) | [Manage external access (federation)]( /microsoftteams/manage-external-access#federation-diagnostic-tool) |
| Authentication | Unable to Invite Guest Users to Teams | Validates that a specific guest can sign into Teams.| [Run Tests: Teams Guest Access](https://aka.ms/TeamsGuestAccessDiag) | [Guest access in Microsoft Teams](/microsoftteams/guest-access) |
| Files | Teams Files Guest Access | Validates that guest users can be added to Teams and the Team is shared with the user. | [Run Tests: Teams Files Guest Access](https://aka.ms/TeamsFilesGuestAccessDiag) | [Guests can't access Files tab for shared files in Teams](/microsoftteams/troubleshoot/files/guests-cannot-access-files) |
| Files | Unable to upload files to Teams chat | Validates if the specified user can upload files in Teams chat. | [Run Tests: Unable to upload files to Teams chat](https://aka.ms/TeamsUploadFilesInChat) | [Error when uploading files to a Teams chat](/microsoftteams/troubleshoot/files/cannot-upload-files-or-access-onedrive) |
| Files | Unable to access files shared in Teams chat | Validated that a specified user being unable to access files shared by another user in chats. | [Run Tests: Unable to access files shared in Teams chat](https://aka.ms/TeamsSharedFilesInChat) | [Error (You don't have access to this file) when opening a file in Teams](/microsoftteams/troubleshoot/known-issues/do-not-have-access-to-this-file-teams) |
| Files | Unable to access files in a team | Validates that a specified user has access to files in the Team. | [Run Tests: Unable to access files in a team](https://aka.ms/TeamsAccessFilesInChat) | [Can't access the Files tab on a Teams channel]( /microsoftteams/troubleshoot/files/access-files-tab-errors) |
| Meetings | Teams Calendar App | Validates that the pre-requisites are properly configured for the Microsoft Teams calendar app to function. | [Run Tests: Teams Calendar App](https://testconnectivity.microsoft.com/tests/TeamsCalendarMissing/input) |[Troubleshoot Microsoft Teams and Exchange Server interaction issues]( /microsoftteams/troubleshoot/exchange-integration/teams-exchange-interaction-issue) |
| Meetings | Meeting Recording Missing | Attempts to locate a missing Teams Meeting Recording | [Run Tests: Missing Recording](https://aka.ms/MissingRecordingDiag) | [Teams cloud meeting recording](/microsoftteams/cloud-recording#meeting-recording-diagnostic-tools) |
| Meetings | 1:1 Call Recording | Checks a user's policy for 1:1 Call Recording capability | [Run Tests: Teams 1:1 Call Recording](https://aka.ms/Teams11CallRecDiag) | [Issues with meeting recordings](/microsoftteams/troubleshoot/meetings/troubleshoot-meeting-recording-issues#workaround) |
| Meetings | Teams Add-in is Missing in Outlook | Validates that a user has the correct policies to enable the Teams Outlook add-in. | [Run Tests: Teams Add-in Missing in Outlook](https://aka.ms/TeamsAdd-inDiag) |[Resolve issues with Teams Meeting add-in for Outlook](/microsoftteams/troubleshoot/meetings/resolve-teams-meeting-add-in-issues) |
| Meetings | Teams Live Events | Validates that a user is able to schedule Teams live events. | [Run Tests: Teams Live Events](https://aka.ms/TeamsLiveEventsDiag) |[Troubleshooting live events in Microsoft Teams](/microsoftteams/teams-stream-troubleshooting) |
| Meetings | Teams Meeting Recordings | Validates that the user is properly configured to record a meeting in Teams. | [Run Tests: Meeting Recording](https://aka.ms/MeetingRecordingDiag) | [Teams cloud meeting recording](/microsoftteams/cloud-recording#meeting-recording-diagnostic-tools) |
| Presence | Teams presence | Validates that a user's Teams presence can be correctly displayed. | [Run Tests: Teams presence](https://aka.ms/TeamsPresenceDiag) | [Your actual presence status isn't displayed in Teams](/microsoftteams/troubleshoot/teams-im-presence/presence-not-show-actual-status) |
| Voice | Teams Direct Routing | Validates that a user is correctly configured for direct routing. | [Run Tests: Teams Direct Routing](https://aka.ms/TeamsDirectRoutingDiag) | [Diagnose issues with Direct Routing](/microsoftteams/troubleshoot/phone-system/direct-routing/diagnose-direct-routing-issues) |
| Voice | Teams Call Queue | Validates that a call queue is able to receive calls. | [Run Tests: Teams Call Queue](https://aka.ms/TeamsCallQueueDiag) | [Create a call queue in Microsoft Teams](/microsoftteams/create-a-phone-system-call-queue#call-queue-diagnostic-tool) |
| Voice | Teams Dial Pad is Missing | Validates that the dial pad is visible within Teams. | [Run Tests: Teams Dial Pad Missing](https://aka.ms/TeamsDialPadMissingDiag) | [Dial pad in missing in Teams](/microsoftteams/troubleshoot/teams-conferencing/no-dial-pad) |
| Voice | Unable to Make Domestic or International PSTN calls in Teams | Validates that a user has the ability to make or receive domestic or international PSTN calls. | [Run Tests: Teams PSTN](https://aka.ms/TeamsPSTNDiag) |[Set up Microsoft Calling Plans](/microsoftteams/set-up-calling-plans) |
| Voice | Unable to Join or Create a Teams Conference Call | Validates that a user has the ability to create or join a PSTN conference call. | [Run Tests: Teams Conference](https://aka.ms/TeasConfDiag) |[See a list of users that are enabled for Audio Conferencing in Microsoft Teams](/microsoftteams/see-a-list-of-users-that-are-enabled-for-audio-conferencing-in-teams) |
| Voice | Teams Auto-Attendant | Validates that an auto attendant is able to receive calls. | [Run Tests: Teams Auto Attendant](https://aka.ms/TeamsAADiag) | [Set up an auto attendant for Microsoft Teams](/microsoftteams/create-a-phone-system-auto-attendant#auto-attendant-diagnostic-tool) |
| Voice | Teams Voicemail | Validates that a user is properly configured to use Voicemail in Teams. | [Run Tests: Voicemail](https://aka.ms/TeamsVoicemailDiag) | [Set up Cloud Voicemail](/microsoftteams/set-up-phone-system-voicemail) |
| Voice | Teams Call Forwarding | Validates that a user is properly configured to forward calls to a specified number. | [Run Tests: Teams Call Forwarding](https://aka.ms/TeamsCallForwardingDiag) |[Configure call settings for your users](/microsoftteams/user-call-settings) |

While these diagnostics require admin permissions to be run, your users can run other diagnostics by using the Microsoft Remote Connectivity Analyzer. See [Self-help diagnostics for Teams in Remote Connectivity Analyzer](/connectivity-analyzer/microsoft-teams/self-help-diagnostics-for-microsoft-teams) for more information.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
