---
title: The Teams Rooms device's displays show a black or blank screen
description: Resolve the issue that causes one or more of the Teams Rooms device's displays show a black or blank screen, or the system doesn't respond.
ms.reviewer: joolive
ms.topic: troubleshooting
ms.date: 10/19/2022
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: CI167993
---
# Black or blank screen or no system response

Users may experience the following issues on a Microsoft Teams Rooms device:

- Some or all displays, including the Front of Room displays and the touchscreen console, show a black or blank screen.
- The touchscreen console displays content, but the system doesn't respond.

## A specific display shows a black or blank screen

This issue occurs if the display isn't detected by the Teams Rooms device. To fix the issue, follow the instructions in [The Display status is Unhealthy](./display-status-unhealthy.md).

## All displays and the touchscreen console show a black or blank screen and don't respond

To identify and fix the issue, try the following options in order. If one option doesn't work, move on to the next option.

### Check whether the device is offline or unmonitored

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), select the affected room device, then check the status of the **Offline** and **Monitored** signal under the **Connectivity** category.

If one or both signals show as **Unhealthy**, follow the instructions in [The Monitored or Offline status is Unhealthy](monitored-offline-status-unhealthy.md) to identify common causes and fix the issue.

If the device is monitored, go to the next option.

### Check whether the Teams Rooms app is running

Start an ad hoc meeting from another device that has Microsoft Teams installed and add the affected room to the meeting. Check whether the call rings on the speaker of the affected device:

- If it rings, it means that the Teams Rooms app is still running, but it's not visible in the existing viewport due to window or display positioning issues. In this case, try the following steps:

   1. Try to force a window repositioning, disconnect and reconnect the cable of one of the displays.

       **Note** Whenever a display is disconnected or connected, the image of the Teams logo will be shown on all existing displays while the Teams Rooms app is repositioning all windows in the background.
   1. If the issue persists, try to power cycle the device, see if the system recovers after a restart.
   1. If the issue repeats multiple times, [contact Microsoft Support](get-support-teams-rooms-pro-management.md).
- If it doesn't ring, check if the Teams Rooms app starts properly. For more information, see [The Meeting app status is Unhealthy](./meeting-app-status-unhealthy.md). If the issue persists, go to the next option.

### Check whether the core Windows components are functioning properly

Attach a USB keyboard to the device. Press the Windows key five times in quick succession, check if it takes you to the Windows logon screen.

- If it doesn't take you to the Windows logon screen, it means that some core Windows components aren't functioning.

   1. To check if it's a transient Windows failure, power cycle the device. See if the system recovers after a restart.
   1. If the issue repeats multiple times but only affects a specific device, there might be inconsistencies or corruption in the core Windows components and/or drivers in that device. In this case, consider re-imaging the compute module as described in the OEM documentation.
   1. If the issue persists after reimaging or is observed on multiple devices, [contact Microsoft Support](get-support-teams-rooms-pro-management.md).
- If it takes you to the Windows logon screen, the Skype sign-in session will become disconnected but remain signed in, all existing processes will continue to run. For further diagnosis, check whether the Teams Rooms app processes are running properly.

   1. Sign in to the device as the Admin user.
   1. Open Task Manager, select the **Details** tab.
   1. Check the **User name** column of the following processes:

      - Microsoft.SkypeRoomSystem.exe
      - DesktopAPIService.exe
      - Teams.exe (multiple)

      If the value is **Skype**, it means that the Teams Rooms app may be frozen in an unexpected state.
   1. Open Event Viewer, select **Windows Logs** > **Application**. Check for any **Critical** or **Error** events from the following sources in the last 24 hours that indicate that one of the processes listed in step 3 has crashed:

      - Application Error
      - Windows Error Reporting
   1. Regardless of whether the Teams Rooms app processes are still running but unresponsive, or have crashed, to assess whether it's a transient failure of the app or the app that interacts with Windows components, restart the device. See if the system recovers.
   1. If the issue repeats multiple times but only affects a specific device, there might be inconsistencies or corruption in the core Windows components and/or the Teams Rooms app. In this case, consider re-imaging the compute module as described in the OEM documentation.
   1. If the issue persists after reimaging or is observed on multiple devices, [contact Microsoft Support](get-support-teams-rooms-pro-management.md).

## The display shows the idle screen of the Teams Rooms app, but doesn't respond after waking up

This issue usually occurs during the first use of the day, after a nightly restart.

- If the current time shown on the display is frozen (showing the time when it becomes unresponsive), and a consumer TV is used as the display, the issue may be caused by one or more of the following reasons:

  - Inconsistent implementation of standby modes
  - Active video source selection
  - Incorrect EDID information that's communicated to the Teams Rooms device

  This behavior is expected when consumer TVs are used as the Front of Room display. For more information, see [Known issues in Teams Rooms](rooms-known-issues.md#expected-behavior).
- If the current time shown on the display isn't frozen, check if only the touchscreen input is affected.

  To verify, attach a USB keyboard to the Teams Rooms device, press the Tab key to navigate through the menu of the Teams Rooms app. If the app responds to keyboard input, it means that the app isn't frozen. To restore the functionality, consider power cycling the console, or restart the Teams Rooms device.

  If this touchscreen input issue occurs frequently on a specific console that's connected through USB and/or extenders, try reseating the USB connectors on the compute module and the console. Or, consider replacing the cable or the console to assess if the issue still occurs.

## The touchscreen console turns black or blank for several minutes

In this case, check the **System** event log for the following events that occurred shortly before the issue occurred:

- Event ID: 4
- Source: Microsoft-Windows-WindowsUpdateClient

Some console manufacturers provide firmware updates through Windows Update. When updates are deployed, the console will turn black or blank while the firmware is being updated, this process may take a few minutes to complete. After a successful firmware update, the functionality of the touchscreen console will automatically return to normal.

> [!IMPORTANT]
> Refer to the OEM documentation for more information about the firmware installation experience, including:
>
> - The maximum expected time to deploy a firmware update on the console.
> - Any other recommendations, such as not disconnecting the cable or powering off the device.

Some OEM touchscreen consoles include a factory reset button that can be operated through a pinhole. This button allows you to restore the device functionality in unexpected circumstances, such as a transient failure when installing firmware.
