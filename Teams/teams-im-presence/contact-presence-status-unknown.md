---
title: A contact's presence is unknown in Teams
description: Fixes an issue in which the presence of a contact is displayed as Status unknown in Teams.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams People & Presence\Presence from Teams
  - CI 126266
  - CSSTroubleshoot
ms.reviewer: sylviebo, premgan
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---
# A contact's presence status is unknown in Teams

## Symptoms

In Microsoft Teams, the presence status of a contact is displayed as **Status unknown**, or the status doesn't update.

## Cause

This issue occurs if one or more of the following conditions are true:

- The contact is offline (the contact hasn't signed in to Teams).
- The contact set the presence status to **Appear offline**.
- A network communication issue is affecting the unified presence service (UPS).
- The contact is using Microsoft Skype for Business. Based on the [Presence](/microsoftteams/coexistence-chat-calls-presence#presence) in the coexistence scenario, this issue may be an expected behavior.

## Workaround

The following steps must be performed by administrators. After each step, check whether the issue is fixed. If it isn't, go to the next step.

1. Verify that the contact has signed in to Teams.
2. Verify that the contact hasn't set the presence status to **Appear offline**.
3. Verify the network connectivity to [Teams endpoints](/microsoft-365/enterprise/urls-and-ip-address-ranges#skype-for-business-online-and-microsoft-teams).
4. Verify that the contact is currently using Teams.

If none of these steps fixes the issue, open a support ticket that contains the following information:

- The sign-in address of the user (also known as *observer*) who sees that the presence of the contact is **Status unknown**.
- The sign-in address of the contact (also known as *publisher*) whose presence shows as **Status unknown**.
- The desktop and debug logs from both the observer and publisher. For more information about the logs, see [Use log files in troubleshooting Microsoft Teams](/microsoftteams/log-files).
- The UTC time at which the publisher updated the presence, and the time at which the observer noticed that the contact's presence status wasn't updated. Verify that the times are captured in all the log files.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
