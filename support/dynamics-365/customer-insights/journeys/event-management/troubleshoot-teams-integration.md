---
title: Troubleshoot Teams Event Integration in Customer Insights - Journeys
description: Fix Microsoft Teams integration issues for event management in Dynamics 365 Customer Insights - Journeys, like webinar authentication, registrations, and attendance.
ms.date: 07/06/2026
ms.reviewer: alfergus, v-shaywood
ms.custom: sap:Real-time journeys Event Management
search.audienceType: 
  - admin
  - customizer
  - enduser
---

# Troubleshoot Teams integration issues for event management in Customer Insights - Journeys

## Summary

This article helps you troubleshoot the Microsoft Teams integration for event management in Dynamics 365 Customer Insights - Journeys. This integration streams events through Teams and tracks attendance for events that you set up in Customer Insights - Journeys. This article covers Town Hall and Live Events streaming setup, Teams Webinar v2 authentication and application access policy, registrations that never reach Teams, and missing attendance or check-out data. Find the symptom that matches your problem to identify the cause and the fix.

For event management problems that aren't specific to Teams, such as registrations, waitlists, and confirmation emails, see [Troubleshoot event management issues in Customer Insights - Journeys](troubleshoot-event-management.md).

## Town Hall isn't available in the streaming provider dropdown

Town Hall requires a Microsoft 365 license that includes Teams, and the license must be assigned to the user organizing the event, not just present in the tenant. Ask your Microsoft 365 admin to confirm that the organizer has a Teams-eligible license. If it was just assigned, allow 30 to 60 minutes for the license to take effect. Teams Premium isn't required to use Town Hall.

For more information, see [Use Microsoft Teams town halls](/dynamics365/customer-insights/journeys/teams-town-hall) and [Event streaming options](/dynamics365/customer-insights/journeys/teams-meeting-types).

## A "Teams Live Events aren't enabled" warning appears for a tenant that doesn't use Live Events

This warning shows up whenever your Microsoft 365 license doesn't include Teams Live Events, such as Microsoft 365 Business Premium. If you don't plan to use Live Events, you can safely ignore it.

> [!IMPORTANT]
> Teams Live Events was retired on **June 30, 2026**. Already-scheduled events are honored through February 28, 2027. For new events, use Town Hall or Webinar v2 instead.

For more information, see [Event streaming options](/dynamics365/customer-insights/journeys/teams-meeting-types#event-streaming-options).

## "Teams token is missing" error

The user's saved Teams sign-in expired or was never set up. Customer Insights - Journeys needs this sign-in to act on the user's behalf in Teams. To fix this issue:

1. Refresh the event form. The form should detect the missing sign-in and open a Teams sign-in prompt. Completing the sign-in prompt should resolve the issue.
1. If no pop-up appears, check whether the CRM system user has a Microsoft Entra user ID linked to their CRM record, they have a Teams license in the same tenant, and pop-ups are allowed for the Power Apps domain.
1. If the pop-up appears but the error continues, the stored sign-in is stale. Ask an admin to delete the user's row from the user token cache table. The user can then sign in again.

> [!NOTE]
> If you instead get a `HTTP 404` (Not Found) error from `msevtmgt_GetTeamsAuthUrl` itself, see [msevtmgt_GetTeamsAuthUrl returns HTTP 404 (Not Found)](#msevtmgt_getteamsauthurl-returns-http-404-not-found).

## msevtmgt_GetTeamsAuthUrl returns HTTP 404 (Not Found)

If the `msevtmgt_GetTeamsAuthUrl` action runs and the backend returns `HTTP 404` (Not Found), either the environment isn't fully set up for real-time journeys, or the CRM system user running the action doesn't have a Microsoft Entra user ID linked to their CRM record.

## Teams Webinar v2 authentication issues

Webinar v2 requires tenant-level authentication before Customer Insights - Journeys can send registrations to Teams or track attendance. When authentication isn't set up correctly, registrations fail with a permission error and attendance isn't recorded.

Start by following the setup instructions in [Set up authentication for Teams webinars v2](/dynamics365/customer-insights/journeys/teams-authentication#add-the-aap). If authentication still fails, work through the checks in the following sections in order, and retry the authentication after each check.

### Graph API permissions and admin consent

Your app registration requires the following permissions, and admin consent must be granted for each:

- **OnlineMeetingArtifact.Read.All**: Attendance reports (application)
- **VirtualEventRegistration-Anon.ReadWrite.All**: Registrations (application)
- **VirtualEvent.Read.All**: Webinar status (application)
- **VirtualEvent.ReadWrite**: Registrations and editing the webinar (delegated)

:::image type="content" source="media/troubleshoot-teams-integration/permissions.png" alt-text="Screenshot of the required Webinar v2 Graph API permissions in the app registration." lightbox="media/troubleshoot-teams-integration/permissions.png":::

A permission might be added but admin consent isn't granted, or consent is later revoked. To fix this issue, select **Grant admin consent** in the app registration.

### Federated credential issuer

The issuer URL should resemble the following example:

```url
https://login.microsoftonline.com/<TenantID>/v2.0
```

:::image type="content" source="media/troubleshoot-teams-integration/federated-credential.png" alt-text="Screenshot of the federated credential issuer URL configured for Teams Webinar v2 authentication." lightbox="media/troubleshoot-teams-integration/federated-credential.png":::

An incorrect tenant ID or a missing `/v2.0` causes the token exchange to fail. To fix this problem, make sure the issuer matches the required format exactly.

### Application access policy grant

The application access policy (AAP) is a tenant-level Teams setting that lets Customer Insights - Journeys act on an organizer's behalf. Without this policy, every registration call is rejected with the following error message:

> No application access policy found for this app.

A Teams or Microsoft 365 admin can create and grant the AAP by running the following commands in PowerShell:

```powershell
Connect-MicrosoftTeams

New-CsApplicationAccessPolicy -Identity <POLICY_NAME> -AppIds <APP_ID>

Grant-CsApplicationAccessPolicy -PolicyName <POLICY_NAME> -Global
```

To list the existing policies, run the following command in PowerShell:

```powershell
Get-CsApplicationAccessPolicy
```

The following is an example output from the `Get-CsApplicationAccessPolicy` command:

```output
Identity    : Global

AppIds      : {<APP_ID>}

Description :
```

### Application access policy scope

An application access policy only takes effect if it applies to the user organizing the webinar. Most cases where the policy is set up but still fails come down to the following scoping and ranking factors:

- **Global versus specific**: A Global grant applies only to users who don't have a policy assigned directly. If the organizer has a direct or group policy, that policy overrides the Global grant.
- **A narrower scope wins over global**: If the same app ID is in two policies, such as one granted globally and one granted to a group, the more specific assignment takes effect for the users it covers. A group-scoped policy that's missing a permission or doesn't include the organizer overrides the Global policy. List the assigned access policies to confirm which one is applied. The order of precedence is:

  1. Direct per-user assignment
  1. Group
  1. Global

- **Group scope**: For group-scoped policies, the organizer must be a member of the group. An organizer outside the group isn't covered by the policy.
- **Ranking**: Only one policy applies to a user. If more than one policy covers the user, only the one with *rank 1* (highest priority) takes effect, and the rest are ignored. Don't split your app IDs across policies. Put them all in a single policy by using the `-AppIds <ID1>, <ID2>` syntax. Otherwise, the app IDs in lower-ranked policies never apply.

To check the rankings of policies, use the following PowerShell command:

```powershell
Get-CsGroupPolicyAssignment -PolicyType ApplicationAccessPolicy
```

If the command returns multiple rows, compare the `Rank` values to see which policy applies. If the command returns nothing, there are no group assignments.

The following example output shows a scenario where two group policies are defined:

| GroupId                              | PolicyType              | PolicyName         | Rank |
| ------------------------------------ | ----------------------- | ------------------ | ---- |
| aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb | ApplicationAccessPolicy | CIJ-Webinar-Policy | 1    |
| bbbbbbbb-1111-2222-3333-cccccccccccc | ApplicationAccessPolicy | CIJ-Backup-Policy  | 2    |

For more information on scoping and ranking AAPs, see [Configure an application access policy for online meetings and virtual events](/graph/cloud-communication-online-meeting-application-access-policy#configure-application-access-policy).

> [!NOTE]
> AAP changes can take up to 30 minutes to take effect.

## Registrations show up in CRM but attendees aren't actually in the Teams webinar

This problem usually occurs with Webinar v2. Registrations appear in CRM, attendees receive confirmation emails, and journeys complete successfully, but Teams doesn't register the attendee, so they get no join link.

The cause is a Microsoft Graph permissions error that prevents Teams from accepting the registration, usually one of the following issues:

- **No application access policy (AAP) is set up**: The AAP is a tenant-level Teams setting that authorizes Customer Insights - Journeys to manage virtual events on an organizer's behalf. Without it, Teams rejects every registration call. The policy isn't visible from CRM, so your tenant admin must set it up.
- **The AAP scope doesn't include the organizer**: You can grant the AAP globally, to a group, or to specific users. If you don't grant it globally and the organizer isn't in the configured group or user list, the policy doesn't apply to that organizer. You need to repeat the user-level grant for every user who creates webinars. For the scoping options and PowerShell setup, see [Add the AAP](/dynamics365/customer-insights/journeys/teams-authentication#add-the-aap).
- **Missing admin consent for the Webinar v2 permissions**: This cause applies when no Webinar v2 registration ever worked in the tenant. The tenant admin must grant consent. For more information, see [Grant API permissions](/dynamics365/customer-insights/journeys/teams-authentication#5-grant-api-permissions).

If you see the same symptom but no permission error is involved, the underlying Teams session might still be in **Draft**. For that scenario, see [Registration recorded in CRM, but the underlying Teams session was never published](#registration-recorded-in-crm-but-the-underlying-teams-session-was-never-published).

For more information, see [Set up authentication for Teams webinars v2](/dynamics365/customer-insights/journeys/teams-authentication), which includes the PowerShell commands to set the AAP.

## Registration recorded in CRM, but the underlying Teams session was never published

This problem is similar to [Registrations show up in CRM but attendees aren't actually in the Teams webinar](#registrations-show-up-in-crm-but-attendees-arent-actually-in-the-teams-webinar), but no permission error is involved. The Teams session behind the registration was still in **Draft** when the registration came in, so the registration never reached Teams.

Open the session record and check its state. If it's still **Draft**, publish it by using **Go-Live**, and then re-register the affected attendees. To prevent this problem, publish every Teams session before you open registrations.

> [!NOTE]
> Publishing the session later doesn't automatically send the earlier registrations to Teams. You have to re-register the affected attendees manually so they reach Teams and get a join link.

## Cancellation emails go out that no one triggered

First, check the sender address on the cancellation email. Customer Insights - Journeys always sends from a tenant-provisioned `noreply@<domain>` address. If the from address is the organizer's mailbox, such as `events@contoso.com`, the email came from Exchange, not Customer Insights - Journeys.

Then work through the following possible sources to find where the cancellation came from:

- **Canceled in CRM**: Open the registration's audit history. A status change to **Canceled** means the cancellation happened in CRM, and the audit row identifies the user or system that made the change.
- **Canceled in Outlook or Teams**: Check the cancellation email headers from one of the recipients. If they show a `PRODID` header that identifies Microsoft Exchange Server, Exchange generated the cancellation. This condition usually means someone changed or canceled the Teams meeting from Outlook or the Teams app. Your Microsoft 365 admin can identify the source through the Exchange mailbox audit logs in **Microsoft Purview**.
- **Exchange Calendar Repair Assistant**: Exchange has a background process that compares the organizer's calendar against attendee calendars and sends corrective cancellations when it detects inconsistencies. This background process doesn't run on a standard schedule and can process attendees in batches. A partial recipient list or an off-hours timestamp on the cancellation email are common indicators that this background process triggered the cancellation.

## Teams attendance check-ins are missing from the attendance report

> [!NOTE]
> If individual `msevtmgt_eventcheckin` records aren't created when attendees select the **Join** button, see [The event check-in URL doesn't record an attendee as checked in](troubleshoot-event-management.md#the-event-check-in-url-doesnt-record-an-attendee-as-checked-in).

After a meeting ends, Teams needs some time to record each attendee's join time. For Webinar v2, expect join times to appear about 10 minutes after the meeting ends. For other providers, expect up to four hours.

If more time has passed and check-ins are still missing:

- **Only some attendees are missing**: Those attendees most likely joined without using their personalized join link, for example from a forwarded email, a generic invite, or as a guest. The check-in is only recorded when the attendee uses their personalized link. This behavior is a privacy safeguard and can't be changed, and there's no recovery for past events. Make sure attendees join through their personalized link next time.
- **All attendees are missing**: For Webinar v2, this condition usually means the `OnlineMeetingArtifact.Read.All` Graph permission isn't granted in the Teams authentication app. The tenant admin must grant it. For more information, see [Grant API permissions](/dynamics365/customer-insights/journeys/teams-authentication#5-grant-api-permissions).

For missing leave times rather than join times, see [Check-out times are missing from the attendance report](#check-out-times-are-missing-from-the-attendance-report).

For more information, see [View webinar engagement data](/dynamics365/customer-insights/journeys/teams-web-version-2#view-webinar-engagement-data) and [Make the most of your event check-in flow](/dynamics365/customer-insights/journeys/optimize-check-in).

## Check-out times are missing from the attendance report

> [!NOTE]
> For missing join times rather than leave times, see [Teams attendance check-ins are missing from the attendance report](#teams-attendance-check-ins-are-missing-from-the-attendance-report).

Check-out times are only generated automatically for events streamed through Teams Webinar (retiring) or Webinar v2. Other providers don't produce check-out times by design. Confirm that the event uses a webinar before you troubleshoot further.

After a meeting ends, Teams needs some time to record each attendee's check-out time. For Webinar v2, expect check-out times to appear about 10 minutes after the meeting ends. For Webinar (retiring), expect up to four hours. Some attendees never check out because they close their browser or lose their connection. An empty check-out time for those attendees is intended behavior.

For more information, see [View webinar engagement data](/dynamics365/customer-insights/journeys/teams-web-version-2#view-webinar-engagement-data).

## Related content

- [Event planning and management](/dynamics365/customer-insights/journeys/event-management)
- [Set up an event](/dynamics365/customer-insights/journeys/set-up-event)
