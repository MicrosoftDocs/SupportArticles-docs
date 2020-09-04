---
title: Automatic update not working in Teams
ms.author: v-todmc
author: McCoyBot
ms.date: 4/9/2020
audience: ITPro
ms.topic: article
manager: dcscontentpm
ms.service: msteams
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

There could be a couple issues causing Microsoft Teams to not automatically update.  
When Microsoft Teams is installed to Program Files using installation scripts rather than to the default location, the client doesn't auto-update when new versions are available.
Also, Microsoft Teams will update only when Teams is idle.  So, if a user finishes using Teams and then turns of the computer, Teams will have no way to run the update process.

## More information

The first issue is by design. Make sure you install the application in the default location: `user\Appdata`.
To force Microsoft Teams to check and install updates click your picture in the upper right hand corner and then click "Check for updates."  This will cause Microsoft Teams to check for updates and when finished installing will prompt the user to refresh.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
