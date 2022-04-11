---
title: Guidance of troubleshooting High CPU issues
description: Introduces general guidance of troubleshooting scenarios when you experience high CPU usage issues.
ms.date: 4/15/2022
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

This article helps you identify the cause of sustained high CPU. It's important to keep in mind that it is normal for CPU usage to increase as a process or an application serves requests. However, if you consistently see CPU remain at a high level (in the area of 80% or greater) for prolonged periods, the performance of your system or application will suffer. For that reason, it's important to understand the cause of sustained high CPU so that it can be addressed and corrected if possible.

## Troubleshooting tools

### Task Manager

Use Task Manager to view CPU consumption.

1. Select Start and search for Task Manager to start Task Manager.
2. If you see a single list of tasks in the Task Manager window, click the **More details** arrow to show the expanded view.
3. Select the **Processes** tab.
4. Select the **CPU** column header to sort the list by CPU usage. Ensure the arrow that appears on the header points down to sort the data from highest to lowest.

If the process can be stopped, or related service can be disabled, stop the process or the service. Then, check whether it mitigates the issue.

This helps to confirm the process or application causing high CPU usage issue.

### Resource Monitor

Use the Resource Monitor to view CPU consumption

1. Press Win + R key on the keyboard to open the Run dialogue. Type **resmon** in the text box and press Enter to open the Resource Monitor.
2. Select the CPU tab.

   > [!NOTE]
   > You might need to maximize the window to see all the data.

3. Select the **Average CPU** column header to sort the list by overall CPU usage. Ensure the arrow that appears on the header points down so the data is sorted from highest to lowest.

The processes consuming more resources display at the top of the list. If any of these processes are higher than expected based on your environment, start looking at these top processes when determining the cause.

### Process Explorer

The [Process Explorer](/sysinternals/downloads/process-explorer) tool gives you a complete overview on what processes are currently running in your computer along with the details on who invoked it and how much system resources it is consuming.  

Use process explorer to look at the threads and their stacks executing at that time on the processor. If the process that is identified as the cause of the high CPU usage is a third party application, contact the application vendor for help.

Run process explorer as an administrator. Go to options and click on configure symbols and specify path for dbghelp.dll( you should have Debugging tools for Windows installed) and symbol server

If the process is an operating system related process for Eg. System, run Process Explorer as an administrator.
Right click on the process and go to properties. Then go to the threads tab and select the thread taking high CPU and click on stack to see the functions being executed.

## Common support scenarios

### Uniquely named Singular Microsoft Process

1. Collect (1-5 second snapshot interval) performance monitor log.
2. Collect a [Windows Performance Recorder (WPR)](/windows-hardware/test/wpt/windows-performance-recorder) log while issue is occurring.
   > [!Note]
   > Do not let this log run for period of time or length as file grows very quickly. You should only need to run the a few minutes (three to five minutes) to capture the high CPU usage.
3. Collect a couple of [ProcDump](/sysinternals/downloads/procdump) of process during high CPU spaced apart by few minutes.

### Svchost Process

If a svchost process consumes high CPU usage, and the svchost process contains more than one service, you need to break each service out to run in its own svchost process to determine which service is causing the high CPU usage. To do so, follow these step:

1. Open command prompted with elevated privileges.
2. Break each service out into its own svchost process if it is a shared svchost process by running following command:

   ```console
   sc config <service name> type= ow
   ```

   Replace \<service name\> with actual service name.

3. Restart the service
4. Verify service running in its own svchost process by running `tasklist /svc` from the command prompt.

   > [!Important]
   > You must go back and reverse what you did in step 2 once issue has been resolved.
   >
   > To do so,replace `sc config <service name> type= own` with `sc config <service name> type= share` in the command in step 2. Then restart the service.

5. After you break each service out into its own svchost process, you now need to identify which service was driving up CPU usage or consuming high CPU usage.
6. Collect (1-5 second snapshot interval) performance monitor log.
7. Document PID of the offending Svchost process.
8. Collect a WPR log while issue is occurring.
9. Collect a couple of procdump during process high CPU spaced apart by few minutes.

### Multiple instance of process running by same name

For example, this issue could occur with the explorer.exe processes on a Remote Desktop Protocol (RDP) server.

To troubleshoot this issue, follow these steps:

1. Collect (1-5 second snapshot interval) performance monitor log.
2. Collect a WPR log while issue is occurring.
3. Collect a couple of procdump during process high CPU spaced apart by few minutes.
4. Document the PID of the offending process by running the command: `tasklist /v /fo csv >Running_Process.txt`

### Third party application that uses high CPU usage

If the process that is identified as the cause is third party, you needs to contact the application vendor to understand why respective process is causing high CPU on the computer.

## Data Collection

### Before the issue happens

You can use Debug Diagnostic 2.0 version to troubleshoot this issue further. To use the tool, follow these steps.

1. Install the [Debug Diagnostic Tool v2 Update 2](https://www.microsoft.com/download/details.aspx?id=49924)
   > [!Note]
   > Please uninstall all other versions of Debug Diagnostic tool before installing the 2.0 version.

2. Extract the contents of the PERFMON.ZIP file (attached) to some folder on the server.
3. Open this folder from an elevated command prompt.
4. Run the Start_Perfmon.bat in the elevated command prompt to create the performance counter log and to start the logging.

### At the time of the issue

1. Open the Debug Diagnostic collection.

2. Go to the Processes tab, right-click the worker process corresponding to the right application pool and select “Create Full Userdump”.

3. Repeat the above step three times when the CPU is high

4. Stop the perfmon log by running stop_perfmon.bat

5. Compress the Data using DebugDiag (Tools menu -> Create Increment Cabinet File) and send this file. If this file gets too big, just zip up the folder where the dumps were generated and send it to us.

6. Please upload both the perfmon logs ( C:\Perflogs) and dumps to the workspace created for you.