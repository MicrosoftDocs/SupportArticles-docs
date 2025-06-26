---
title: External participants (users) are blocked from joining a Teams meeting
description: An external participant (user) can't join a Teams meeting and receives a Sign in to join this meeting or Sign in with a different account to join this meeting error message.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Meetings\Meeting Join
  - CI 169117
  - CSSTroubleshoot
ms.reviewer: rbronisevsky,lehill
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---
# Errors when external participants try to join a Teams meeting

External participants who are invited to a Teams meeting that's scheduled by users in your organization can't join the meeting. Instead, they receive one of the following error messages.

## Error 1: Sign in to join this meeting

:::image type="content" source="media/external-participants-join-meeting-blocked/sign-in-to-join-meeting.png" alt-text="Screenshot of the Sign in to join this meeting message when external participants try to join a Teams meeting.":::

### Cause for error 1

This behavior occurs because of the settings that control [anonymous join](/microsoftteams/anonymous-users-in-meetings).

If an external participant isn't signed in with a Teams work or school account and tries to [join the meeting](https://support.microsoft.com/office/join-a-meeting-without-a-teams-account-c6efc38f-4e03-4e79-b28f-e65a4c039508) (as an anonymous user), they receive the message in one of the following situations:

- The organization meeting setting [Anonymous users can join a meeting](/microsoftteams/meeting-settings-in-teams#allow-anonymous-users-to-join-meetings) is turned off. If this setting is turned off, anonymous users can't join meetings that are organized by any users in your organization.
- The organization meeting setting [Anonymous users can join a meeting](/microsoftteams/meeting-settings-in-teams#allow-anonymous-users-to-join-meetings) is turned on. However, in the meeting policies that are assigned to the meeting organizer, the [Anonymous users can join a meeting](/microsoftteams/settings-policies-reference#meeting-join--lobby) setting is turned off. This prevents anonymous users from joining meetings that are scheduled by that organizer.

## Error 2: Sign in with a different account to join this meeting

:::image type="content" source="media/external-participants-join-meeting-blocked/sign-in-with-different-account.png" alt-text="Screenshot of the Sign in with a different account to join this meeting message when external participants try to join a Teams meeting.":::

### Cause for error 2

This behavior occurs because of the settings that control [anonymous join](/microsoftteams/anonymous-users-in-meetings) and [external access](/microsoftteams/manage-external-access).

If an external participant is signed in with a Teams work or school account and tries to join the meeting (as an authenticated user), they receive the message in one of the following situations:

- In the [external access](/microsoftteams/manage-external-access#allow-or-block-domains) setting of your organization, the external participant's domain is blocked or not allowed. Also, anonymous join is disabled* in your organization.
- The external participant's domain isn't blocked or is allowed. However, in the external access setting of the external participant's organization, the meeting organizer's domain is blocked or not allowed. Also, anonymous join is disabled* in your organization.
- External access is mutually enabled in both the external participant's organization and the meeting organizer's organization. However, external access is blocked by user-level policies from either the meeting organizer side or the external participant side. Also, anonymous join is disabled* in your organization.
  
\*[Anonymous join](/microsoftteams/anonymous-users-in-meetings) is disabled in one of the following manners:

- The organization meeting setting [Anonymous users can join a meeting](/microsoftteams/meeting-settings-in-teams#allow-anonymous-users-to-join-meetings) is turned off.
- The organization meeting setting [Anonymous users can join a meeting](/microsoftteams/meeting-settings-in-teams#allow-anonymous-users-to-join-meetings) is turned on. However, in the meeting policies that are assigned to the meeting organizer, the [Anonymous users can join a meeting](/microsoftteams/settings-policies-reference#meeting-join--lobby) setting is turned off.

## Resolution

To manage Teams meetings with external participants, follow the [Plan for meetings with external participants in Microsoft Teams](/microsoftteams/plan-meetings-external-participants) guide and select the correct settings according to your needs.

Here are some example situations.

### Allow all types of external participants to join meetings

- Enable anonymous join in the [organization meeting settings](/microsoftteams/meeting-settings-in-teams).
- Enable anonymous join in the [meeting policies](/microsoftteams/settings-policies-reference#meeting-join--lobby) that are assigned to users in your organization who are allowed to organize meetings with anonymous participants.
 
  > [!NOTE]
  > To allow anonymous join to meetings that are organized by only specific users in your organization, enable anonymous join in the meeting policies that are assigned to those specific users, and then disable anonymous join in the meeting policies that are assigned to other users.
- In the [external access](/microsoftteams/manage-external-access#allow-or-block-domains) setting, select **Allow all external domains**.

  > [!NOTE]
  > If the meeting organizer's domain is blocked or not allowed in the external access setting of the external participants' organizations, the external participants can join meetings only as anonymous users.
- Turn on [guest access](/microsoftteams/guest-access). To do so, in the [Microsoft Teams admin center](https://admin.teams.microsoft.com/), select **Users** > **Guest access**, and then set **Allow guest access in Teams** to **On**. 

### Block all external participants from joining meetings

- Disable anonymous join in the [organization meeting settings](/microsoftteams/meeting-settings-in-teams).
- [Block external access](/microsoftteams/manage-external-access).
- Turn off [guest access](/microsoftteams/guest-access). To do so, in the [Microsoft Teams admin center](https://admin.teams.microsoft.com/), select **Users** > **Guest access**, and then set **Allow guest access in Teams** to **Off**. 

### Allow only external participants to join meetings as authenticated users that you trust

- Disable anonymous join in the [organization meeting settings](/microsoftteams/meeting-settings-in-teams).
- In the external access setting, make sure that the external participants' domains [aren't blocked or are allowed](/microsoftteams/manage-external-access#allow-or-block-domains).
- For admins of the external participants' organizations: In the external access setting of the external participants' organizations, make sure that the meeting organizer's domain isn't blocked or is allowed.
- Turn on [guest access](/microsoftteams/guest-access).

### Block only specific users in your organization from organizing meetings with anonymous participants

- Enable anonymous join in the [organization meeting settings](/microsoftteams/meeting-settings-in-teams).
- Turn off the [Anonymous users can join a meeting](/microsoftteams/settings-policies-reference#meeting-join--lobby) setting in the meeting policies that are assigned to those specific users.

## More information

For more information about anonymous meeting join, see [Manage anonymous participant access to Teams meetings (IT admins)](/microsoftteams/anonymous-users-in-meetings).
