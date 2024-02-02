---
title: Fonts may not all get scaled properly when you change DPI setting
description: Provides a solution to an issue that the fonts may not all get scaled properly when changing the DPI setting on Windows 7.
ms.date: 09/23/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dpi-and-display-issues, csstroubleshoot
---
# Some fonts may be scaled too large or too small when you change the DPI setting in Windows 7

This article provides a solution to an issue that the fonts may not all get scaled properly when you change the DPI setting in Windows 7 Service Pack 1.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2556182

## Symptoms

Consider the following scenario on a Windows 7 Service Pack 1 machine:

- Right-click on the desktop and click **Personalize**.
- Click **Display** to bring up the DPI adjustment window, which is titled **Make it easier to read what's on your screen**.
- Change from the current setting to a larger or smaller setting, then click **Log off now**.

When you perform these steps, sometimes the fonts may not all get scaled properly. Certain fonts in the user interface may be either too large or too small.

## Cause

This is the result of a timing issue between the Explorer and Winlogon processes. When this condition happens, certain fonts get resized twice.

## Resolution

Change the DPI setting again to reset the font to a normal size.

> [!NOTE]
> You may need to change the setting a few times.
