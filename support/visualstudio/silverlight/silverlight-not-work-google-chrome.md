---
title: Silverlight may not work in Google Chrome
description: This article provides a workaround for the problem that occurs when you use Google Chrome (version 42.0 or later) to access a website that runs Microsoft Silverlight.
ms.date: 01/21/2021
ms.prod-support-area-path: visualstudio/silverlight
ms.technology:
ms.reviewer: 
ms.topic: troubleshooting
---
# Microsoft Silverlight may not work in recent versions of Google Chrome

This article helps you work around the problem that occurs when you use Google Chrome (version 42.0 or later) to access a website that runs Microsoft Silverlight.

_Applies to:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 3058254

## Symptoms

When you use Google Chrome (version 42.0 or later versions) to access a website that runs Microsoft Silverlight, you see that some content is missing or that the **Install Microsoft Silverlight** badge is displayed. When you reinstall Silverlight, the issue still occurs.

> [!NOTE]
> This issue does not occur in Microsoft Internet Explorer, Mozilla Firefox, or Apple Safari. These browsers still support Silverlight content.

## Cause

This issue occurs because these versions of Chrome block Netscape Plugin API (NPAPI) plugins from being displayed in the browser. Silverlight is an NPAPI plugin.

## Workaround

On Chrome version 45 or a later version of Chrome, there is no workaround for this issue. You must use a browser that supports Silverlight content to access a Silverlight page.

To work around this issue on versions 42 to 44 of Chrome, follow these steps:

1. On the address bar in Chrome, type `chrome://flags/#enable-npapi`.
1. In the **Enable NPAPI Mac, Windows** box, click **Enable**.
1. Exit and then restart Chrome.
1. Reopen the Silverlight page.
1. Right-click the broken puzzle piece image, and then select **Run this Plugin**.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
