---
title: Microsoft Teams meeting support for shared mailboxes
description: Outlines supported features when you schedule and manage Microsoft Teams meetings by using shared mailboxes, and prerequisites for each feature.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: conceptual
localization_priority: Normal
ms.custom: 
- CI 172564
ms.reviewer: rbronisevsky,lehill
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 5/11/2023
---
# Microsoft Teams meeting support for shared mailboxes

When you schedule and manage Microsoft Teams meetings by using shared mailboxes, it's important to follow specific configuration and setup guidelines to take full advantage of the available capabilities. The following table outlines the supported features and the prerequisites for each feature. Understanding these requirements ensures a smooth and successful meeting experience.

> [!NOTE]
> Shared mailboxes aren't intended for direct login. Keep the shared mailbox account in the **Disabled** state and avoid resetting its password or signing in by using the shared mailbox user account.

|Supported features|Prerequisites and notes|
|----------|-----------|
|Create meetings|<ul><li>The meeting must be created by a delegate from the shared mailbox calendar.</li><li>Delegates can assign co-organizers through meeting options.</li></ul>|
|Organizer ID||
|Update meetings|<ul><li>The meeting must be updated from the shared mailbox calendar.</li><li>The meeting can be updated by the organizing delegate, or other delegates who have access to the shared mailbox.</li></ul>|
|Meeting options|Meeting options can be updated by the organizing delegate, or co-organizers who have delegate access to the shared mailbox.<br/><br/>**Note:** Depending on how the shared mailbox is added to Outlook, you may not be able to access meeting options for a meeting that's scheduled by using the shared mailbox. In this case, a workaround is to [remove the shared mailbox](/outlook/troubleshoot/performance/slow-performance-if-having-many-shared-folder-or-mailboxes-open#remove-a-shared-mailbox) and then add it again by using the **File** > **Add Account** option in Outlook.|
|Attendance reports|The organizing delegate can access attendance reports when the following conditions are met:<ul><li>The shared mailbox is assigned a Microsoft Teams license.</li><li>The delegate is assigned the co-organizer role.</li></ul>|
|Meeting recording|The initiator can manage meeting recording when one of the following conditions is met:<ul><li>The shared mailbox is assigned a Microsoft Teams license.</li><li>The [global meeting policy](/microsoftteams/meetings-policies-recording-and-transcription#meeting-recording) allows cloud recording if the shared mailbox is unlicensed.</li></ul>|
|Breakout rooms|To manage breakout rooms, the following conditions must be met:<ul><li>The shared mailbox is assigned a Microsoft Teams license.</li><li>The user is assigned the co-organizer role and has delegate access to the shared mailbox.</li><li>The user must first join the meeting.</li></ul>|
|Audio conferencing|The shared mailbox must be assigned a [license for Teams Audio Conferencing](/microsoftteams/deploy-audio-conferencing-teams-landing-page#audio-conferencing-prerequisites).<br/><br/>**Note:** Meeting coordinates for shared mailboxes won't have PSTN information associated with the meeting.|
|Custom meeting policy|The shared mailbox must be assigned a Microsoft Teams license.|
|Chat before meeting|This feature is only available to the organizing delegate.|

For more information about license options, see the following Microsoft websites:

- [Compare Microsoft Teams pricing and plans for your business](https://www.microsoft.com/microsoft-teams/compare-microsoft-teams-options?activetab=pivot%3aprimaryr1)
- [Compare Microsoft 365 Enterprise plans](https://www.microsoft.com/microsoft-365/enterprise/compare-office-365-plans)
- [Microsoft Teams add-on licenses](/microsoftteams/teams-add-on-licensing/microsoft-teams-add-on-licensing)

## Differences between shared mailboxes and Microsoft 365 group mailboxes

When choosing between shared mailboxes and Microsoft 365 group mailboxes for your Team meeting needs, it's important to understand the differences in their functionalities. The following table compares their capabilities for various Teams meeting features, licensing, and other functionalities, including delegation options, pre-meeting chat, voicemail greetings, and the ability to send emails on behalf of the mailbox or group.

|Capability|Shared mailboxes|Microsoft 365 group mailboxes
|----------|-----------|-----------|
|Create meetings|Delegates|Members|
|Update meetings|Delegates|Members|
|Meeting options|<ul><li>Organizing delegates</li><li>Co-organizers with delegate access</li></ul>|<ul><li>Organizing members</li><li>Co-organizers</li></ul>|
|Attendance reports|Organizing delegates who are assigned the co-organizer role|<ul><li>Organizing members</li><li>Co-organizers</li></ul>|
|Meeting recording|Initiator|Initiator|
|Breakout rooms (must first join the meeting)|Co-organizers with delegate access|<ul><li>Organizing members</li><li>Co-organizers</li></ul>|
|Licensing, including audio conferencing|Licensing on the shared mailbox|Licensing on the group member|
|Chat before meeting|Organizing delegates|Everyone who is invited to the meeting|
|Voicemail greeting|Greetings can't be delegated|Greetings can be delegated through voice apps|
|Send As|Yes|No|
