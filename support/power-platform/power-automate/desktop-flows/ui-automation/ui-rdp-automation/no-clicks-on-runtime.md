---
title: Can't Click Elements in Citrix Virtual Apps
description: Solves an issue where hovering over elements in Citrix Virtual Apps works, but clicking the elements during runtime doesn't work.
ms.reviewer: amitrou
ms.author: iopanag
author: iopanag
ms.custom: sap:Desktop flows\UI or browser automation
ms.date: 04/29/2025
---
# Elements are highlighted in Citrix Virtual Apps, but clicking them at runtime doesn't work 

This article provides steps to resolve an issue where UI element interactions don't work when running actions in Citrix Virtual Apps, even though the UI elements are properly highlighted and captured.

## Symptoms

When you use the [UI element picker](/power-automate/desktop-flows/ui-elements#ui-elements-types) to interact with Citrix Virtual Apps, you can highlight and capture elements successfully. However, when these captured elements are used in an action (for example, **Click Element in Window**), the interaction doesn't execute, and no error message is displayed. The [Test Selector](/power-automate/desktop-flows/test-selectors) functionality works as expected.

## Cause

The Citrix Workspace High DPI (HIDPI) settings might interfere with Power Automate for desktop interactions. This issue is commonly observed in setups involving multiple monitors.

## Resolution

To solve this issue, follow these steps:

1. Disable the Citrix Workspace HIDPI option:

    1. From the system tray, right-click the Citrix Workspace app icon.
    1. Select **Advanced Preferences** > **High DPI**.
    1. In the **High DPI** settings, select the **Let the operating system scale the resolution** option.
    1. Select **Save** and close the Citrix Workspace preferences windows.

1. Close any active Citrix Desktops or Virtual Apps.
1. Restart the Citrix Desktops or Virtual Apps.

1. (Optional) Adjust the desktop scaling of the machine running Power Automate for desktop to 100%. For unattended machines, see [Set screen resolution on unattended mode](/power-automate/desktop-flows/how-to/set-screen-resolution-unattended-mode).

[!INCLUDE [Third-party disclaimer](../../../../../includes/third-party-disclaimer.md)]
