---
title: Display resolution changes to a lower resolution
description: Fixes an issue where the display resolution may change to a lower resolution when you use the Presentation Display Mode keyboard shortcut (Windows logo key + P) to change the mode to Duplicate.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dpi-and-display-issues, csstroubleshoot
---
# Display changes resolution in Windows 7 while pressing Win+P hot key and select duplicate when only one monitor is connected

This article helps fix an issue where the display resolution may change to a lower resolution when you use the Presentation Display Mode keyboard shortcut (Windows logo key + P) to change the mode to Duplicate.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2518084

## Symptoms

You will notice that the display resolution may change to a lower resolution when you use the Presentation Display Mode keyboard shortcut (Windows logo key + P) to change the mode to Duplicate in a Windows 7 Computer with only one monitor connected. This issue typically occurs on different models and brands of video graphic adapters when connected via DVI or Display Port.

## Cause

This is expected behavior with video adapters that have multiple DVI or Display Port connections. Even though you only have one monitor physically connected to the video adapter, there are still other DVI/Display Port connections that are not used but available. When you change the Presentation Display Mode to Duplicate, the system will try to synchronize with the video port connections and will default to a compatible video resolution of a non-DVI/Display Port connection.

## Resolution

To revert display resolution settings back to the previous setting. Use the Presentation Display Mode keyboard shortcut (Windows logo key
+P) and change the mode to Computer only.

## References

[Windows 7 Keyboard shortcuts](https://support.microsoft.com/windows/keyboard-shortcuts-in-windows-dcc61a57-8ff0-cffe-9796-cb9706c75eec#ID0EBD=Windows_7)
