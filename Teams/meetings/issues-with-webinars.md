---
title: Issues with Teams webinars
description: Troubleshoot issues that affect Teams webinars, including missing or inactive Webinar and For Everyone options.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 150942
  - CSSTroubleshoot
ms.reviewer: billkau
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 3/31/2022
---
# Known issues that affect Teams webinars

Microsoft Teams recently unveiled the webinar feature as an alternative to standard meetings. To learn how to manage webinars, see [Set up for webinars in Microsoft Teams](/microsoftteams/set-up-webinars). To learn how to use webinars, see [Get started with Teams webinars](https://support.microsoft.com/office/get-started-with-teams-webinars-42f3f874-22dc-4289-b53f-bbc1a69013e3) and [Schedule a webinar](https://support.microsoft.com/office/schedule-a-webinar-0719a9bd-07a0-47fd-8415-6c576860f36a). This article discusses known issues that might occur when you use webinars, and provides resolutions and workarounds that you can try.


## "For Everyone" option is greyed out or missing

When you create a webinar, the **Everyone** option on the **Require registration** menu is unavailable (grayed out) or missing. This occurs even though the `WhoCanRegister` parameter value is set to **Everyone** by default.

This issue occurs if there is a change in the meeting policy.  

To resolve this issue, reset the `WhoCanRegister` parameter value to **Everyone**, and wait 24 hours. To reset the `WhoCanRegister` parameter, run the following PowerShell cmdlet:

```powershell
Set-CsTeamsMeetingPolicy -WhoCanRegister Everyone
```

**Note:** If the "anonymous join" functionality is turned off in the meeting settings, anonymous users can't join the webinars. To enable this setting, see [Manage meeting settings in Microsoft Teams](/microsoftteams/meeting-settings-in-teams).

## Not assigning a Registration Method can cause problems with joining a webinar.
Creating a Webinar without assigning a *Require regestration* option other than None may cause a blank screen appear after authenticating.

**Note:** To prevent this, during scheduling a webinar assign a Require registration to "For people in your org" or "For Everyone".


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
