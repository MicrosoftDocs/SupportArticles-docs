---
title: Issues with user presence status in Outlook
description: Fixes an issue in which the status of a user presence is displayed incorrectly.
author: v-miegge
ms.author: meerak
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: msteams
localization_priority: Normal
ms.custom: 
- CI 126269
- CSSTroubleshoot
ms.reviewer: sylviebo
appliesto:
- Microsoft Teams
- Outlook
search.appverid: 
- MET150
---
# Issues with user presence status in Outlook

## Symptoms

You see any of the following issues when you check the presence status for a user in Outlook:

- The presence indicator is not visible.
- The displayed presence is incorrect.
- The presence status is **Status Unknown**.

  > [!NOTE]
  > Outlook currently shows **Status Unknown** for federated (external) Teams contacts.

## Resolution

To fix these issues, download and run the [Microsoft Support and Recovery Assistant (SARA)](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f) for automated troubleshooting steps and fixes.

Or, follow these manual steps:

1. Make sure that the Teams app on your computer is configured to display the presence status. for more information, see  [User presence in Teams](https://docs.microsoft.com/microsoftteams/presence-admins).

   > [!NOTE]
   > The presence feature in Outlook requires Microsoft Teams to be installed and configured to display presence status.

2. For the contact whose presence you can’t see, verify that their email address and Teams sign-in address are the same. If they are not, the contact should correct the addresses as necessary, sign out of Teams, and then sign back in.

3. If the issue persists, check the **registry settings** on your computer to verify that Teams is registered as the default instant messaging (IM) app.

   > [!WARNING]
   > Incorrectly editing the registry may severely damage your system. Before making changes to the registry, back up any valuable data on the computer.

   1. Start Registry Editor

   2. Locate the following subkey: `HKEY_CURRENT_USER\Software\IM Providers`

   3. Verify the following value:

      - **Name**: DefaultIMApp
      - **Type**: REG_SZ
      - **Data**: Teams

### Contact an administrator

If these steps don’t resolve the issue, an administrator should create a support request in the Teams Admin Center, and provide the following information:

- The sign-in address of the user who is experiencing the issue and seeing an inaccurate presence status for a contact.

- The sign-in address of the contact whose presence is shown as **Status unknown** to the user.

- The desktop and web logs from both the user and the contact. For information about how to collect logs, see [Use log files in troubleshooting Microsoft Teams](https://docs.microsoft.com/microsoftteams/log-files).

  - For presence issues that affect contacts who are internal to your organization, provide the results from running the SARA tool.
