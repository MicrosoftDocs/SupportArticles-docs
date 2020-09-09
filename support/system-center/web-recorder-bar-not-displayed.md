---
title: Web recorder bar is missing in Internet Explorer
description: Fixes an issue in which the Web recorder bar is missing in Internet Explorer when attempting to record a browser session as part of creating a Web Application monitor.
ms.date: 08/18/2020
ms.prod: system-center
ms.prod-support-area-path: 
ms.reviewer: jchornbe
---
# The Web recorder bar doesn't display in Internet Explorer when attempting to record a browser session

This article provides a solution to an issue in which the Web recorder bar is missing in Internet Explorer when attempting to record a browser session as part of creating a Web Application monitor.

_Original product version:_ &nbsp; System Center Essentials 2010  
_Original KB number:_ &nbsp; 2379524

## Symptoms

When using System Center Essentials 2010, the Web recorder bar doesn't display in Internet Explorer when attempting to record a browser session as part of creating a Web Application monitor.

## Cause

Internet Explorer is opening in 32-bit (x86) mode rather than 64-bit (x64) mode.

## Resolution

To work around this issue, complete the following steps:

1. Open the web application editor.
2. Hit **Start Capture**. It will launch Internet Explorer in 32-bit mode. Close this browser.
3. From the **Start** menu, run Internet Explorer (64-bit).
4. The web recorder will appear. If not, choose **View** > **Explorer Bars** > **Web Recorder**.
