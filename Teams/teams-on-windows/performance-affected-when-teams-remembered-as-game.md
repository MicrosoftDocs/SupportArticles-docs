---
title: Teams degraded performance if Teams is remembered as a game by XBOX Game Bar
description: Fixes an issue in which Teams experiences performance issues if it's remembered as a game by XBOX Game Bar.
author: Cloud-Writer
ms.author: meerak
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
# Teams performance is affected if it's remembered as a game by XBOX Game Bar

## Summary

Microsoft Teams might run slowly if XBOX Game Bar remembers it as a game on a computer that runs or previously ran Windows 10, version 1809. To restore performance, clear the **Remember this is a game** and background recording settings for Teams, or turn off XBOX Game Bar.

## Symptoms

The performance of Microsoft Teams is adversely affected if it's remembered by the Microsoft XBOX Game Bar on a computer that currently runs or has ever run Windows 10, version 1809 ([released on November 13, 2018](https://support.microsoft.com/help/4464619/windows-10-update-history)).

## Cause

This issue occurs because the XBOX Game Bar on Windows 10 is running in the background, and it remembers Teams as a game.

## Resolution

To resolve this issue, use one of the following methods.

### Method 1: Disable Teams as a game

1. Make Teams the active window on your screen.
2. Press Windows logo key+G to open **XBOX Game Bar**.
3. Go to **Settings** > **General**, and then clear the **Remember this is a game** check box.
4. Go to **Settings** > **Capturing**, and then clear the **Record in the background while I'm playing a game** check box.  

### Method 2: Disable XBOX Game Bar

1. Select **Start** > **Settings** > **Gaming** > **XBOX Game Bar**.
2. Turn off **XBOX Game Bar**.

   :::image type="content" source="media/performance-affected-when-teams-remembered-as-game/turn-off.png" alt-text="Screenshot that shows the turning off option in the XBOX Game Bar page.":::
