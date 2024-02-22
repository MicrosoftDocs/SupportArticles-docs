---
title: Automatic update not working in Teams
ms.author: luche
author: helenclu
ms.date: 10/30/2023
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - CI 113425
  - CSSTroubleshoot
ms.reviewer: scapero
description: Resolves an issue where Teams does not automatically update.
---

# Teams does not automatically update

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

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
