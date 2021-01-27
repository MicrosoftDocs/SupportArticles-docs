---
title: Your actual presence status isn't displayed in Teams
description: Fixes an issue in which your actual presence status isn't displayed in Teams.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: msteams
localization_priority: Normal
ms.custom: 
- CI 126266
- CSSTroubleshoot
ms.reviewer: sylviebo, premgan
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---
# Your actual presence status isn't reflected in Teams

## Symptoms

In Microsoft Teams, your actual presence status isn't displayed in Teams. For example, your presence status should change to **Away** if your desktop has been inactive for more than 5 minutes. However, when you resume activity on your desktop, your presence status doesn't change to **Available** immediately.

**Note:** Your desktop is inactive in these scenarios:

- You locked your computer.
- The computer entered idle or sleep mode.
- The Teams mobile app is running in the background.

## Cause

This issue occurs if the latest Teams updates aren't installed.

## Workaround

After each step, check if the issue is resolved. If it isn’t, proceed to the next step.

1. Update Teams by clicking your profile picture at the top of the app and selecting **Check for updates**.
2. When your desktop resumes from inactive to active state, wait three minutes and check whether your presence status is updated.

   **Note:** It takes up to three minutes for the presence status to update from inactive to active.

For more information, see [User presence in Teams](/microsoftteams/presence-admins).

If none of the steps resolve the issue, ask your administrator to open a support ticket containing the following information:

- Sign-in address of the user.
- The desktop and debug logs. For more information about the logs, see [Use log files in troubleshooting Microsoft Teams](/microsoftteams/log-files).
- The UTC time at which you expect the presence shows your actual status. For the example described in Symptoms, that's the UTC time at which you expect the presence status is **Available** instead **Away**. Verify the time is captured in the above logs collected.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
