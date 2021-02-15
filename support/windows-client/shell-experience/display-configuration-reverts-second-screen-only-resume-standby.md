---
title: Display configuration reverts to 
description: Describes an issue in which Windows defaults to a different display configuration than expected when you plug an external monitor into a laptop. Provides a workaround.
ms.date: 12/07/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, chadbee, philipd, kimnich
ms.prod-support-area-path: DPI and Display Issues
ms.technology: windows-client-shell-experience
---
# Display configuration reverts to "Second screen only" after you resume from standby

This article provides a workaround to an issue in which display configuration reverts to "Second screen only" after you resume from standby.

_Original product version:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2890797

## Symptoms

On a Windows 10 or Windows 8-based laptop computer, you do the following:

1. Plug in an external monitor.
2. Change the display configuration to **Second screen only** (using the Windows logo key :::image type="content" source="./media/display-configuration-reverts-second-screen-only-resume-standby/windows-logo-key.jpg" alt-text="Windows logo key." border="false":::
+P keyboard shortcut).
3. Change the display configuration to **Duplicate** (using the Windows logo key :::image type="content" source="./media/display-configuration-reverts-second-screen-only-resume-standby/windows-logo-key.jpg" alt-text="Windows logo key." border="false":::
+P keyboard shortcut again).
4. Close the lid on the laptop computer.
5. Unplug the external monitor.
6. Open the lid on the computer.
7. Plug the external monitor back in.

In this scenario, the display configuration may revert to **Second Screen only** instead of remaining in **Duplicate** mode.

## Cause

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## Workaround

To work around this problem, use the Windows logo key :::image type="content" source="./media/display-configuration-reverts-second-screen-only-resume-standby/windows-logo-key.jpg" alt-text="Windows logo key." border="false":::)
+P keyboard shortcut to change the display configuration back to **Duplicate** mode.
