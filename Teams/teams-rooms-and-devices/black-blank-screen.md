---
title: The Teams Rooms device's displays show a black or blank screen
description: Resolve the issue that causes one or more of the Teams Rooms device displays to show a black or blank screen, or the system doesn't respond.
ms.reviewer: joolive
ms.topic: troubleshooting
ms.date: 10/31/2023
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
# Black or blank screen or no system response in Teams Rooms

On a Microsoft Teams Rooms device, users experience one or more of the following issues:

- Some or all displays (including the Front of Room displays and the touchscreen console) show a black or blank screen.
- The touchscreen console displays content, but the system doesn't respond.

## A specific display shows a black or blank screen

This issue occurs if the display isn't detected by the Teams Rooms device. To fix the issue, follow the instructions in [The Display status is Unhealthy](display-status-unhealthy.md).

## All displays and the touchscreen console show a black or blank screen and don't respond

To identify and fix the issue, try the following methods in the given order. If one method doesn't work, try the next method.

### Check whether the device is offline or unmonitored

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), select the affected room device, then check the status of the **Offline** and **Monitored** signal in the **Connectivity** category.

If one or both signals appear as **Unhealthy**, follow the instructions in [The Monitored or Offline status is Unhealthy](monitored-offline-status-unhealthy.md) to identify common causes and fix the issue.

If the device is monitored, go to the next method.

### Check whether the Teams Rooms app is running

Start an ad hoc meeting from another device that has Microsoft Teams installed, and then add the affected room to the meeting. Check whether the call rings on the speaker of the affected device:

- If the call rings, this means that the Teams Rooms app is still running, but it's not visible in the existing viewport because of a window or display positioning issues. In this case, follow these steps:

   1. Try to force a window repositioning by disconnecting and reconnecting the cable of one of the displays.

       **Note** Whenever a display is disconnected or connected, the image of the Teams logo will be shown on all existing displays while the Teams Rooms app is repositioning all windows in the background.
   1. If the issue persists, try to power cycle the device, see if the system recovers after a restart.
   1. If the issue repeats multiple times, [contact Microsoft Support](get-support-teams-rooms-pro-management.md).
- If the call doesn't ring, check whether the Teams Rooms app starts correctly. For more information, see [The Meeting app status is Unhealthy](meeting-app-status-unhealthy.md). If the issue persists, go to the next method.

### Check whether the core Windows components are functioning correctly

Attach a USB keyboard to the device. Press the Windows logo key five times in quick succession to see whether this opens the Windows logon screen.

- If the Windows logon screen doesn't open, it means that some core Windows components aren't functioning.

   1. To check whether this is a transient Windows failure, power cycle the device. See if the system recovers after a restart.
   1. If the issue repeats multiple times but affects only a specific device, there might be inconsistencies or corruption in the core Windows components or drivers on that device. In this case, consider reimaging the compute module, as described in the OEM documentation.
   1. If the issue persists after reimaging, or if it's observed on multiple devices, [contact Microsoft Support](get-support-teams-rooms-pro-management.md).
- If the Windows logon screen does open, the Skype sign-in session will become disconnected but remain signed in, and all existing processes will continue to run. For further diagnosis, check whether the Teams Rooms app processes are running correctly:

   1. Sign in to the device as the Admin user.
   1. Open Task Manager, and then select the **Details** tab.
   1. Check the **User name** column of the following processes:

      - Microsoft.SkypeRoomSystem.exe
      - DesktopAPIService.exe
      - Teams.exe (multiple)

      If the value is **Skype**, it means that the Teams Rooms app might be frozen in an unexpected state.
   1. Open Event Viewer, and select **Windows Logs** > **Application**. Check for any **Critical** or **Error** events from the following sources in the last 24 hours that indicate that one of the processes that's listed in step 3 stopped responding:

      - Application Error
      - Windows Error Reporting
   1. Regardless of whether the Teams Rooms app processes are still running but unresponsive, or have crashed, restart the device to determine whether this is a transient failure of the app or of the app that interacts with Windows components. Check whether the system recovers.
   1. If the issue repeats multiple times but affects only a specific device, there might be inconsistencies or corruption in the core Windows components or the Teams Rooms app. In this case, consider reimaging the compute module, as described in the OEM documentation.
   1. If the issue persists after reimaging or is observed on multiple devices, [contact Microsoft Support](get-support-teams-rooms-pro-management.md).

## The display shows the idle screen of the Teams Rooms app, but doesn't respond after waking up

This issue usually occurs during the first use of the day after a nightly restart.

- If the current time shown on the display is frozen (showing the time when it becomes unresponsive), and a consumer TV is used as the display, the issue might be caused by one or more of the following reasons:

  - Inconsistent implementation of standby modes
  - Active video source selection
  - Incorrect EDID information that's communicated to the Teams Rooms device

  This behavior is expected if a consumer TV is used as the Front of Room display. For more information, see [Known issues in Teams Rooms](rooms-known-issues.md#expected-behavior).
- If the current time that's shown on the display isn't frozen, check whether only the touchscreen input is affected.

  To verify this situation, attach a USB keyboard to the Teams Rooms device, and then press the Tab key to navigate through the menu of the Teams Rooms app. If the app responds to keyboard input, it means that the app isn't frozen. To restore the functionality, consider power cycling the console, or restart the Teams Rooms device.

  If this touchscreen input issue occurs frequently on a specific console that's connected through a USB port or extenders, try reseating the USB connectors on the compute module and the console. Or, consider replacing the cable or the console to determine whether the issue still occurs.

## The touchscreen console turns black or blank for several minutes

In this situation, check the **System** event log for the following events that occurred shortly before the issue occurred:

- Event ID: 4
- Source: Microsoft-Windows-WindowsUpdateClient

Some console manufacturers provide firmware updates through Windows Update. When updates are deployed, the console turns black or blank while the firmware is being updated. This process might take several minutes to finish. After a successful firmware update, the functionality of the touchscreen console automatically returns to normal.

> [!IMPORTANT]
> Refer to the OEM documentation for more information about the firmware installation experience, such as the following information:
>
> - The maximum expected time to deploy a firmware update on the console
> - Any other recommendations, such as not disconnecting the cable or powering off the device

Some OEM touchscreen consoles include a factory reset button that can be operated through a pinhole. This button lets you restore the device functionality in unexpected circumstances, such as a transient failure that occurs when you install firmware.
