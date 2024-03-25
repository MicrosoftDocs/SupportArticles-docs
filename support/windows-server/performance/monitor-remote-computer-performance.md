---
title: Monitor performance of remote computers
description: Describes how to use Performance Monitor and the Datalog.exe file to monitor performance of remote computers.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:System Performance\Performance tools (Task Manager, Perfmon, WSRM, and WPA), csstroubleshoot
---
# Monitor performance of a remote computer without logging on to it

This article describes how to use Performance Monitor and the Datalog.exe file that is included with Microsoft Windows NT 4.0 Resource Kit to log data and generate alerts on a remote computer without having to log on to it.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 246758

## More information

To log data and generate alerts on a remote computer without having to log on to it, follow these steps:

> [!NOTE]
> In the following steps, replace \<remotecomputer> with the name of the computer that you want to monitor.

1. Install the Windows NT 4.0 Resource Kit on the remote computer.
2. At the local computer, use Windows NT Performance Monitor (Perfmon.exe) to create a workspace file:

    1. Start Performance Monitor, and then click **Log** on the
    **View** menu.
    2. Add the relevant counters, specifying all objects you want to log and the alerts you want to generate.
    3. On the **Options** menu, click **Log**.
    4. In the **File Name** box, specify a name for the log file using the .log extension.
    5. Click one of the logging interval options, and then click
    **Save** to save the logging options.
    6. On the **File** menu, click **Save Workspace**.
    7. In the **File Name** box, type a workspace file name using the .pmw extension, and then click **Save**.
    8. Quit Performance Monitor.

3. Copy both the workspace file you just created and the Datalog.exe file included with the Windows NT 4.0 Resource Kit to the %SystemRoot%\System32 folder on the remote computer.

4. At the local computer, set up the Data Logging service for the remote computer:

    1. At the command prompt, type the following command, and then press ENTER:

        ```console
        monitor \\remotecomputer setup
        ```

        This command registers the service with Windows NT Server 4.0. You need to run the command only once for each computer you want to monitor. If you receive the following error message:

        > Failed to create Service

        it means that you have already run the command once.
  
    2. To use the workspace file for logging, type the following command, and then press ENTER:

        ```console
        monitor \\remotecomputer filename
        ```

        where filename is the name of the workspace file you copied to the remote computer.

5. To start the monitoring process, type the following command, and then press ENTER:

    ```console
    monitor \\remotecomputer start
    ```

6. To stop the monitoring process, type the following command, and then press ENTER:

    ```console
    monitor \\remotecomputer stop
    ```

    After you stop the monitoring process, you can view the log file in Performance Monitor. For instructions about how to do this, see Help in Performance Monitor.

    Also, you can use the Schedule service and the AT command to schedule monitoring to occur at a set time. For example, if a server slows down noticeably between 2:40 A.M. and 2:50 A.M. every weeknight, you can log the data for that period without being physically present by typing the following AT commands:

    ```console
    at \\remotecomputer 2:30 /every:m,t,w,th,f monitor start
    at \\remotecomputer 3:00 /every:m,t,w,th,f monitor stop
    ```

    If you want to be reminded about the log, type the following command, and then press ENTER:

    ```console
    at \\remotecomputer 3:00 /every:f net send yourusername 'The Monitor is stopped. The log contains data for this week!'
    ```
