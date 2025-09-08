---
title: Issues with Teams webinars
description: Troubleshoot issues that affect Teams webinars, including missing or inactive Webinar and For Everyone options.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Meetings\Webinars
  - CI 150942
  - CSSTroubleshoot
ms.reviewer: billkau; sherimehmood; musingh
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 03/19/2024
---
# Issues that affect Teams webinars

Microsoft Teams recently unveiled the webinar feature as an alternative to standard meetings. To learn how to manage webinars, see [Set up for webinars in Microsoft Teams](/microsoftteams/set-up-webinars). To learn how to use webinars, see [Get started with Teams webinars](https://support.microsoft.com/office/get-started-with-teams-webinars-42f3f874-22dc-4289-b53f-bbc1a69013e3) and [Schedule a webinar](https://support.microsoft.com/office/schedule-a-webinar-0719a9bd-07a0-47fd-8415-6c576860f36a). This article discusses known issues that might occur when your users use webinars, and provides resolutions and workarounds that you can try.

## The Webinar option is missing

> [!NOTE]
> This feature isn't available for users who use new Teams on Virtualized Desktop Infrastructure (VDI).

When users try to [create a webinar](https://support.microsoft.com/office/schedule-a-webinar-in-microsoft-teams-0719a9bd-07a0-47fd-8415-6c576860f36a#bkmk_createwebinar), the **Webinar** option is missing.

This issue may occur for several reasons:

- Display issues occur that are caused by cached data.
- The user account isn't allowed to schedule webinars.

To fix the issue, follow these steps:

1. Verify that the user is enabled to create a webinar:

   1. Open the [Teams admin center](https://admin.teams.microsoft.com/).
   1. In the navigation pane, select **Meetings**.
   1. Under **Meetings**, select **Events Policies**.
   1. Select an existing policy or create one.
   1. If the **Allow webinars** setting is **Off**, toggle it to **On**.
   1. Select **Save**.
1. If the issue persists, ask the user to [clear the Teams client cache](../teams-administration/clear-teams-cache.md).

## The "For everyone" option is grayed out or missing

When you create a webinar, the **For everyone** option on the **Require registration** menu is unavailable (grayed out) or missing. The option is unavailable even if the `WhoCanRegister` parameter value is set to **Everyone** by default.

This issue occurs if a change in the meeting policy is made.

To fix this issue, reset the `WhoCanRegister` parameter value to **Everyone**, and wait 24 hours. To reset the `WhoCanRegister` parameter, run the following PowerShell cmdlet:

```powershell
Set-CsTeamsMeetingPolicy -WhoCanRegister Everyone
```

**Note:** If the "Anonymous join" functionality is turned off in the meeting settings, anonymous users can't join the webinars. To enable this setting, see [Manage meeting settings in Microsoft Teams](/microsoftteams/meeting-settings-in-teams).

## A blank screen appears when joining a webinar

When you try to join a webinar, a blank screen appears after authentication.

This issue may occur if **Require Registration** is set to **None** when the webinar is created.

To work around this issue, set **Require Registration** to **For people in your org** or **For everyone** when you schedule a webinar.

## Webinar invitations aren't received by attendees

In Teams, the invitations to webinars are sent by using the email delivery service in Microsoft Dynamics 365. If you set up security policies for external email messages that are received by your tenant, your users might not get the messages from this service because they're quarantined by your spam filter.

To fix this issue, add the [IP addresses that's used by the Dynamics email delivery service](/dynamics365/customer-insights/journeys/public-ip-addresses-for-email-sending) to the allow list of your spam filter. See your spam filter's documentation for instructions to modify the allow list settings.

If your users are still not receiving invitations to Teams webinars, modify the default Connection filter policy by using the following steps:

1. Navigate to the [Anti-spam policies](https://security.microsoft.com/antispam) page on the Microsoft 365 Defender portal.
1. Select **Connection filter policy (Default)** from the list (but don't select the checkbox that's next to the name).
1. In the flyout pane, select **Edit connection filter policy** in the **Connection filtering** section.
1. Select the **Always allow messages from the following IP addresses or address range** option, and enter one of the IP addresses that are used by the email delivery service.
1. Either press the Enter key or select the complete IP address value that's displayed below the box.
1. Select **Save**.
1. If you're prompted to enable customization, select **Yes**. This step might take some time to finish.

- If you see an error message that mentions customization being disabled, use the following steps:

  1. Wait a few hours, repeat steps 1 to 7, and then add one IP address range for the email delivery service that you entered in step 4.
  1. If the addition is successful, add the remaining IP address ranges, and then select **Save**.
  
- If you still can't add the IP addresses, use the following steps:

  1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
  1. Run the [Enable-OrganizationCustomization](/powershell/module/exchange/enable-organizationcustomization) PowerShell cmdlet to enable customization.
  1. After customization is enabled, add the remaining IP address ranges, and then select **Save**.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
