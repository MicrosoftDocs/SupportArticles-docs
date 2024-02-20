---
title: Can't play audio in a system with DisplayPort
description: Resolves an issue that occurs when you are playing audio whose source is a system that uses a DisplayPort or HDMI monitor.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:modern-inbox-and-microsoft-store-apps, csstroubleshoot
---
# Error message in the Xbox Music app, Windows Media Player, Groove Music, or Movies &TV when you wake a Windows 10-based or Windows 8-based computer

This article provides a solution to an issue where playing audio whose source is a system that uses a DisplayPort or HDMI monitor fails.

_Applies to:_ &nbsp; Windows 10, version 2004, Windows 10, version 1909, Windows 10, version 1809, Windows 10, version 1803, Windows 10, version 1709  
_Original KB number:_ &nbsp; 2841997

## Symptoms

Consider the following scenario:

- You have a Windows 10-based or Windows 8-based computer that has a DisplayPort or HDMI monitor to which integrated audio is attached. Or, you have an all-in-one system that uses DisplayPort audio. 
- You are playing audio by using the Xbox Music app, Windows Media Player, Groove Music, or Movies & TV, and the audio source is the monitor. 
- While the audio is playing, you put the system to sleep. Then, you wake the system.

In this scenario, you may receive the following error message in the Xbox Music app on Windows 8:

Can't play. Make sure your computer's sound and video cards are working and have the latest drivers, then try again.

0xc00d11d1 (0xc00d4e86)

Or, you may receive the following error message in Windows Media Player on Windows 10 and Windows 8:

An audio device was disconnected or reconfigured. Verify that the audio device is connected, and then try to play the item again.

This issue also occurs when you use the Groove Music and Movies & TV app in Windows 10. When the issue occurs, you receive one or more of the following error messages:

### Groove Music (audio file)

Can't play. We couldn't find your audio device are your headphones or speakers connected? If that's not it, you can go to the desktop and tap the speaker icon in the system tray for more help. 0xc00d4e86 (0xc00d4e86)

### Movies & TV (video file)

Can't play. We couldn't find your audio device are your headphones or speakers connected? If that's not it, you can go to the desktop and tap the speaker icon in the system tray for more help. 0xc00d4e86 (0xc00d4e86)

## Cause

This behavior is by design. When no other audio devices are connected to the system, the only audio endpoint on the system goes away when the monitor is powered off. Therefore, an error message is displayed by Xbox Music, Windows Media Player, Groove Music, or Movies & TV. The error messages will be displayed only on specific DisplayPort or HDMI monitors and will not occur if another audio output device is connected to the system.

## Resolution

If another audio output device is connected to the system, Xbox Music, Windows Media Player, Groove Music, or Movies & TV will switch to that audio device when the monitor is powered off and then back to the monitor when the monitor is powered back on. No error messages will be displayed.

To resume playback if no other audio devices are connected to the system when the monitor is powered off, you should open a different audio file or reopen the original audio file after the error message is displayed.
