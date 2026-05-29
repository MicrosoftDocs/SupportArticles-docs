---
title: Fix High CPU or Memory Usage in Microsoft Edge Browser
description: Troubleshoot high CPU or memory usage in Microsoft Edge. Identify the responsible process, manage extensions, turn on sleeping tabs, and reduce resource use.
ms.date: 05/29/2026
ms.reviewer: Johnny.Xu, dili, v-shaywood
ms.custom: 'sap:Stability and Performance\Browser Slow Performance: including Sleeping Tabs and Efficiency Mode'
---

# Fix high CPU or memory usage in Microsoft Edge

## Summary

This article helps you identify why Microsoft Edge is using high CPU or memory and reduce its resource consumption. The guidance covers diagnosing busy processes with the Browser task manager, isolating extensions, turning on sleeping tabs, stopping background activity, and confirming that hardware acceleration is in use.

## Symptoms

You experience one or more of the following symptoms:

- One or more `msedge.exe` processes consistently use a large share of CPU when the browser is idle.
- Edge memory usage is much higher than expected with only a few tabs open.
- The system feels sluggish when Edge is running.
- Switching between tabs is slow.

## Solution

Work through the following sections in order. After each section, observe Edge for several minutes and check whether resource usage drops before you continue.

### Identify the responsible process with the Browser task manager

1. In Edge, press <kbd>Shift</kbd>+<kbd>Esc</kbd> to open the Browser task manager.
1. Sort by **CPU** or **Memory** to find the responsible tab, extension, subframe, or utility process.
1. Select the process, and then select **End process**.
1. Check whether system load drops.

### Turn off extensions

Extensions can cause high CPU usage.

1. Go to `edge://extensions/`.
1. Turn off all extensions, and then observe Edge.
1. If usage returns to normal, turn extensions back on one at a time to find the one that causes the problem.

### Turn on sleeping tabs

1. Go to `edge://settings/system/managePerformance`.
1. Turn on **Save resources with sleeping tabs**.
1. Adjust the inactivity timeout.
1. Add any sites that should never sleep to the exception list.

For enterprise management, see the [SleepingTabsEnabled](/deployedge/microsoft-edge-policies/sleepingtabsenabled), [SleepingTabsTimeout](/deployedge/microsoft-edge-policies/sleepingtabstimeout), and [SleepingTabsBlockedForUrls](/deployedge/microsoft-edge-policies/sleepingtabsblockedforurls) policies.

### Turn off background apps

If Edge keeps using CPU after you close all windows, background processes are still running.

1. Go to `edge://settings/system`.
1. Turn off **Continue running background extensions and apps when Microsoft Edge is closed**.

For enterprise management, see the [BackgroundModeEnabled](/deployedge/microsoft-edge-policies/backgroundmodeenabled) policy.

### Confirm that hardware acceleration is on

Software rendering of video, WebGL, and canvas content increases CPU usage.

1. Go to `edge://gpu`.
1. Review **Graphics Feature Status** and confirm that hardware acceleration is in use.
1. If items show software-only rendering:
   1. Update your GPU driver.
   1. Make sure **Use graphics acceleration when available** is turned on at `edge://settings/system`.

For enterprise management, see the [HardwareAccelerationModeEnabled](/deployedge/microsoft-edge-policies/hardwareaccelerationmodeenabled) policy.

### Reset Edge settings

1. Go to `edge://settings/reset`.
1. Select **Restore settings to their default values**.

> [!NOTE]
> Bookmarks, history, and saved passwords are preserved. Pinned tabs, startup page, search engine, and extensions are reset.

## Data collection

If you need to contact Microsoft Support for more help, collect the following diagnostic information and include it with your support request.

- **Microsoft Edge version**: Go to `edge://settings/help`, and note the full version number.
- **Browser task manager screenshots**: Press <kbd>Shift</kbd>+<kbd>Esc</kbd>, and take one screenshot sorted by **CPU** and another sorted by **Memory**.
- **Discarded tabs report**: Go to `edge://discards`, and save the output.

## Related content

- [Microsoft Edge policy reference](/deployedge/microsoft-edge-policies)
- [Microsoft Edge known issues](/deployedge/microsoft-edge-known-issues)
