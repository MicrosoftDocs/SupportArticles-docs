---
title: Issues with Teams webinars
description: Troubleshoot issues that affect Teams webinars, including missing or inactive Webinar and For Everyone options.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 150942
  - CSSTroubleshoot
ms.reviewer: billkau; sherimehmood; musingh
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---
# Issues with Teams webinars

Microsoft Teams recently unveiled the webinar feature as an alternative to standard meetings. To learn how to manage webinars, see [Set up for webinars in Microsoft Teams](/microsoftteams/set-up-webinars). To learn how to use webinars, see [Get started with Teams webinars](https://support.microsoft.com/office/get-started-with-teams-webinars-42f3f874-22dc-4289-b53f-bbc1a69013e3) and [Schedule a webinar](https://support.microsoft.com/office/schedule-a-webinar-0719a9bd-07a0-47fd-8415-6c576860f36a). This article discusses known issues that might occur when you use webinars, and provides resolutions and workarounds that you can try.

## The "For everyone" option is grayed out or missing

When you create a webinar, the **For everyone** option on the **Require registration** menu is unavailable (grayed out) or missing. The option is unavailable even when the `WhoCanRegister` parameter value is set to **Everyone** by default.

This issue occurs if there's a change in the meeting policy.  

To fix this issue, reset the `WhoCanRegister` parameter value to **Everyone**, and wait 24 hours. To reset the `WhoCanRegister` parameter, run the following PowerShell cmdlet:

```powershell
Set-CsTeamsMeetingPolicy -WhoCanRegister Everyone
```

**Note:** If the "Anonymous join" functionality is turned off in the meeting settings, anonymous users can't join the webinars. To enable this setting, see [Manage meeting settings in Microsoft Teams](/microsoftteams/meeting-settings-in-teams).

## A blank screen appears when joining a webinar

When you try to join a webinar, a blank screen appears after authentication.

This issue may occur if **Require Registration** is set to **None** when the webinar is created.

To work around this issue, set **Require Registration** to **For people in your org** or **For everyone** when scheduling a webinar.

## Webinar invitations are not received by attendees

In Teams, the invitations to webinars are sent using the email delivery service in Microsoft Dynamics 365. If you have set up security policies for external emails received by your tenant, then your users might not get the emails from this service because they are quarantined by your spam filter.

To resolve this issue, add the [IP addresses used by the Dynamics email delivery service](/dynamics365/customer-insights/journeys/public-ip-addresses-for-email-sending) to the allow list of your spam filter. See your spam filter's documentation for instructions on how to modify the allow list settings.

If your users are still not receiving invitations to Teams webinars, modify the default Connection filter policy by using the following steps:

1. Navigate to the [Anti-spam policies](https://security.microsoft.com/antispam) page on the Microsoft 365 Defender portal.
1. Select **Connection filter policy (Default)** from the list (but don't select the check box next to the name).
1. In the flyout pane, select **Edit connection filter policy** in the **Connection filtering** section.
1. Click in the box for the **Always allow messages from the following IP addresses or address range** option and type one of the IP addresses used by the email delivery service.
1. Either press the ENTER key or select the complete IP address value that's displayed below the box.
1. Select **Save**.
1. If prompted to enable customization, select **Yes**. This step might take some time to complete.

- If you see an error about customization being disabled, use the following steps:

  1. Repeat steps 1 to 7 after a few hours and add one IP address range for the email delivery service in step 4.
  1. If the addition is successful, add the rest of the IP address ranges and select **Save**.
  
- If you're still unable to add the IP addresses, use the following steps:

  1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
  1. Run the [Enable-OrganizationCustomization](/powershell/module/exchange/enable-organizationcustomization) PowerShell cmdlet to enable customization.
  1. After customization is enabled, add the rest of the IP address ranges and select **Save**.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
