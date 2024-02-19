---
title: Microsoft Store Apps can't start
description: Provides a solution to an issue where Microsoft Store Apps can't start after the Users directory, a user profile, or the ProgramData directory is moved from their default locations.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:modern-inbox-and-microsoft-store-apps, csstroubleshoot
---
# Microsoft Store Apps fail to start if the user profiles or the ProgramData directory are moved from their default location

This article provides a solution to an issue where Microsoft Store Apps can't start after the Users directory, a user profile, or the ProgramData directory is moved from their default locations.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2787623

## Symptoms

After moving the Users directory, an individual user profile, or the ProgramData directory from their default locations, Microsoft Store Apps will no longer start. Various symptoms may be noticed. Some of the symptoms you may see are:

- Clicking the tile for a Microsoft Store App or the Microsoft Store will begin to launch the app but will return to the start screen. No error is displayed.

- Clicking the tile for the Microsoft Store will fail to open the store and return the error:

    > We weren't able to connect to the Store. This might have happened because of a server problem or the network connection timed out. Wait a few minutes and try again. Clicking "try again"  may or may not succeed in connecting you to the Store.

- Clicking the tile for the Microsoft Store will open the Store but attempting to purchase apps will return the error:

    > Your purchase couldn't be completed

- The modern PC settings app will not open nor will any of the apps accessed from there.

- The modern Windows Update will not open however the legacy Windows Update accessed via Control Panel will.

## Cause

When the Users directory, an individual user profile, or the ProgramData directory is moved to another location other than their default locations, Microsoft Store Apps are no longer supported or expected to work.

## Resolution

Don't alter the default location of the USERS directory (c:\users by default) or any individual users profile. Don't alter the default location of the ProgramData directory (c:\ProgramData by default)

## More information

Details on the method of relocating the Users and ProgramData directories are located at the links below. These methods are provided as is and intended for test environments only. These methods clearly state that the Microsoft Store and Microsoft Store apps aren't supported if they're used.

- [Profilesdirectory](/previous-versions/windows/it-pro/windows-8.1-and-8/ff715636(v=win.10))

- [Programdata](/previous-versions/windows/it-pro/windows-8.1-and-8/ff716245(v=win.10))
