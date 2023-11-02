---
title: Guidance for troubleshooting high CPU usage
description: Introduces general guidance for troubleshooting scenarios in which you experience high CPU usage.
ms.date: 12/08/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:slow-performance, csstroubleshoot
ms.technology: windows-server-performance
---
# High CPU usage troubleshooting guidance

This article helps you identify the cause of sustained high CPU usage. Keep in mind that you can expect CPU usage to increase as a process or an application serves requests. However, if you consistently see CPU usage remain at a high level (80 percent or greater) for prolonged periods, the performance of your system or application will suffer. For that reason, it's important to understand the cause of sustained high CPU usage to be able to correct the problem, if possible.

## Troubleshooting tools

### Task Manager

Use Task Manager to view CPU consumption to help identify the process or application that's causing high CPU usage:

1. Select **Start**, enter *task*, and then select **Task Manager** in the search results.
2. The **Task Manager** window defaults to the **Processes** tab. If you see a single list of process names in the **Name** column, you can expand any instances of grouped processes.
3. Select the **CPU** column header to sort the list by CPU usage. Make sure that the arrow that appears on the header points down to sort the data from highest to lowest CPU consumption.

If the process can be stopped, or a related service can be disabled, stop the process or the service. Then, check whether this mitigates the problem. 

### Resource Monitor

Use the Resource Monitor to view CPU consumption:

1. Select **Start**, enter *resmon*, and then select **Resource Monitor** from the search results.
2. In the **Resource Monitor** window, select the **CPU** tab.

   > [!NOTE]
   > You might have to maximize the window to see all the data.

3. Select the **Average CPU** column header to sort the list by overall CPU usage. Make sure that the arrow that appears on the header points down to sort the data from highest to lowest CPU consumption.

If any of the processes show a higher-than-expected rate of consumption for your environment, consider these top processes first when you try to determine the cause of the problem.

### Process Explorer

The [Process Explorer](/sysinternals/downloads/process-explorer) tool gives you a complete overview on which processes are currently running on your computer, including details about who invoked the processes, and how much of the total system resources they're consuming.

If you want to verify an operating system-related process (for example, System), follow these steps:

1. Run Process Explorer as an administrator.
2. Right-click the process, select **Properties**, and then select the **Threads** tab.
3. Select the thread that consumes high CPU, and then select **Stack** to view the functions that are being run.

> [!NOTE]
> To get a better stack information result, configure symbols in the Process Explorer. To do this, follow these steps:
>
> 1. Install [Debugging Tools for Windows](/windows-hardware/drivers/debugger/debugger-download-tools).
> 2. Run Process Explorer as an administrator.
> 3. Select the **Options** menu, and then select **Configure Symbols**.
> 4. Change the Dbghelp.dll path to *C:\\Program Files (x86)\\Windows Kits\\10\\Debuggers\\x64\\dbghelp.dll*, and then select **OK**.

## Common troubleshooting scenarios

This section introduces the scenarios of different processes that use high CPU usage.

### Uniquely named singular Microsoft process

1. Collect a performance monitor log. Use a 1-second to 5-second snapshot interval.
2. Collect a [Windows Performance Recorder (WPR)](/windows-hardware/test/wpt/windows-performance-recorder) log while high CPU usage is occurring.
   > [!NOTE]
   > Don't let this log run for a long time because the file grows very quickly. You should have to run the log only for a few minutes (three to five) to capture the high CPU usage.
3. Run the [ProcDump](/sysinternals/downloads/procdump) tool two times during reported high CPU usage. Space apart the runs by several minutes.

### Svchost process

If a svchost process consumes high CPU usage, and the svchost process contains more than one service, you need to break each service out to run in its own svchost process to determine which service is causing the high CPU usage. To do so, follow these steps:

1. Open an elevated Command Prompt window.
2. Break out each service into its own svchost process if it's a shared svchost process. To do this, run the following command:

   ```console
   sc config <service name> type= own
   ```

   > [!NOTE]
   > In this command, replace \<*service name*\> with the actual service name.

3. Restart the service
4. At the command prompt, run `tasklist /svc` to verify that the service is running in its own svchost process. 

   > [!Important]
   > After the problem is resolved, you must return to step 2 and revert what you did.
   >
   > To do this, replace `sc config <service name> type= own` with `sc config <service name> type= share` in the command. Then, restart the service.

5. After you break each service out into its own svchost process, you now have to identify which service was driving up CPU usage or consuming high CPU usage.
6. Collect a performance monitor log. Use a 1-second to 5-second snapshot interval.
7. Record the PID of the offending Svchost process.
8. Collect a WPR log while the problem is occurring.
9. Run ProcDump two times during reported high CPU usage. Space apart the runs by several minutes.

### Multiple process instances that have the same name

Several instances of a process could share the same name. For example, this problem could occur with the explorer.exe processes on a Remote Desktop Protocol (RDP) server.

To troubleshoot this problem, follow these steps:

1. Collect a performance monitor log. Use a 1-second to 5-second snapshot interval.
2. Collect a WPR log while the problem is occurring.
3. Run ProcDump two times during reported high CPU usage. Space apart the runs by several minutes.
4. Record the PID of the offending process by running the following command:

   `tasklist /v /fo csv >Running_Process.txt`

### Third-party application process

If a third-process is identified as the cause of the problem, you must contact the application vendor to understand why the respective process is causing high CPU usage on the computer.

## Data collection

### Before the problem occurs

You can use Debug Diagnostic 2.0 version to further troubleshoot this problem. To use the tool, follow these steps.

1. Install the [Debug Diagnostic Tool v2 Update 2](https://www.microsoft.com/download/details.aspx?id=49924).

   > [!IMPORTANT]
   > Uninstall all other versions of Debug Diagnostic tool before you install the 2.0 version.

2. Select **Start**, enter *performance monitor*, and then right-click **Performance Monitor** to run it as an administrator.
3. Use Performance Monitor to collect the performance counter log and start the logging.

### When the problem occurs

1. Open the **DebugDiag 2 Collection**.
2. Select the **Processes** tab, right-click the worker process that corresponds to the appropriate application pool, and then select **Create Full Userdump**.
3. Repeat step 2 three times while the CPU usage is high.
4. Stop the Performance Monitor logging.
5. Compress the data by using DebugDiag. To do this, Select **Tools** > **Create Increment Cabinet File**.

We recommend that you keep the information that you've gathered handy in case you have to contact Microsoft Support.
