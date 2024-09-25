---
title: Computer hangs in an OSD task sequence debug mode
description: Fixes an issue in which a computer appears to hang during an OSD task sequence running in debug mode.
ms.date: 12/05/2023
ms.custom: sap:Operating Systems Deployment (OSD)\Task Sequence Step for Other Operations
ms.reviewer: kaushika
---
# Computer hangs at the Just a moment screen in a debug deployment of an OSD task sequence

This article fixes an issue in which a computer appears to hang during an OSD task sequence running in debug mode.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4517137

## Symptoms

You run a debug deployment of an Operating System Deployment (OSD) task sequence that deploys Windows 10 in Configuration Manager. After the task sequence restarts out of WinPE and into the full OS, the device hangs for a long time at the **Just a moment** screen during Windows Setup.

## Cause

This issue typically occurs if the **Step** option of the task sequence debugger is used from the **Setup Windows and ConfigMgr** task or if a break point is set after the **Setup Windows and ConfigMgr** task.

After Windows Setup is completed, the OSD task sequence is restarted by using the SetupComplete.cmd script. Current versions of Windows 10 hide programs and do not interactively display them when they are started through the SetupComplete.cmd script. This behavior causes anything that the task sequence tries to display to be hidden instead. This includes the task sequence debugger and any task sequence progress bars.

In this situation, the task sequence does continue, and the debugger does start. However, the debugger is hidden and cannot be seen. Only the **Just a moment** screen is visible. This makes it appear as though Windows Setup is still running.

After the first restart after SetupComplete.cmd initially runs, programs are shown interactively and are no longer hidden. At this point, the task sequence debugger and progress bars are visibly displayed.

## Resolution

To resolve the issue, follow these steps:

1. Add a **Restart Computer** task immediately after the **Setup Windows and ConfigMgr** task. Make sure that the **Restart Computer** task is set to the **The currently installed default operating system** option.

2. Set any necessary break points by following these guidelines:

   - Do not set a break point on the **Restart Computer** task that you added in step 1. Instead, set break points after the **Restart Computer** task, as appropriate.
   - Do not use the **Step** option in the task sequence debugger at the **Setup Windows and ConfigMgr** task. Instead, set a break point to the task after the **Restart Computer** task, and then select the **Run** option when you're ready to continue.

## References

For more information about the task sequence debugger, see [Debug a task sequence](/mem/configmgr/osd/deploy-use/debug-task-sequence).
For more information about the SetupComplete.cmd script file, see [Add a Custom Script to Windows Setup](/windows-hardware/manufacture/desktop/add-a-custom-script-to-windows-setup).
