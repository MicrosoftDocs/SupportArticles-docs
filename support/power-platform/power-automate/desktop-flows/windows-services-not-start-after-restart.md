---
title: Power Automate service doesn't start automatically after restarting
description: Provides a resolution for the issue where the Power Automate-related services don't start automatically after restarting a computer.
ms.reviewer: guco, tapanm
author: johndund
ms.author: johndund
ms.date: 03/31/2023
ms.subservice: power-automate-desktop-flows
---
# Power Automate service won't start automatically after restarting

This article provides a resolution for the issue where the **Power Automate service** or other related services don't automatically start after you restart a computer.

_Applies to:_ &nbsp; Power Automate  

## Symptoms

When a computer restarts, the **Power Automate service**, **Power Automate agent launcher service**, **Power Automate update service**, or **Power Automate log shipper service** doesn't start automatically.

## Cause

This issue can be caused by Windows updates which may slow down the startup time of services on your computer. By default, you're limited to a 30-second startup time in a Windows service, and the service may take longer to start after an update.

To check whether a service is timed out during startup, go to **Windows Logs** > **System** in **Event Viewer**. Then, use <kbd>CTRL</kbd>+<kbd>F</kbd> to look for the name of the service as seen in **Task Manager** that didn't start automatically, for example, **UIFlowService** or **UIFlowAgentLauncherService**.

## Resolution

To resolve this issue, you can start the service manually using the **Services** snap-in. Go to the Start menu and type _Services_ to open the snap-in. Find the **Power Automate service** or whichever service isn't started, right-click it and select **Start**.
