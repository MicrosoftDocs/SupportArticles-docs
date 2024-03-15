---
title: Available Teams meeting features for shared mailboxes
description: Discusses available features when you schedule and manage Microsoft Teams meetings by using shared mailboxes, and lists detailed information about each feature.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: conceptual
localization_priority: Normal
ms.custom: 
  - CI 172564
ms.reviewer: heiris
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---
# Teams meeting features for shared mailboxes

For Microsoft Teams meetings that are managed by using a shared mailbox, only a limited number of features are available. The following table lists the details of each feature.

> [!NOTE]
> Shared mailboxes aren't intended for direct login. Keep the shared mailbox account in the **Disabled** state, and avoid resetting its password or signing in by using the shared mailbox user account.

|Available feature|Details|
|----------|-----------|
|Create meetings|<ul><li>The meeting must be created by a delegate by using the shared mailbox calendar.</li><li>Delegates can [add co-organizers to the meeting](https://support.microsoft.com/office/add-co-organizers-to-a-meeting-in-teams-0de2c31c-8207-47ff-ae2a-fc1792d466e2).</li></ul>|
|Update meetings|<ul><li>The meeting must be updated by using the shared mailbox calendar.</li><li>The meeting can be updated by the delegate who organizes the meeting, or by other delegates who have **Full Access** permission to the shared mailbox.</li></ul>|
|Update meeting options|Meeting options can be updated only by the delegate who organizes the meeting, or by co-organizers who have delegate access to the shared mailbox.<br/><br/>Depending on how the shared mailbox is added to Microsoft Outlook, in some scenarios, you might not be able to access the meeting options for a meeting that's scheduled by using the shared mailbox. In this case, a workaround is to [remove the shared mailbox](/outlook/troubleshoot/performance/slow-performance-if-having-many-shared-folder-or-mailboxes-open#remove-a-shared-mailbox) and then add it again by using the **File** > **Add Account** option in Outlook.|
|Manage meeting recordings|The user who initiates recording a meeting can manage the meeting recording if either of the following conditions is met:<ul><li>The shared mailbox is assigned both a Teams license and a custom meeting policy that allows cloud recording.</li><li>The [global meeting policy](/microsoftteams/meetings-policies-recording-and-transcription#meeting-recording) allows cloud recording if the shared mailbox is unlicensed.</li></ul>|
|Manage breakout rooms|For a user to manage breakout rooms, all the following conditions must be met:<ul><li>The shared mailbox is assigned a Teams license.</li><li>The user is assigned the co-organizer role and has delegate access to the shared mailbox.</li><li>The user must first join the meeting.</li></ul>|
|Set up audio conferencing|To set up audio conferencing, the shared mailbox must be assigned a [license for Teams Audio Conferencing](/microsoftteams/deploy-audio-conferencing-teams-landing-page#audio-conferencing-prerequisites).<br/><br/>**Note:** The meeting coordinates won't have PSTN information that's associated with the meeting.|
|Create custom meeting policies|To create custom meeting policies, the shared mailbox must be assigned a Teams license.|

For more information about Teams license options, see [Microsoft Teams add-on licenses](/microsoftteams/teams-add-on-licensing/microsoft-teams-add-on-licensing).
