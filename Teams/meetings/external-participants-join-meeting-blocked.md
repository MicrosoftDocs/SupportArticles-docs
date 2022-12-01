---
title: External participants are blocked from joining a Teams meeting
description: External participants receive an "Only people with access to this org can join its meetings" message when they try to join a Teams meeting. This behavior is caused by anonymous join and external access settings.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
- CI 169117
- CSSTroubleshoot
ms.reviewer: rbronisevsky,lehill
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 11/16/2022
---
# External participants receive "Sign in to Teams to join, or contact the meeting organizer"

## Symptoms

External participants who are invited to a Teams meeting that's scheduled by users in your organization can't join the meeting. Instead, they receive the following message:

> Sign in to Teams to join, or contact the meeting organizer

:::image type="content" source="media/external-participants-join-meeting-blocked/message-join-meeting.png" alt-text="Screenshot of the message when external participants try to join a Teams meeting.":::

## Cause

This behavior occurs because of the settings that control anonymous join and external access.

- If an external participant isn't signed in with a Teams work or school account and tries to join the meeting (as an anonymous user), they receive the message in one of the following situations:

  - The organization meeting setting [Anonymous users can join a meeting](/microsoftteams/meeting-settings-in-teams#using-the-microsoft-teams-admin-center-to-configure-organization-wide-policy) is turned off. If this setting is turned off, anonymous users can't join meetings that are organized by any users in your organization.
  - The organization meeting setting [Anonymous users can join a meeting](/microsoftteams/meeting-settings-in-teams#using-the-microsoft-teams-admin-center-to-configure-organization-wide-policy) is turned on. However, in the meeting policies that are assigned to the meeting organizer, the [Let anonymous people join a meeting](/microsoftteams/meeting-policies-participants-and-guests?WT.mc_id=TeamsAdminCenterCSH#let-anonymous-people-join-a-meeting) setting is turned off. This prevents anonymous users from joining meetings that are scheduled by that organizer.
- If an external participant is signed in with a Teams work or school account and tries to join the meeting (as an authenticated user), they receive the message in one of the following situations:

  - In the [external access](/microsoftteams/manage-external-access#allow-or-block-domains) setting of your organization, the external participant's domain is blocked or not allowed. Also, anonymous join is disabled* in your organization.
  - The external participant's domain isn't blocked or is allowed. However, in the external access setting of the external participant's organization, the meeting organizer's domain is blocked or not allowed. Also, anonymous join is disabled* in your organization.
  
      \* Anonymous join is disabled in one of the following manners:

      - The organization meeting setting [Anonymous users can join a meeting](/microsoftteams/meeting-settings-in-teams#using-the-microsoft-teams-admin-center-to-configure-organization-wide-policy) is turned off.
      - The organization meeting setting [Anonymous users can join a meeting](/microsoftteams/meeting-settings-in-teams#using-the-microsoft-teams-admin-center-to-configure-organization-wide-policy) is turned on. However, in the meeting policies that are assigned to the meeting organizer, the [Let anonymous people join a meeting](/microsoftteams/meeting-policies-participants-and-guests?WT.mc_id=TeamsAdminCenterCSH#let-anonymous-people-join-a-meeting) setting is turned off.

## Resolution

To allow external participants to join Teams meetings, select the correct settings according to your needs based on the following example situations.

### Allow all external participants (regardless of whether they are signed in with a Teams work or school account) to join meetings

- Enable anonymous join in the [organization meeting setting](/microsoftteams/meeting-settings-in-teams#using-the-microsoft-teams-admin-center-to-configure-organization-wide-policy).
- Enable anonymous join in the [meeting policies](/microsoftteams/meeting-policies-participants-and-guests?WT.mc_id=TeamsAdminCenterCSH#let-anonymous-people-join-a-meeting) that are assigned to all users in your organization.

  > [!NOTE]
  > To allow anonymous join to meetings that are organized by only specific users in your organization, enable anonymous join in the meeting policies that are assigned to those specific users, and then disable anonymous join in the meeting policies that are assigned to other users.
- In the [external access](/microsoftteams/manage-external-access#allow-or-block-domains) setting, select **Allow all external domains**.

  > [!NOTE]
  > If the meeting organizer's domain is blocked or not allowed in the external access setting of the external participants' organizations, the external participants can join meetings only as anonymous users.

### Block all external participants from joining meetings

- Disable anonymous join in the [organization meeting setting](/microsoftteams/meeting-settings-in-teams#using-the-microsoft-teams-admin-center-to-configure-organization-wide-policy).
- [Block external access](/microsoftteams/manage-external-access).

### Allow only external participants to join meetings as authenticated users (signed in by using a Teams work or school account)

- Disable anonymous join in the [organization meeting setting](/microsoftteams/meeting-settings-in-teams#using-the-microsoft-teams-admin-center-to-configure-organization-wide-policy).
- In the external access setting, make sure that the external participants' domains [aren't blocked or are allowed](/microsoftteams/manage-external-access#allow-or-block-domains).
- For admins of the external participants' organizations: In the external access setting of the external participants' organizations, make sure that the meeting organizer's domain isn't blocked or is allowed.

### Block communication with authenticated external users but allow them to join meetings as anonymous users

- [Block external access](/microsoftteams/manage-external-access).
- Enable anonymous join in the [organization meeting setting](/microsoftteams/meeting-settings-in-teams#using-the-microsoft-teams-admin-center-to-configure-organization-wide-policy).
- Enable anonymous join in the [meeting policies](/microsoftteams/meeting-policies-participants-and-guests?WT.mc_id=TeamsAdminCenterCSH#let-anonymous-people-join-a-meeting) that are assigned to all users in your organization.

  > [!NOTE]
  > To allow anonymous join to meetings that are organized by only specific users in your organization, enable anonymous join in the meeting policies that are assigned to those specific users, and then disable anonymous join in the meeting policies that are assigned to other users.
