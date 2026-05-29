---
title: Fix Microsoft Edge stops responding or doesn't start
description: Troubleshoot Microsoft Edge if it doesn't start, shows a blank window, or stops responding shortly after startup. The solution includes profiles, graphics acceleration, and repair.
ms.date: 05/29/2026
ms.reviewer: Johnny.Xu, dili, v-shaywood
ms.custom: sap:Stability and Performance\Browser Crash
---

# Microsoft Edge stops responding or doesn't start

## Summary

This article helps you troubleshoot Microsoft Edge if it doesn't start, shows a blank window, or stops responding (crashes) shortly after it starts. The article describes common causes, such as leftover background processes, graphics driver problems, a corrupted user profile, and a broken installation. It also lists the data to collect before you contact Microsoft Support.

## Symptoms

You experience one or more of the following symptoms:

- After you try to start Edge, the `msedge.exe` process appears in Task Manager, but no window opens.
- A blank Edge window appears briefly and then closes.
- Edge becomes unresponsive immediately after the new tab page loads.
- An **Application Error** event for `msedge.exe` is logged in Event Viewer.

## Solution

Work through the following sections in the given order. After each section, restart Edge, and check whether the problem is fixed before you continue.

### End all existing Edge processes

Background processes that remain from a previous session can prevent a clean start. Follow these steps:

1. Press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Esc</kbd> to open Task Manager.
1. End every `msedge.exe` task.
1. Restart Edge.

### Turn off graphics acceleration

Graphics driver problems can cause a blank window. To rule out this problem, turn off graphics acceleration:

1. If Edge opens long enough to let you access **Settings**, go to `edge://settings/system`, and turn off **Use graphics acceleration when available**. If your organization manages this setting, see [HardwareAccelerationModeEnabled](/deployedge/microsoft-edge-policies/hardwareaccelerationmodeenabled).
1. Restart Edge.
1. If this change fixes the problem, update your GPU driver, and then turn graphics acceleration back on.

### Start by using a temporary profile

A corrupted profile or extension can cause Edge to fail before the program window appears. To isolate the problem, start Edge by using a temporary user data folder.

Open a Command Prompt window, and then run the following command:

```cmd
"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --user-data-dir="%TEMP%\edge-test-profile"
```

If Edge starts cleanly by using the test profile, the original profile is the cause of the problem. Continue to [Create a new profile](#create-a-new-profile). Otherwise, move on to [Repair Microsoft Edge](#repair-microsoft-edge).

> [!NOTE]
> For profile sign-in problems, see [Troubleshoot common sign-in problems](../security/troubleshoot-sign-in-issues.md).

#### Create a new profile

Follow these steps:

1. Close all Edge windows.
1. Go to *%LOCALAPPDATA%\Microsoft\Edge\User Data*.
1. Rename the *Default* folder to *Default.old*.
1. Start Edge to create a fresh *Default* profile.
1. If Edge is stable, close it, and then copy any data that you want to keep (such as *Bookmarks*) from *Default.old* to the new *Default* profile.

### Repair Microsoft Edge

Follow these steps:

1. Open **Settings** > **Apps** > **Installed apps**.
1. Select **Microsoft Edge** > **Modify** > **Repair**.

For installation, update, or rollback errors, see [Install, update, or roll back failures for Edge and Edge WebView2](../manageability/update-install-rollback-failures.md).

## Data collection

If you have to contact Microsoft Support for more help, collect the following diagnostic information to include with your support request:

- **Microsoft Edge version**: Go to `edge://version`, and note the full version number.
- **Application Error events**: In Event Viewer, go to **Windows Logs** > **Application**, filter to source **Application Error** together with the faulting module, `msedge.exe`, and export the matching entries.
- **Crash ID**: Go to `edge://crashes`, and note the most recent crash ID.

## Related content

- [Troubleshoot video playback problems in Microsoft Edge](../development/video-playback-issues.md)
- [Microsoft Edge policy reference](/deployedge/microsoft-edge-policies)
