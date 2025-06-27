---
title: The correct presence status isn't reflected in Teams
description: Fixes an issue in which your actual presence status isn't displayed in Teams.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams People & Presence\Presence from Teams
  - CI 126266
  - CI 188840
  - CSSTroubleshoot
ms.reviewer: sylviebo, premgan
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 05/28/2024
---
# The correct presence status isn't reflected in Teams

In Microsoft Teams, your presence status is shown incorrectly. For example, your presence status changes to **Away** if your desktop is inactive for more than five minutes. However, when you resume activity on your desktop, your presence status doesn't change to **Available**.

**Note:** Your desktop is inactive in the following scenarios:

- You lock your computer.
- The computer enters idle or sleep mode.
- You're actively using the Teams mobile app instead of Teams on the desktop.

To identify the cause of the issue, use one of the following methods.

## Method 1: Run a connectivity test

Both administrators and non-administrators can run the [Teams Presence Based on Calendar Events](https://testconnectivity.microsoft.com/tests/TeamsCalendarPresence/input) connectivity test in the Microsoft Remote Connectivity Analyzer tool. This tool is used to troubleshoot connectivity issues that affect Teams. The connectivity test verifies the requirements to update a user’s presence status in Teams based on their calendar events in Microsoft Outlook.

> [!NOTE]
> The Microsoft Remote Connectivity Analyzer tool isn't available for the GCC and GCC High Microsoft 365 Government environments.

Follow these steps:

1. Open a web browser and navigate to the [Teams Presence Based on Calendar Events](https://testconnectivity.microsoft.com/tests/TeamsCalendarPresence/input) test.
1. Sign in by using the credentials of the affected user account.
1. Enter the verification code that's displayed, and then select **Verify**.
1. Select the checkbox to accept the terms of agreement, and then select **Perform Test**.

After the test is finished, the screen displays details about the checks that were performed and whether the test succeeded, failed, or was successful but displayed a few warnings. Select the provided links for more information about the warnings and failures and how to resolve them.

## Method 2: Run a self-help diagnostic

If you're an administrator, you can run the [Teams Presence](https://aka.ms/TeamsPresenceDiag) diagnostic in the Microsoft 365 admin center to verify the requirements to display a user's presence status in Teams.

> [!NOTE]
> This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

Follow these steps:

1. Select the **Run Tests** button to populate the diagnostic in the Microsoft 365 admin center:

   > [!div class="nextstepaction"]
   > [Run Tests: Teams Presence](https://aka.ms/TeamsPresenceDiag)
1. In the **Username or Email** field, enter the email address of the affected user, and then select **Run Tests**.

After the diagnostic is finished, select the provided links to resolve the issues that were found.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
