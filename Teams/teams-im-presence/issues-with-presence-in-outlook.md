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
search.appverid: 
- MET150
---
# Issues with user presence status in Outlook

## Symptoms

There are several situations where the User presence to display incorrectly:

- The User presence status isn’t displayed in Outlook.
- The User presence status displayed is incorrect.
- The User presence status is displayed as Unknown.

  > [!NOTE]
  > Outlook currently displays user presence status as **Unknown** for federated (external) Teams contacts.

## Resolution

To correct this issue, perform the following steps manually:

1. Ensure that your computer is set up to display user presence status in Teams. See [User presence in Teams](https://docs.microsoft.com/microsoftteams/presence-admins) for more information.

   > [!NOTE]
   > The user presence feature in Outlook requires Microsoft Teams to be installed.

2. Verify with your contact that their email address and their Teams sign-in address are the same.

3. If steps 1 and 2 are both verified, check the **registry settings** to confirm that Teams is registered as the default instant messenger (IM) app.

   > [!NOTE]
   > Incorrectly editing the registry may severely damage your system. Before making changes to the registry, back up any valuable data on the computer.

   1. Launch **RegEdit.exe**

   2. Navigate to `HKEY_CURRENT_USER\Software\IM Providers`

   3. Verify the following value:

      - REG_SZ: **DefaultIMApp**

      - Value: **Teams**

### Contact an administrator

If these steps don’t resolve the issue, an administrator can create a support request and provide the following information:

- The sign-in address of the user who is experiencing the issue and seeing inaccurate presence information for a contact.

- The sign-in address of the contact whose presence is displayed as **Unknown** to the user.

- The desktop and web logs from both the user and contact. For information on collecting logs, see [Use log files in troubleshooting Microsoft Teams](https://docs.microsoft.com/microsoftteams/log-files).

For internal contacts, provide the results from the SaRa diagnostic tool.
