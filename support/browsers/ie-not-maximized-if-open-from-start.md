---
title: Internet Explorer not maximized if opens from Start
description: This article helps you to solve the issue that Internet Explorer cannot be opened in maximized state when you try to start it by clicking the short cut in the Start menu.
ms.date: 03/04/2020
ms.prod-support-area-path: Internet Explorer
---
# Internet Explorer does not open maximized when you click on the short cut in the Start menu

This article provides the resolution to solve the problem that Internet Explorer does not open in the maximized state when you click the Internet Explorer short cut in the Start menu.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 555217

## Cause

This issue occurs because the short cut to Internet Explorer has its default "Run" property as "Normal Window".

## Resolution

Follow the steps to solve this issue:

1. Right click on the desktop and create a short cut to "Program Files/Internet Explorer/iexplore.exe".

2. Right click on the short cut and then select **Properties**.

3. Click on the **Shortcut** tab and then change the value in the Run command to "Maximized".

4. Click **Apply**.

Now Internet Explorer will open in the maximized state when you click on any short cut to iexplore.exe.
