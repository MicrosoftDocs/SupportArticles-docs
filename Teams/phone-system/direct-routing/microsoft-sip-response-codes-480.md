---
title: SIP 480 and Microsoft response codes
description: Lists combinations of Microsoft response code and the SIP 480 error, and provides actions to resolve the errors.
ms.date: 12/04/2024
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Calling (PSTN)\Direct Routing
  - CI173631
  - CI188844
  - CSSTroubleshoot
ms.reviewer: teddygyabaah
---

# SIP response code 480

This article provides troubleshooting information for various combinations of the SIP "480" error and Microsoft response codes.

## 10037 480 No callee endpoints were found

- Microsoft response code: **10037**
- SIP response code: **480**
- Suggested actions:  
  - Ask the callee to make sure that they are signed in to the Teams client. If the callee is currently signed in to the Teams client, ask the callee to sign out and sign in again. If the issue persists, [contact Microsoft Support](https://support.microsoft.com/contactus).

## 10140 480 Call to bot is rejected due to null user settings or user app settings

- Microsoft response code: **10140**
- SIP response code: **480**
- Suggested actions:  
  - [Contact Microsoft Support](https://support.microsoft.com/contactus).

## 10191 480 Routing to voicemail is disabled in policy

- Microsoft response code: **10191**
- SIP response code: **480**
- Suggested actions:
  - Run the Teams Voicemail connectivity test.
  
    Both administrators and non-administrators can run the [Teams Voicemail connectivity test](https://testconnectivity.microsoft.com/tests/TeamsVoicemail/input) in the Microsoft Remote Connectivity Analyzer tool. This tool is used to troubleshoot connectivity issues that affect Teams. The connectivity test determines whether a user account meets the requirements to access voicemail, and whether the Teams client can retrieve and display voicemail messages.

    > [!NOTE]
    > The Microsoft Remote Connectivity Analyzer tool isn't available for the GCC and GCC High Microsoft 365 Government environments.

    To run the connectivity test, follow these steps:

    1. Open a web browser and navigate to the [Teams Voicemail connectivity test](https://testconnectivity.microsoft.com/tests/TeamsVoicemail/input).
    1. Sign in by using the credentials of the affected user account.
    1. Enter the verification code that's displayed, and then select **Verify**.
    1. Select the checkbox to accept the terms of agreement, and then select **Perform Test**.

    After the test is finished, the screen displays details about the checks that were performed and whether the test succeeded, failed, or was successful but displayed a few warnings. Select the provided links for more information about the warnings and failures and how to resolve them.
  - If you're using the GCC or GCC High environment, see [Control routing of calls to Cloud Voicemail](/MicrosoftTeams/set-up-phone-system-voicemail#control-routing-of-calls-to-cloud-voicemail).
