---
title: Use the at command to schedule tasks
description: Describes how to use the at command to create and to cancel scheduled tasks.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:task-scheduler, csstroubleshoot
---
# Use the at command to schedule tasks

 This article describes how to use the at command to create and to cancel scheduled tasks.

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 313565

> [!NOTE]
> This article applies to Windows 2000. Support for Windows 2000 ends on July 13, 2010. For more information, see the [Microsoft Support Lifecycle Policy](/lifecycle/).

## Summary

In Windows 2000, you can use the Task Scheduler tool in Control Panel to schedule tasks. You can also use the at command to schedule tasks manually.

## Overview of the at command

You can use the at command to schedule a command, a script, or a program to run at a specified date and time. You can also use this command to view existing scheduled tasks.

To use the at command, the Task Scheduler service must be running, and you must be logged on as a member of the local Administrators group. When you use the at command to create tasks, you must configure the tasks so that they run in the same user account.

The at command uses the following syntax:

- `at \\computername time/interactive | /every: date, ... /next: date, ... command`  

- `at \\computername id/delete | /delete /yes`

The following list describes the parameters that you can use with the at command:

- **\\computername**: Use this parameter to specify a remote computer. If you omit this parameter, tasks are scheduled to run on the local computer.

- **time**: Use this parameter to specify the time when the task is to run. Time is specified as **hours**: **minutes** based on the 24-hour clock. For example, 0:00 represents midnight and 20:30 represents 8:30 P.M.

- **/interactive**: Use this parameter to allow the task to interact with the desktop of the user who is logged on at the time the task runs.

- /every: **date**,... : Use this parameter to schedule the task to run on the specified day or days of the week or month, for example, every Friday or the eighth day of every month. Specify **date** as one or more days of the week (use the following abbreviations: M,T,W,Th,F,S,Su) or one or more days of the month (use the numbers 1 through 31). Make sure that you use commas to separate multiple date entries. If you omit this parameter, the task is scheduled to run on the current day.

- /next: **date**, ...: Use this parameter to schedule the task to run on the next occurrence of the day (for example, next Monday). Specify **date** as one or more days of the week (use the following abbreviations: M,T,W,Th,F,S,Su) or one or more days of the month (use the numbers 1 through 31). Make sure that you use commas to separate multiple date entries. If you omit this parameter, the task is scheduled to run on the current day.

- **command**: Use this parameter to specify the Windows 2000 command, the program (.exe or .com file), or the batch program (.bat or .cmd file) that you want to run. If the command requires a path as an argument, use the absolute path name (the entire path beginning with the drive letter). If the command is on a remote computer, use the Uniform Naming Convention (UNC) path name (\\**ServerName**\ **ShareName**). If the command is not an executable (.exe) file, you must precede the command with `cmd /c`, for example, `cmd /c copy C:\*.* C:\temp`.

- **id**: Use this parameter to specify the identification number that is assigned to a scheduled task.

- /delete: Use this parameter to cancel a scheduled task. If you omit the id parameter, all scheduled tasks on the computer are canceled.

- /yes: Use this parameter to force a yes answer to all queries from the system when you cancel scheduled tasks. If you omit this parameter, you are prompted to confirm the cancellation of a task.

> [!NOTE]
> When you use the at command, the scheduled task is run by using the credentials of the system account.

## Create a scheduled task

1. Click **Start**, point to **Programs**, point to **Accessories**, and then click **Command Prompt**.
2. At the command prompt, type the `net start` command, and then press ENTER to display a list of currently running services:

    If Task Scheduler is not displayed in the list, type the following line, and then press ENTER:

    ```console
    net start "task scheduler"
    ```

3. At the command prompt, type the following line (use the parameters that are appropriate to your situation), and then press ENTER:

    ```console
    at \\computername time/interactive | /every: date, ... /next: date, ... command  
    ```

### Examples

- To copy all files from the Documents folder to the MyDocs folder at midnight, type the following line, and then press ENTER:

    ```console
    at 00:00 cmd /c copy C:\Documents\*.* C:\MyDocs
    ```

- To back up the Products server at 11:00 P.M. each weekday, create a batch file that contains the backup commands (for example, Backup.bat), type the following line, and then press ENTER to schedule the backup:

    ```console
    at \\products 23:00 /every:M,T,W,Th,F backup
    ```

- To schedule a net share command to run on the Sales server at 6:00 A.M. and to redirect the listing to the Sales.txt file in the shared Reports folder on the Corp server, type the following line, and then press ENTER:

    ```console
    at \\sales 06:00 cmd /c "net share reports=d:\Documents\reports >> \\corp\reports\sales.txt"
    ```

## Cancel a scheduled task

1. Click **Start**, point to **Programs**, point to **Accessories**, and then click **Command Prompt**.
2. At the command prompt, type the `net start` command, and then press ENTER to display a list of currently running services.

    If Task Scheduler is not displayed in the list, type the following line, and then press ENTER:

    ```console
    net start "task scheduler"
    ```

3. At the command prompt, type the following line (use the parameters that are appropriate to your situation), and then press ENTER:

    ```console
    at \\computername id /delete | /delete /yes
    ```

### Examples to cancel scheduled tasks

- To cancel all tasks that are scheduled on the local computer, type `at /delete`, and then press ENTER.
- To cancel the task ID 8 on a computer that is named *MyServer*, type `at \\MyServer 8 /delete`, and then press ENTER.

## View scheduled tasks

To view the tasks that you created by using the at command, follow these steps:

1. Click **Start**, point to **Programs**, point to **Accessories**, and then click **Command Prompt**.
2. At the command prompt, type the `net start` command, and then press ENTER to display a list of currently running services.

    If Task Scheduler is not displayed in the list, type the following line, and then press ENTER:

    ```console
    net start "task scheduler"
    ```

3. At the command prompt, do one of the following steps:

    - To view a list of tasks that you scheduled by using the at command, type the `at \\computername` line, and then press ENTER.
    - To view a specific scheduled task, type the `at \\computername id` command, and then press ENTER.

### Examples to view scheduled tasks

- To view all scheduled tasks on the local computer, type `at`, and then press ENTER.
- To view all scheduled tasks on a computer named *Support*, type `at \\support`, and then press ENTER.
- To view the task ID 18 on the local computer, type `at 18`, and then press ENTER.

## Troubleshooting

- When you type `at \\computername` to view a list of scheduled tasks, some (or all) of the scheduled tasks that you created by using the at command are not listed.

    This behavior can occur if you modified the tasks in the Scheduled Tasks folder after you used the at command to create the task. When you use the at command to schedule a task, the task is displayed in the Scheduled Tasks folder in Control Panel. You can view or modify the task. However, if you modify the task, when you use the at command, you cannot view the task.

- When you use the at command to schedule a task, the task does not run at the specified time or date.

    This behavior can occur if one of the following conditions is true:

  - The command syntax is incorrect.

    After you schedule a task, type `at \\computername` to confirm that the syntax is correct. If the information that is displayed under Command Line is incorrect, cancel the task, and then recreate it.
  - You schedule a task to run a command that is not a .exe file.

The at command does not automatically load cmd (the command interpreter) before it runs commands. Unless you are running a .exe file, you must load Cmd.exe at the beginning of the command, for example, `at cmd /c dir > c:\test.txt`.

## References

For more information about how to use the at command in Windows 2000, see Windows 2000 Help. To do so, click **Start**, click **Help**, click the **Index** tab, and then type at command.
