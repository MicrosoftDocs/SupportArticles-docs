---
title: Available Teams Meeting Features for Shared Mailboxes
description: Discusses available features when you schedule and manage Microsoft Teams meetings by using shared mailboxes.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Meetings\Meeting Options and Roles
  - CI 172564
ms.reviewer: heiris
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/08/2025
---
# Teams meeting features for shared mailboxes

For Microsoft Teams meetings that are managed by using a shared mailbox, only a limited number of features are available. The following table lists the details of each feature.

> [!NOTE]

> - Keep the shared mailbox account in the **Disabled** state, and avoid resetting its password.
> - Don't sign in by using the credentials of the shared mailbox user account. Only users that the shared mailbox is shared with can log in with their user credentials.
> - To create a Teams meeting in a shared mailbox calendar, a valid Teams license must be assigned either to the shared mailbox or to the user who is logged in to the shared mailbox.

|Available feature|Details|
|----------|-----------|
|Create meetings|<ul><li>The meeting must be created by a delegate by using the shared mailbox calendar.</li><li>Delegates can [add co-organizers to the meeting](https://support.microsoft.com/office/add-co-organizers-to-a-meeting-in-teams-0de2c31c-8207-47ff-ae2a-fc1792d466e2).</li></ul>|
|Update meetings|<ul><li>The meeting must be updated by using the shared mailbox calendar.</li><li>The meeting can be updated by the delegate who organizes the meeting, or by other delegates who have **Full Access** permission to the shared mailbox.</li></ul>|
|Update meeting options|Meeting options can be updated only by the delegate who organizes the meeting, or by co-organizers who have delegate access to the shared mailbox.<br/><br/>In some scenarios, you might not be able to access the meeting options for a meeting that's scheduled by using the shared mailbox. This condition depends on how the shared mailbox is added to Microsoft Outlook. In this case, the workaround is to [remove the shared mailbox](/outlook/troubleshoot/performance/slow-performance-if-having-many-shared-folder-or-mailboxes-open#remove-a-shared-mailbox) and then restore it by using the **File** > **Add Account** option in Outlook.|
|Manage meeting recordings|See [Teams meeting recording storage and permissions in OneDrive and SharePoint](/microsoftteams/tmr-meeting-recording-change).|
|Manage breakout rooms|For a user to be able to manage breakout rooms, all the following conditions must be met:<ul><li>The shared mailbox is assigned a Teams license.</li><li>The user is assigned the co-organizer role and has delegate access to the shared mailbox.</li><li>The user must first join the meeting.</li></ul>|
|Set up audio conferencing|To set up audio conferencing, the shared mailbox must be assigned a [license for Teams Audio Conferencing](/microsoftteams/deploy-audio-conferencing-teams-landing-page#audio-conferencing-prerequisites).<br/><br/>**Note:** Meetings that are created for a mailbox that doesn't have an Audio Conferencing license will lack the Public Switched Telephone Network (PSTN) details in the meeting invitation.|
|Create custom meeting policies|To create custom meeting policies, the shared mailbox must be assigned a Teams license.|

For more information about Teams license options, see [Microsoft Teams add-on licenses](/microsoftteams/teams-add-on-licensing/microsoft-teams-add-on-licensing).

> [!IMPORTANT]
> Meeting features that aren't listed in the table remain **unsupported** for unlicensed shared mailboxes. For example, Webinars, Town Halls, and View-Only Attendee Mode (StreamingAttendeeMode). These unlisted features don't work or aren't supported for an unlicensed shared mailbox, regardless of the meeting organizer's meeting policy settings or license. If you have to use these features, you must assign a Teams license to the shared mailbox.  

## Known limitations

Users who aren't added to the meeting when the meeting is initially scheduled have only temporary access to the meeting chat. For example, if you add User A to the meeting invitation after you schedule the meeting, User A has access to only the meeting chat during the meeting. After the meeting ends, user A is automatically removed from the meeting chat.
