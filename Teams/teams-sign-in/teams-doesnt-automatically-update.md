---
title: Automatic update not working in Teams
ms.author: meerak
author: Cloud-Writer
ms.date: 03/11/2024
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Identity and Auth\
  - CI 113425
  - CI 187812
  - CSSTroubleshoot
ms.reviewer: scapero
description: Resolves an issue where Teams doesn't automatically update.
---

# Teams doesn't automatically update

## Summary

More than one reason can prevent Microsoft Teams from automatically updating:

- When Microsoft Teams is installed to the Program Files folder (such as by using installation scripts) rather than to the default location, the client won't automatically update when new versions are available.
- Microsoft Teams will update only when Teams is idle. If a user powers off the computer when finished using Teams, Teams will have no way to run the update process.
- Users need to be signed in for updates to be downloaded.

> [!NOTE]
> If you find some features are missing, it's because Teams isn't updated.

## Workaround

To make sure Teams automatically updates, install the application in the default location: `user\Appdata`.

To force Microsoft Teams to check and install updates, select your avatar in the upper-right corner of Teams, and then select **Check for updates**. This will cause Microsoft Teams to check for updates.

## More information

For more information about Teams update process, see [Teams update process](/microsoftteams/teams-client-update).

For more information about how to update the Teams desktop app on Virtual Desktop Infrastructure (VDI), see [Install or update the Teams desktop app on VDI](/microsoftteams/teams-for-vdi#install-or-update-the-teams-desktop-app-on-vdi).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
