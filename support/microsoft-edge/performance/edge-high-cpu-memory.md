---
title: Fix High CPU or memory usage in Microsoft Edge browser
description: Troubleshoot high CPU or memory usage in Microsoft Edge. Identify the responsible process, manage extensions, turn on sleeping tabs, and reduce resource use.
ms.date: 05/29/2026
ms.reviewer: Johnny.Xu, dili, v-shaywood
ms.custom: 'sap:Stability and Performance\Browser Slow Performance: including Sleeping Tabs and Efficiency Mode'
---

# Fix high CPU or memory usage in Microsoft Edge

## Summary

This article helps you identify why Microsoft Edge is using high CPU activity or memory, and how to reduce its resource consumption. The guidance includes diagnosing busy processes by using the Browser Task Manager, isolating extensions, turning on sleeping tabs, stopping background activity, and verifying that hardware acceleration is in use.

## Symptoms

You experience one or more of the following symptoms:

- One or more `msedge.exe` processes consistently use a large share of CPU power while the browser is idle.
- Edge memory usage is much higher than expected when only a few tabs are open.
- The system feels sluggish when Edge is running.
- Switching between tabs is slow.

## Solution

Work through the following sections in the given order. After each section, observe Edge for several minutes, and check whether resource usage drops before you continue.

### Identify the responsible process by using the Browser Task Manager

1. Open the Browser Task Manager: In Edge, press <kbd>Shift</kbd>+<kbd>Esc</kbd>.
1. To find the responsible tab, extension, subframe, or utility process, sort by **CPU** or **Memory**.
1. Select the process, and then select **End process**.
1. Check whether the system load drops.

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

If Edge continues to use excessive CPU after you close all windows, background processes are still running.

1. Go to `edge://settings/system`.
1. Turn off **Continue running background extensions and apps when Microsoft Edge is closed**.

For enterprise management, see the [BackgroundModeEnabled](/deployedge/microsoft-edge-policies/backgroundmodeenabled) policy.

### Verify that hardware acceleration is on

Software rendering of video, WebGL, and canvas content increases CPU usage.

1. Go to `edge://gpu`.
1. Review **Graphics Feature Status**, and verify that hardware acceleration is in use.
1. If items show software-only rendering:
   1. Update your GPU driver.
   1. Make sure that **Use graphics acceleration when available** is turned on in `edge://settings/system`.

For enterprise management, see the [HardwareAccelerationModeEnabled](/deployedge/microsoft-edge-policies/hardwareaccelerationmodeenabled) policy.

### Reset Edge settings

1. Go to `edge://settings/reset`.
1. Select **Restore settings to their default values**.

> [!NOTE]
> When you restore the settings, bookmarks, history, and saved passwords are preserved. Pinned tabs, startup page, search engine, and extensions are reset.

## Data collection

If you have to contact Microsoft Support for more help, collect the following diagnostic information to include in your support request:

- **Microsoft Edge version**: Go to `edge://settings/help`, and note the full version number.
- **Browser Task Manager screenshots**: Press <kbd>Shift</kbd>+<kbd>Esc</kbd>, take one screenshot that's sorted by **CPU**, then take another that's sorted by **Memory**.
- **Discarded tabs report**: Go to `edge://discards`, and save the output.

## Related content

- [Microsoft Edge policy reference](/deployedge/microsoft-edge-policies)
- [Microsoft Edge known issues](/deployedge/microsoft-edge-known-issues)
