---
title: Desktop wakes up unexpectedly from sleep or hibernation
description: Document findings based on OEM support case, where customer observed unexpected wake behavior. Provide information on how to track down the source of wake events, and related information.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, steved
ms.custom: sap:power-management, csstroubleshoot
ms.technology: windows-client-deployment
---
# Desktop wakes up unexpectedly from sleep or hibernation

This article provides a solution to an issue where desktop wakes up unexpectedly from sleep or hibernation.

_Applies to:_ &nbsp; Windows 8  
_Original KB number:_ &nbsp; 2799178

## Symptoms

A Windows 8 Desktop computer is automatically waking from sleep or hibernation at a certain time even if there's no "ACPI Wake Alarm" system device found by the operating system.

## Cause

For Windows 8 desktops or All-in-one computers, under **Action Center** > **Automatic Maintenance**, the **Allow scheduled maintenance to wake up my computer at the scheduled time** checkbox is automatically enabled. Also, the power policy/Advanced settings/Sleep/Allow wake timers will default to Enabled for AC power.

If the desktop machine doesn't have an "ACPI Wake Alarm" device (or if it's disabled in the BIOS), Windows 8 still uses the Real Time Clock (RTC) to program wake events, assuming the power policy/Advanced settings/Sleep/Allow wake timers is Enabled for AC power.

Windows 8 automatically configures a "Regular Maintenance" event in TaskScheduler to run at 3:00 AM every day. After initial installation of Window 8, Windows Update is preconfigured to initiate the regular maintenance task and wake event to ensure that it is run.

>[!NOTE]
 On mobile computers, if there is no "ACPI Wake Alarm" device detected, Windows 8 disables "allow wake timers" on all in-box power plans, and **Allow scheduled maintenance to wake up my computer at the scheduled time** is not enabled.

## Resolution

To prevent the Regular Maintenance task from waking the machine at 3:00am, go to **Action Center** > **Automatic Maintenance** and disable the **Allow scheduled maintenance to wake up my computer at the scheduled time** checkbox.

## More information

When an application schedules a maintenance trigger (such as Windows Update, if it has downloaded a qualified update to be installed under maintenance), the following actions will take place:

1. From an Administrator command prompt, `Powercfg /waketimers` indicates that the Regular Maintenance task is scheduled to run at 3:00 AM. For example:

    ```console
    C:\\> powercfg /waketimers
    ```

    Timer set by [PROCESS] \\Device\\HarddiskVolume1\\Windows\\System32\\services.exe expires at 2:59:29 AM on 12/4/2012
    Reason: Windows will execute 'NT TASK\\Microsoft\\Windows\\TaskScheduler\\Regular Maintenance' scheduled task that requested waking the computer.

2. Event ID: 808 will be logged in the Application and Services Logs/Microsoft/Windows/TaskScheduler/Maintenance log, to indicate the application, which caused the regular maintenance event to be scheduled. For example:

    > Level: Warning  
    Source: TaskScheduler  
    Event ID: 808  
    Maintenance Task "\\Microsoft\\Windows\\WindowsUpdate\\AUScheduledInstall" requests computer wakeup during next regular maintenance run.

Any application can schedule a regular maintenance task to run automatically, as described by the following links.

- [Being productive in the background – background tasks](/archive/blogs/windowsappdev/being-productive-in-the-background-background-tasks)

- [MaintenanceTrigger Class](/uwp/api/Windows.ApplicationModel.Background.MaintenanceTrigger)  

The first application to make use of the Regular Maintenance task scheduling feature is Windows Update. The .NET Framework NGEN v4.0 utility has also been observed to cause the regular maintenance event to be scheduled.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
