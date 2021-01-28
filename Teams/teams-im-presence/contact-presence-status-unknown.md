---
title: A contact's presence is unknown in Teams
description: Fixes an issue in which the presence status of a contact is displayed as unknown in Teams.
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
# A contact's presence status is unknown in Teams

## Symptoms

In Microsoft Teams, the presence status of a contact is displayed as unknown, or the status won't update.

## Cause

This issue occurs if one or more of the following conditions are true:

- The contact is offline (the contact hasn't signed into Teams).
- The contact has set the presence status to **Appear offline**.
- There's a network communication issue with the unified presence service (UPS).
- The contact is using Skype for Business. Based on the [Presence](/microsoftteams/coexistence-chat-calls-presence#presence) in the coexistence scenario, this issue may be an expected behavior.

## Workaround

The following steps must be performed by administrators. After each step, check if the issue is resolved. If it isn’t, proceed to the next step.

1. Verify that the contact has signed in to Teams.
2. Verify that the contact hasn't set the presence status to **Appear offline**.
3. Verify the network connectivity to [Teams endpoints](/microsoft-365/enterprise/urls-and-ip-address-ranges#skype-for-business-online-and-microsoft-teams).
4. Verify that the contact is currently using Teams.

If none of the steps resolve the issue, open a support ticket containing the following information:

- Sign-in address of the user (also known as Observer) who sees the unknown presence status of the contact.
- Sign-in address of the contact (also known as Publisher) whose presence status shows as unknown.
- The desktop and debug logs from both the observer and the publisher. For more information about the logs, see [Use log files in troubleshooting Microsoft Teams](/microsoftteams/log-files).
- The UTC time at which the publisher updated the presence, and the time at which the observer couldn't see the updated presence status. Verify that the time is captured in the logs mentioned above.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
