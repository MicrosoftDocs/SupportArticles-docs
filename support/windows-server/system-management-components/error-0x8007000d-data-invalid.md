---
title: Error message when you run an old scheduled task or a newly created scheduled task on a Windows Server 2003 Service Pack 2-based domain controller
description: Describes the problem in which you cannot run an old scheduled task or a newly created scheduled task on a Windows Server 2003 Service Pack 2-based domain controller. A resolution is provided.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-sanair
ms.custom: sap:task-scheduler, csstroubleshoot
---
# Error message when you run an old scheduled task or a newly created scheduled task on a domain controller: "0x8007000d: The data is invalid"

This article provides the resolution for the error message "0x8007000d: The data is invalid" when you run an old scheduled task or newly created scheduled task on a domain controller.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 958837

## Symptoms

You cannot run an old scheduled task on a domain controller after you install Windows Server 2003 Service Pack 2 (SP2) on the domain controller. Additionally, you cannot run a newly created scheduled task that you create by using the Scheduled Task Wizard. When you try to run an old scheduled task or a newly created scheduled task, you receive the following error message:

> General page initialization failed.  
The specific error is:  
0x8007000d: The data is invalid.  
An error has occurred attempting to retrieve task account information. You may continue editing the task object, but will be unable to change task account information.

> [!NOTE]
> However, you can run a scheduled task that you create by using Administrative Tools.

## Resolution

To resolve this issue, follow these steps:

1. Stop the **Task Scheduler** service on the domain controller. To do this, follow these steps:
   1. Click **Start**, click **Run**, type *services.msc*, and then press ENTER.
   2. In the list of services, double-click **Task Scheduler**.
   3. Click **Stop**, and then click **OK**.
   4. On the **File** menu, click **Exit**.
2. Change the attribute of the **Tasks** folder to make the folder a typical folder. To do this, follow these steps:
   1. Click **Start**, click **Run**, type *cmd*, and then press ENTER.
   2. At the command prompt, type `cd %windir%`, and then press ENTER.

      > [!NOTE]
      > %windir% specifies the path where Windows is installed. Typically, C:\\Windows is the path where Windows is installed.

   3. Type `attrib -s tasks`, and then press ENTER.
3. Switch to the **Tasks** folder. To do this, type `cd tasks`, and then press ENTER.
4. Back up the Sa.dat file. To do this, type `copy sa.dat <backup_path>`, and then press ENTER.

    > [!NOTE]
    > The backup_path placeholder specifies the path of the location where you want to copy the Sa.dat file.
5. Delete the Sa.dat file. To do this, type `del sa.dat`, and then press ENTER.
6. Change the attribute of the **Tasks** folder to revert the folder back to a system folder. To do this, follow these steps:
    1. At the command prompt, type `cd %windir%`, and then press ENTER.
    2. Type `attrib +s tasks`, and then press ENTER.
7. Type `exit`, and then press ENTER to close the **Command Prompt** window.
8. Start the **Task Scheduler** service on the domain controller. To do this, follow these steps:
    1. Click **Start**, click **Run**, type *services.msc*, and then press ENTER.
    2. In the list of services, double-click **Task Scheduler**.
    3. Click **Start**, and then click **OK**.
    4. On the **File** menu, click **Exit**.
