---
title: User-defined data collector set doesn't run as scheduled
description: This article provides a workaround for an issue in which a user-defined data collector set that is configured to run on a schedule does not run.
ms.date: 11/30/2020
author: Teresa-Motiv
ms.author: v-tea
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Kerberos authentication
ms.technology: Identity
---

# User-defined data collector set doesn't run as scheduled

This article provides a workaround for an issue in which a user-defined data collector set that is configured to run on a schedule does not run.

_Original product version:_ &nbsp; Windows Server 2019 - all editions, Windows 10 version 1909 - all editions, Windows 10 version 1903 - all editions, Windows 10 version 1809 - all editions, Windows 10 version 1803 - all editions, Windows 10 version 1709 - all editions, Windows 10 version 1703 - all editions

## Symptoms

Using one of the affected versions of Windows, you create a data collector set in the **Performance** > **Data Collector Sets** > **User Defined** folder in Computer Management. You configure a schedule as part of the data collector set definition.

However, at the scheduled time, Performance Monitor does not start collecting data. If you configured the data collector set to save data to a file, the file is not created and no data is saved. In Task Scheduler, the task history indicates that the task ran successfully. However, the task did not actually do anything.

In Task Scheduler, if you open the scheduled task and then select **Actions**, the actions list contains **Custom Handler**.

:::image type="content" source="./media/user-defined-dcs-doesnt-run-as-scheduled/scheduled-task-action.png" alt-text="The action of the scheduled task is not configured correctly.":::

The expected action, **Start a program**, which includes the specific commands and arguments, is missing.

> [!NOTE]  
> In the Task Scheduler Library, tasks for data collector sets appear by default in **Microsoft** > **Windows** > **PLA**.

## Cause

Starting in version 1703, the way that scheduled tasks are automatically created for data collector sets changed. As a result of the change, the actions for these tasks are not created correctly.

## Resolution

This issue is fixed in Windows 10, version 2004, and newer versions.

## Workaround

You can manually fix the scheduled task that is associated with a data collector set. To do this, follow these steps:

1. In Task Scheduler, do one of the following to open the Properties of the affected task:  
  
   - If the task appears in the Task Scheduler **Active tasks** list, double-click the task. Then right-click the task an select **Properties**.
   - Go to **Task Scheduler Library** > **Microsoft** > **Windows** > **PLA**, right-click the task, and then select **Properties**.
  
2. Select **Actions**, select **Custom Handler**, and then select **Delete**.
3. Select **New**.
4. In **Program/script**, type the following string:
  
   ```cmd
   C:\windows\system32\rundll32.exe
   ```
  
5. In **Add arguments**, type the following string:
  
   ```cmd
   C:\windows\system32\pla.dll,PlaHost "{Name}" "$(Arg0)"
   ```
  
   > [!NOTE]  
   > In this string, {*Name*} represents the name of the data collector set.
  
6. Select **OK**.
