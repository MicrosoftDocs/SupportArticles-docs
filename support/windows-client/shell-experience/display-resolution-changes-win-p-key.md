---
title: Display resolution changes to a lower resolution
description: Fixes an issue where the display resolution may change to a lower resolution when you use the Presentation Display Mode keyboard shortcut (Windows logo key + P) to change the mode to Duplicate.
ms.data: 09/08/2020
author: delhan
ms.author: Delead-Han
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: DPI and Display Issues
ms.technology: ShellExperience
---
# Display Changes Resolution on Windows 7 While Pressing Win+P Hot Key and Select Duplicate When Only One Monitor is Connected

This article helps fix an issue where the display resolution may change to a lower resolution when you use the Presentation Display Mode keyboard shortcut (Windows logo key + P) to change the mode to Duplicate.

_Original product version:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2518084

## Symptoms

You will notice that the display resolution may change to a lower resolution when you use the Presentation Display Mode keyboard shortcut (Windows logo key + P) to change the mode to Duplicate on a Windows 7 Computer with only one monitor connected. This issue typically occurs on different models and brands of video graphic adapters when connected via DVI or Display Port.

## Cause

This is expected behavior with video adapters that have multiple DVI or Display Port connections. Even though you only have one monitor physically connected to the video adapter, there are still other DVI / Display Port connections that are not used but available. When you change the Presentation Display Mode to Duplicate, the system will try to synchronize with the video port connections and will default to a compatible video resolution of a non-DVI / Display Port connection.

## Resolution

To revert display resolution settings back to the previous setting. Use the Presentation Display Mode keyboard shortcut (Windows logo key
+P) and change the mode to "Computer only"

## More information

Windows 7 Keyboard shortcuts
https://windows.microsoft.com/en-US/windows7/Keyboard-shortcuts
