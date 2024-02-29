---
title: Reliability Monitor shows no information
description: Describes a behavior that is by design in Windows Server 2008 and in Windows Server 2008 R2. This behavior causes no information to be displayed in Reliability Monitor.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, subheetr
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
---
# Reliability Monitor displays no information in Windows Server

This article provides a solution to an issue that Reliability Monitor displays no information when you open Reliability Monitor on a computer.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 983386

## Symptoms

When you open Reliability Monitor on a computer that is running Windows Server 2012 R2, Reliability Monitor displays no information.

> [!NOTE]
>
> - This behavior does not occur on a computer that is running Windows Vista or Windows 7.
> - Reliability Monitor displays a stability index and displays some specific event information.

## Cause

This behavior occurs because the trigger that regularly starts the RacTask task is disabled.

Information that Reliability Monitor displays is provided by the RacTask task. By default, the RacTask task runs one time that is about one hour after you install the operating system. In Windows Server 2012 R2, the trigger that regularly starts the RacTask task is disabled after the RacTask task runs for the first time.

## Resolution

To resolve this issue, follow these steps:

1. Click **Start**, type Task Scheduler in the **Search** box, and then click **Task Scheduler**.

2. Enable the trigger that regularly starts the RacTask task.
    1. In Task Scheduler, expand **Task Scheduler Library**, expand **Microsoft**, and then expand **Windows**.
    2. Right-click **RAC**, click **View**, and then click to select the **Show Hidden Tasks** command.

        > [!NOTE]
        > If the **Show Hidden Tasks** command is already selected, go to step 2c.
    3. Double-click **RacTask**.
    4. In the **RacTask Properties** dialog box, click the **Triggers** tab.
    5. On the **Triggers** tab, double-click the **One time** trigger.
    6. In the **Edit Trigger** dialog box, click to select the **Enabled** option, and then click **OK**.
    7. In the **RacTask Properties** dialog box, click **OK**.
    8. Close Task Scheduler.

3. Update a registry setting.
    1. Click **Start**, type Regedit in the **Search** box, and then click **Regedit**.
    2. In Registry Editor, set the value of the following registry entry to 1:
        `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Reliability Analysis\WMI\WMIEnable`

4. Restart the computer.

## Status

This behavior is by design.

## References

[Start Reliability Monitor](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc748864(v=ws.10))
