---
title: Your actual presence status isn't displayed in Teams
description: Fixes an issue in which your actual presence status isn't displayed in Teams.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 126266
  - CSSTroubleshoot
ms.reviewer: sylviebo, premgan
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---
# Your actual presence status isn't reflected in Teams

## Symptoms

In Microsoft Teams, your presence status is shown incorrectly. For example, your presence status changes to **Away** if your desktop is inactive for more than 5 minutes. However, when you resume activity on your desktop, your presence status doesn't immediately change to **Available**.

**Note:** Your desktop is inactive in these scenarios:

- You lock your computer.
- The computer enters idle or sleep mode.
- The Teams mobile app is running in the background.

## Cause

This issue occurs if the latest Teams updates aren't installed.

## Workaround

Try the first workaround, and check whether the issue is resolved. If it isn't, go to the second workaround.

### Workaround 1

Update Teams: Select your profile picture at the top of the app, and then select **Check for updates**.

### Workaround 2

After your desktop resumes from an inactive to an active state, wait three minutes, and then check whether your presence status is updated.

> [!NOTE]
> For users whose mailbox is hosted on-premises, it's expected to have presence delays with a maximum of an hour.

For more information, see [User presence in Teams](/microsoftteams/presence-admins).

If neither workaround fixes the issue, open a support ticket that contains the following information:

**Note:** This step must be performed by administrators.

- Sign-in address of the user.
- The desktop and debug logs. For more information about the logs, see [Use log files in troubleshooting Microsoft Teams](/microsoftteams/log-files).
- The UTC time at which you might expect that the presence indicator shows the user's actual status. For the example that's described in the "Symptoms" section, this would be when you expect that the presence status would show **Available** instead of **Away**. Verify that the UTC time is captured in the collected logs.

### Run a self-diagnostics tool

Microsoft 365 admin users have access to diagnostic tools that they can run within the tenant to verify possible issues that affect user presence.

> [!NOTE]
> This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

Select the **Run Tests** link. This will populate the diagnostic in the Microsoft 365 admin center.

> [!div class="nextstepaction"]
> [Run Tests: Teams presence](https://aka.ms/TeamsPresenceDiag)

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
