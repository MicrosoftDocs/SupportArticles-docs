---
title: Issues with Teams webinars
description: Troubleshoot issues with Teams webinars, such as the "For Everyone" option is greyed out or missing, or the Webinar option is missing. 
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: msteams
localization_priority: Normal
ms.custom: 
- CI 150942
- CSSTroubleshoot
ms.reviewer: billkau
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---
# Known issues with Teams webinars

The webinars feature has recently been released in Microsoft Teams. To manage webinars, you can see [Set up for webinars in Microsoft Teams](/microsoftteams/set-up-webinars). To use webinars, you can see [Get started with Teams webinars](https://support.microsoft.com/office/get-started-with-teams-webinars-42f3f874-22dc-4289-b53f-bbc1a69013e3) and [Schedule a webinar](https://support.microsoft.com/office/schedule-a-webinar-0719a9bd-07a0-47fd-8415-6c576860f36a). This article lists some known issues when you use webinars and provides resolutions or workarounds that you can try.

## "For Everyone" option is greyed out or missing

When you create a new webinar, on the **Require registration** drop-down, the **For everyone** option is greyed out or missing even though the `WhoCanRegister` parameter value is set to **Everyone** by default.

This issue occurs if there is a change in the meeting policy.  

To resolve this issue, reset the `WhoCanRegister` parameter value to **Everyone** and wait 24 hours. To reset the WhoCanRegister parameter, run the following PowerShell command:

```powershell
Set-CsTeamsMeetingPolicy -WhoCanRegister Everyone
```

**Note:** If anonymous join is turned off in meeting settings, anonymous users can't join webinars. To enable this setting, see [Manage meeting settings in Microsoft Teams](/microsoftteams/meeting-settings-in-teams).

## Webinar option is missing in the New meeting drop-down

When you create a new meeting, the **Webinar** option is missing in the **New meeting** drop-down.  

This issue occurs if a user doesn't have permissions to schedule a live event. This issue is in the process of being fixed and rolled out.

To work around this issue, the easiest way is to select the **Schedule meeting** option, and then set **Require registration** that will enable the webinar functionality.

If you want to have the **Webinar** option in the **New meeting** drop-down, go to [https://admin.teams.microsoft.com/policies/broadcasts](https://admin.teams.microsoft.com/policies/broadcasts) to update the **Live Events** policies to **Allow scheduling**.

**Notes:**

- You must have administrator permissions to make the change.  
- This change also allows the **Live event** option to appear in the **New meeting** drop-down as in the following screenshot.

    :::image type="content" source="media/issues-with-webinars/live-event.png" alt-text="Screenshot of the **Live event** option showing in the drop-down." border="false":::

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
