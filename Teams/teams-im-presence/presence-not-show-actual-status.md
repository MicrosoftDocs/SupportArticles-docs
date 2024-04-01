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
  - CI 188840
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

### Run the Teams Presence diagnostic

> [!NOTE]
> This feature requires a Microsoft 365 administrator account. This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

1. Select the following button to populate the diagnostic in the Microsoft 365 admin center:

   > [!div class="nextstepaction"]
   > [Run Tests: Teams Presence](https://aka.ms/TeamsPresenceDiag)
1. In the **Username or Email** field, enter the email address of the affected user, and then select **Run Tests**.

### Run the Microsoft Remote Connectivity Analyzer test

> [!NOTE]
> Currently the Microsoft Remote Connectivity Analyzer tool doesn't support Microsoft 365 Government environments (GCC or GCC High).

1. Open a web browser, and then go to the [Teams Presence Based on Calendar Events](https://testconnectivity.microsoft.com/tests/TeamsCalendarPresence/input) test.
1. Sign in by using the credentials of the user account that you want to test.
1. Enter the provided verification code.
1. Select **Verify**.

This test verifies that Teams presence can be updated based on calendar events set in Outlook.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
