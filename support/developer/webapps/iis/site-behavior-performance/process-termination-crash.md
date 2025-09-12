---
title: Troubleshoot a Process Crash in an IIS Application Pool
description: This article helps identify a process crash and provides methods to collect and analyze data for the crash.
ms.date: 03/04/2025
ms.custom: sap:Site Behavior and Performance\Process termination (crash)
ms.reviewer: khgupta, v-sidong
---
# Troubleshoot a process crash in an IIS application pool

This article helps you identify a process termination (more commonly referred to as a process crash) and provides methods to collect and analyze data for the crash.

## Identify a process crash

To identify that there's a process crash, follow these steps:

1. On the affected server, select <kbd>Win</kbd>+<kbd>R</kbd> on your keyboard to open the **Run** dialog box.
1. Type **eventvwr** and select <kbd>Enter</kbd> to open the Event Viewer application.
1. In Event Viewer, on the left-hand side, expand the **Windows Logs** folder, and then select the **System** event log.
1. In the **System** event log, you can choose to filter the log so that it shows you only the Windows Process Activation Service (WAS) source logs. The event type is **Warning**, and the **Event ID** is **5011**.

If there's any event with the preceding characteristics, it indicates a process crash. The wording for the event might look like the following one:

`A process serving application pool <name of the application pool> suffered a fatal communication error with the Windows Process Activation Service. The process id was '<id of process>'. The data field contains the error number.`.

Collect the following key points:

- Application pool name
- Timestamp of the event (note down the time zone in which your computer is)  

> [!NOTE]
>
> - These steps don't help identify what type of crash happened, but when a crash happened.
> - If your application pool holds more than one application in it, one of those applications might be the culprit for the crash. We recommend that you separate each application into its own application pool so that you can then limit the impact to just one application.

## Identify the cause of the crash

After you confirm there's a crash, follow these steps to determine what caused the application to crash:

1. On the affected server, select <kbd>Win</kbd>+<kbd>R</kbd> on your keyboard to open the **Run** dialog box.
1. Type **eventvwr** and select <kbd>Enter</kbd> to open the Event Viewer application.
1. In the **Application** event log, you can locate events that have **Source** labeled as **Application Error**. The event type is **Error** and the **Event ID** is **1000**.

From the information collected, you should get an idea of what might have caused the crash.

Take note of the following fields:

- **Faulting application** - In the context of IIS, the faulting application you want to look for is the IIS Worker Process **w3wp.exe**.
- **Faulting module name** - When a crash occurs, the faulting module name might be Microsoft Dynamic Link Libraries (DLLs). However, they're usually not the root cause of the crash.
- **Exception code** - The exception code gives an insight into what the error could be. Common codes include:

  |Exception code|Description|
  |-|-|
  |0xC0000005|This code, also known as Access Violation (you might see native DLLs, such as **ntdll.dll** or **msvcrt.dll** in the error message), indicates that the application tried to access a forbidden memory location. |
  |0xe0434352|This code indicates an unhandled second chance Common Language Runtime (CLR) exception. It means that a .NET exception occurred somewhere in the application's code. <br><br>If you encounter the exception, look for any events from the source .NET Runtime and with ID 1026. <br><br>If you find any events from the .NET Runtime source, take note of the details in the **General** tab of the event, the **Description**, and the **Exception Info** fields (the latter holds both the exception and a call stack). |
  |0xC00000fd|This code indicates that your code has suffered a stack overflow. If this is the error you see, something in the application code is going into a situation of infinite recursion (also known as infinite loop).|

## Data collection

To determine if you need a memory dump, start with the [Windows Error Reporting](#windows-error-reporting)(WER) feature that automatically collects information for you. Check the event logs related to WER to see if the information provided is sufficient to resolve the issue. If the information is sufficient, additional memory dumps aren't necessary. If it isn't, use the [Debug Diagnostic Tool](#debug-diagnostic-tool) or [ProcDump](#procdump) to collect crash dumps as described in the next section.

### Debug Diagnostic Tool

To take crash dumps using Debug Diagnostic Tool, follow these steps:

1. Download and install [Debug Diagnostic Tool](https://www.microsoft.com/download/details.aspx?id=103453).
1. Open the DebugDiag 2 Collection application and select **Add Rule** > **Crash** > **Next**.
1. Select **A specific IIS web application pool** > **Next**.

   > [!NOTE]
   > You should avoid using any other of the available options (consider them as a last resort only).

1. Select the crashing application pool (you can get the application pool name in the [Identify a process crash](#identify-a-process-crash) section) and select **Next**.
1. Select **Breakpoints** under **Advanced Settings**. Don't change any other options in this window and keep them at their default values.
1. In the **Configure Breakpoints** window, select **Add Breakpoint**.
1. Select the first line that reads **Ntdll!ZwTerminateProcess**. Then, select **Full Userdump** in the **Action Type** dropdown and set a value between 3 and 5 in the **Action Limit** field. Once done, select **OK**.

   :::image type="content" source="media/process-termination-crash/configure-breakpoint-action-limit.png" alt-text="Screenshot of the Configure Breakpoint window.":::

1. At this stage, you have successfully created a trigger for when the dumps are generated. Select **Save and Close**.

   :::image type="content" source="media/process-termination-crash/configure-breakpoint-save-close.png" alt-text="Screenshot of Save&Close in the Configure Breakpoint window.":::

1. In the **Advanced Configuration (Optional)** window, select **Next** to move to the next step in the wizard.
1. In the **Select Dump Location And Rule Name (Optional)** window, specify the path where you want to save the dumps. Once done, select **Next**.  

   :::image type="content" source="media/process-termination-crash/select-dump-location-and-rule-name.png" alt-text="Screenshot of the Select Dump Location And Rule Name (Optional) window.":::

   > [!NOTE]
   > - We recommend that you use a location on a drive to save the dumps other than the system drive.
   > - Make sure that the drive has sufficient space to hold the memory dump for the process.

1. Keep the default of **Activate the rule now** and select **Finish** when ready.
1. Reproduce the issue and monitor the **Userdump Count** column. After the memory dumps are generated, you can deactivate the rule.

   :::image type="content" source="media/process-termination-crash/userdump-count-column.png" alt-text="Screenshot of the Userdump Count column.":::

### ProcDump

ProcDump is a simpler way to take a memory dump of a process. To take crash dumps using ProcDump, follow these steps:

1. Download [ProcDump](/sysinternals/downloads/procdump).
1. Extract Procdump to a folder within the affected server. Make sure that the folder is in a drive other than the system drive to avoid any impact on the system drive.
1. Open the **Command Prompt** window as an administrator, and set that prompt's working directory to the directory in step 2.
1. Follow these steps to get PID:
   1. Open **IIS Manager**.
   1. Select your server name (on the left).
   1. Double-click **Worker Processes**. Take note of the PID value for the worker process that you want to troubleshoot.
1. With the PID value in hand and the exception that you have found in the [Identify a process crash](#identify-a-process-crash) section, type the following command in the administrative **Command Prompt** window:

   ```cmd
   procdump -ma -e 1 -f "<typeOfException>" PID
   ```

   - `-ma`: This flag specifies that a full memory dump should be captured.
   - `-e 1`: This flag indicates that the dump should be captured on the first occurrence of an exception.
   - `-f "<typeOfException>"`: This flag specifies that the tool should filter for the `<typeOfException>` type of exception.
   - `PID`: This is the Process ID of the application you want to monitor.

If the error code is `C00000FD`, and you aren't able to take a memory dump, follow these steps:

1. Download [ProcDump](/sysinternals/downloads/procdump).
1. Extract Procdump to a folder within the affected server. Make sure that the folder is in a drive other than the system drive to avoid any impact on the system drive.
1. Open the **Command Prompt** window as an administrator, and set that prompt's working directory to the directory in step 2.
1. Run the following command to configure ProcDump to automatically save memory dumps to a specified directory:

   The drive in the following command is just an example, and you should strive to ensure that the dumps don't get written to a system drive.

   ```cmd
   Procdump -ma -i Z:\Dumps 
   ```

1. Reproduce the issue while you monitor the folder for dumps.
1. As soon as you have a dump for the **w3wp** process you're targeting, run the following command to uninstall procdump as the postmortem debugger.

    ```cmd
    Procdump -u 
    ```

### Windows Error Reporting

Windows Error Reporting is a built-in facility in Windows designed to collect information on issues that Windows can detect, such as application faults, kernel faults, and unresponsive applications, and report this information to Microsoft.

To take crash dumps using Windows Error Reporting, follow these steps:

1. Open Event Viewer and look for Windows Error Reporting events.
1. Check the directories mentioned in the Windows Error Reporting events.
1. Locate files with the extension `.mdmp` (mini dump) or `.hdmp` (heap dump) in the mentioned directories.

   - If you have these dump files, provide them to Microsoft support if you create a support ticket.
   - If you don't have them, follow these steps to set up WER:

     1. Open the Windows Registry Editor (**regedit.exe**) and locate the key **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps**. If this key isn't available, create it.
     1. In the key from step a, create the following values:

        |Name|Type|Value to enter |
        |-|-|-|
        |DumpFolder|Expandable String Value (REG_EXPAND_SZ) |Path to a location where you want the files to (For example: **D:\Dumps**) <br>**Note**: Make sure that the drive you use isn't a system drive, and it has sufficient space to hold a memory dump of your application. |
        |DumpCount|DWORD (REG_DWORD) |**3** |
        |DumpType|DWORD (REG_DWORD)|**2** (Using this value can generate a full dump.)|

        For more on the possible values, see [Collecting User-Mode Dumps](/windows/win32/wer/collecting-user-mode-dumps).

## How to perform data analysis

To perform the analysis for the crash, follow these steps:

1. Download and install [DebugDiag](https://www.microsoft.com/download/details.aspx?id=103453) (short for Debug Diagnostic Tool).
1. Open DebugDiag2 Analysis and select **Add Data Files**.
1. In the file chooser dialog, it only lists dump files with a **\*.dmp** extension. Select the dump file you want to analyze.
1. Once you upload the desired file, select **Start Analysis**.

Once the analysis is complete, you see a file with an **.mht** extension loaded in the browser. The following example is from a dump on Notepad to display the final aspect of the analysis report.

:::image type="content" source="media/process-termination-crash/debugdiag-analysis-report.png" alt-text="Screenshot of DebugDiag Analysis Report.":::

## Analysis summary and report details

### 0xC00000fd

This error usually means that your code is performing a loop of sorts and calling the same function (or group of functions) until it exhausts the stack.

Here's an example of a stack overflow error:

:::image type="content" source="media/process-termination-crash/stack-overflow-error-summary.png" alt-text="Screenshot of a stack overflow error summary.":::

:::image type="content" source="media/process-termination-crash/stack-overflow-error-report-detail.png" alt-text="Screenshot of a stack overflow error report detail.":::

In the report, look for groups of functions or methods that seem to repeat. From there, attempt to correlate those functions with your code.

### 0xC0000005

This error usually means a component of your application tried to perform an invalid access of memory, resulting in an access violation.

You see the following summary and the report detail:

:::image type="content" source="media/process-termination-crash/access-violation-summary.png" alt-text="Screenshot of an access violation summary.":::

:::image type="content" source="media/process-termination-crash/access-violation-report-detail.png" alt-text="Screenshot of an access violation report detail.":::

In the report, locate the failing call stack and identify your code within the presented call stack.

### 0xe0434352

This exception is generated from your application, so the best way forward is to run the memory dump through the report and identify the call stack that is returning the error.

:::image type="content" source="media/process-termination-crash/net-second-hand-exception-summary.png" alt-text="Screenshot of .NET second hand exception summary.":::

:::image type="content" source="media/process-termination-crash/net-second-hand-exception-report-detail.png" alt-text="Screenshot of .NET second hand exception report detail.":::
