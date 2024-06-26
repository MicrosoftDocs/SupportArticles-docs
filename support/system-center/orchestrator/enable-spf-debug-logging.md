---
title: Enable debug logging in SPF
description: Describes how to enable debug logging in System Provider Foundation (SPF) either through the Windows Event Viewer or through the command line.
ms.date: 06/26/2024
ms.reviewer: markstan
---
# Debug logging in System Center Service Provider Foundation (SPF)

This article describes how to enable debug logging in System Provider Foundation (SPF) either through the Windows Event Viewer or through the command line.

_Applies to:_ &nbsp; All versions of Orchestrator  
_Original KB number:_ &nbsp; 2850280

## Symptoms

Microsoft System Center 2012 Service Pack 1 (SP1) System Provider Foundation and Microsoft System Center 2012 R2 System Provider Foundation contain native debug logging capabilities to enable troubleshooting of SPF issues. SPF incorporates Event Tracing for Windows (ETW) logging in order to produce verbose debug output. This functionality is turned off by default in order to provide optimal service performance, but may be enabled when reproducing issues with SPF. SPF logging may be enabled either through the Windows Event Viewer or through the command line by using the logman.exe utility.

## Method 1: Command line

This method has the advantage of being scriptable and also slightly less impactful to system performance. Because each debugging session will produce a new log, this method is also generally easier to use for iterative troubleshooting.

To create an SPF ETL trace, use the following steps:

1. Log on to your SPF server and open an elevated command prompt or PowerShell window by right-clicking on the shortcut and choosing **Run as Administrator**.

1. Type the following commands to create the trace definition:

   For System Center 2012 R2 System Provider Foundation:

   ```powershell
   logman create trace spfdebugtrace -p Microsoft-ServiceProviderFoundation0xc0000000000000000x5
   logman update spfdebugtrace -p Microsoft-Windows-PowerShell0xf0010000000003ff 0x5
   logman update spfdebugtrace -pActivityEventSource 0x0 0xff
   ```

   For System Center 2012 Service Pack 1 (SP1) System Provider Foundation:

   ```powershell
   logman create trace spfdebugtrace -p Microsoft-ServiceProviderFoundation-Core 0x8000000000000000 0x5
   logman update trace spfdebugtrace -p Microsoft-ServiceProviderFoundation-VMM 0x8000000000000000 0x5
   logman update spfdebugtrace -p Microsoft-Windows-PowerShell0xf0010000000003ff 0x5
   ```

1. Type `logman start spfdebugtrace` to start the trace.
1. Reproduce the issue you are investigating.
1. Stop the trace by typing `logman stop spfdebugtrace`.  
1. Navigate to the trace location (C:\PerfLogs\Admin by default, see below), and convert the trace to a readable format by typing the command `netsh trace convert spfdebugtrace_000001.etl`. The exact file name of the ETL file may be different if you have taken multiple traces. Type `logman query spfdebugtrace` and investigate the **Output** location value to see the name of the latest ETL file.

> [!TIP]
>
> - You can change the location of the log file by using the command `logman update trace spfdebugtrace -o <location>`. For example, `logman update trace spfdebugtrace c:\temp`.
> - If you cannot log on to the SPF server directly, but still have network connectivity, you can create the trace remotely by appending `-s <computername>` to the `logman` commands above. For example: `logman create trace spfdebugtrace -p Microsoft-ServiceProviderFoundation-Core 0x8000000000000000 0x5 -s spfserver01`.
> - ETL log files can grow large very quickly. Attempt to reproduce your issue and stop the trace as soon as the issue reproduces.
> - It may be helpful to simultaneously gather VMM debug logs for some issues. See [How to enable debug logging in Virtual Machine Manager](https://support.microsoft.com/help/2801185) for details.

## Method 2: Event Viewer

An alternate method to view SPF debug information is to enable the trace channel through Event Viewer. This method is less error-prone, but may be more difficult to view data if a large number of entries are logged. The information logged is identical.

To enable SPF debug logging in Event Viewer, use the following steps:

1. Open Event Viewer and select **View**, then select **Show Analytic and Debug Logs** if it's not already selected.
2. Navigate to **Applications and Services Logs** > **Microsoft** > **ServiceProviderFoundation** > **Core**.
3. Right-click **The Analytic channel for SPF core** and select **Enable log**. Answer **OK** when prompted to enable the log.
4. Repeat step 3 for **Applications and Services Logs** > **Microsoft** > **ServiceProviderFoundation** > **VMM** > **SPF VMM Analytic log**.
5. Reproduce your issue.
6. Right-click on each log and choose **Disable log**. Captured events will appear in the right-hand pane.

> [!TIP]
> You can export the logs for easier viewing by choosing **Actions\Save All Events As...** and changing the save as type to **Text (Tab delimited)(*.txt)**.
