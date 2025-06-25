---
title: Teams degraded performance if Teams is remembered as a game by Xbox Game Bar
description: Fixes an issue in which Teams experiences performance issues if it's remembered as a game by Xbox Game Bar.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Clients\Windows Desktop
  - CI 126346
  - CSSTroubleshoot
ms.reviewer: samcos
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---
# Teams performance is affected if it's remembered as a game by Xbox Game Bar

The performance of Microsoft Teams is adversely affected if it's remembered by the Microsoft Xbox Game Bar on a computer that currently runs or has ever run Windows 10, version 1809 ([released on November 13, 2018](https://support.microsoft.com/help/4464619/windows-10-update-history)).

## Cause

This issue occurs because the Xbox Game Bar on Windows 10 is running in the background, and it remembers Teams as a game.

## Resolution

To resolve this issue, use one of the following methods.

### Method 1: Disable Teams as a game

1. Make Teams the active window on your screen.
2. Press Windows logo key+G to open **Xbox Game Bar**.
3. Go to **Settings** > **General**, and then clear the **Remember this is a game** check box.
4. Go to **Settings** > **Capturing**, and then clear the **Record in the background while I'm playing a game** check box.  

### Method 2: Disable Xbox Game Bar

1. Select **Start** > **Settings** > **Gaming** > **Xbox Game Bar**.
2. Turn off **Xbox Game Bar**.

   :::image type="content" source="media/performance-affected-when-teams-remembered-as-game/turn-off.png" alt-text="Screenshot that shows the turning off option in the Xbox Game Bar page.":::

## More information  

[Xbox Game Bar on Windows 10](https://support.xbox.com/help/games-apps/game-setup-and-play/get-to-know-game-bar-on-windows-10)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
