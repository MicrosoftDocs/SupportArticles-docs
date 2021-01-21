---
title: Teams degraded performance when it's remembered as a game through Xbox Game Bar
description: Fixes an issue in which Teams remembered as a game through Xbox Game Bar causes Teams performance issues.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: msteams
localization_priority: Normal
ms.custom: 
- CI 126346
- CSSTroubleshoot
ms.reviewer: samcos
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---
# Teams performance is affected when Teams is remembered as a game through Xbox Game Bar

This issue might occur when Xbox Game Bar is running on a computer that has ever run Windows 10 version 1809 ([released on November 13, 2018](https://support.microsoft.com/help/4464619/windows-10-update-history)).

This issue might occur because Microsoft Teams is remembered as a game by Xbox Game Bar. When Teams runs, Xbox Game Bar records in the background, thus causing the performance issue.

## Resolution

To resolve this issue, use one of the following methods:

### Method 1: Disable Teams as a game

1. Brings Teams up to the forefront of your screen.
2. Press Windows key + G to open **Xbox Game Bar**.
3. Go to **Settings** > **General**, clear the **Remember this is a game** check box.
4. Go to **Settings** > **Capturing**, clear the **Record in the background while I'm playing a game** check box.  

### Method 2: Disable Xbox Game Bar

1. Go to **Start**, select **Settings** > **Gaming** > **Xbox Game Bar**.
2. Turn off **Xbox Game Bar**.

   :::image type="content" source="media/performance-affected-when-teams-remembered-as-game/turn-off.png" alt-text="Screenshot of turning off Xbox Game Bar.":::

## More information  

To learn more, see [Xbox Game Bar on Windows 10](https://support.xbox.com/help/games-apps/game-setup-and-play/get-to-know-game-bar-on-windows-10).  

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
