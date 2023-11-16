---
title: Schedule a server process in
description: This article describes how to schedule a server process, provides a step-by-step resolution.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, markstan
ms.custom: sap:task-scheduler, csstroubleshoot
ms.technology: windows-server-system-management-components
---
# How to schedule a server process

This article describes how to schedule a server process in Windows Server 2003.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 324283

## Summary

This step-by-step article describes how to schedule a program to start automatically after a pre-determined interval.

### Schedule the Task

1. Click **Start**, point to **Control Panel**, then point to **Scheduled Tasks**, and then click **Add Scheduled Task**.  
    The **Scheduled Task Wizard** appears. Click **Next**.  
2. A list of programs that are available on your computer is displayed. If the program that you want to schedule is in this list, click it, and then click **Next**. If the program you want to run is not in this list, click **Browse** to locate the program, click the program, and then click **Open**.
3. Type a name for the task, and then click the interval that you want to use for this task (for example, daily, weekly, monthly, or one time only). Click **Next**.
4. If you choose to schedule the task daily, weekly, monthly, or one time only, you receive a time or date option. Select the date (or dates) and the time (or times) that you want to schedule the task for, and then click **Next**.
5. Type the user name and password that will be used to run this program. Make sure that the user name is in the *domain* \ *user* format where *domain* is your NetBIOS domain name and *user* is the user account that you want to schedule the task under. Click **Next**.
6. Click **Finish** to schedule the task.

### Troubleshooting

- By default, Task Scheduler logs on as the Local System account. In some cases, this account may not have the appropriate permissions to perform the scheduled task. Because of this reason, you must specify an account in the Scheduled Task Wizard. Verify that the account that you specify in the wizard has the appropriate permissions to perform the task that you are scheduling. To do it, log on as that user, and then run the task manually.
- You can also schedule tasks by using the `AT command`. Both methods can be used to automatically schedule tasks. However, neither program is aware of the list of the other's list of scheduled programs. For example, if you schedule a batch file to run every day at midnight in the Scheduled Task Wizard and also with the `AT command`, the command is executed two times.
- If you chose to schedule the task for any interval other than "one time only", the task continues to run indefinitely. Manually delete the task to prevent it from running again.
- The Schedule Task Wizard does not verify the password that you type for the user account that the process will run under. Make sure that you type the correct password.
