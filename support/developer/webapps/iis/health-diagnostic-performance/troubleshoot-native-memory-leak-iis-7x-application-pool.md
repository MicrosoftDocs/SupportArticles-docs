---
title: Troubleshoot native memory leak in an IIS 7.x application pool
description: This article describes memory leak in an IIS application pool and helps identify the cause of issue.
ms.date: 04/09/2012
ms.custom: sap:Health, diagnostic, and performance features
ms.technology: health-diagnostic-performance
ms.reviewer: johnhart, hulopesv, v-sidong
---
# Troubleshoot native memory leak in an IIS 7.x application pool

_Applies to:_ &nbsp; Internet Information Services 7.0 and later versions

This article helps you to identify the cause of native memory leak in an IIS application pool.

## Overview

It's important to keep in mind that it's normal for high memory allocation as a web application serves requests.

When the memory leak in an IIS application pool occurs, increasing physical memory (RAM) isn't effective because the memory in this scenario isn't the physical memory (RAM) but a virtual memory. The following table summarizes the virtual memory that is addressable memory from the web application.

| Process | Windows | Addressable memory (with a large address-aware process) | Practical limit for virtual bytes | Practical limit for private bytes |
| --- | --- | --- | --- | --- |
| 32-bit | 32-bit | 2 GB | 1400 MB | 800 MB |
| 32-bit | 32-bit with /3GB | 3 GB | 2400 MB | 1800 MB |
| 32-bit | 64-bit | 4 GB | 3400 MB | 2800 MB |
| 64-bit | 64-bit | 8 TB | Not applicable | Not applicable |

## Scenario

You consistently see both Process\Private Bytes and Process\Virtual Bytes are increasing or Process\Private Bytes and Process\Working Set of *w3wp.exe* are increasing and Memory\Available Bytes is decreasing.

It may cause an out of memory exception on an application pool in IIS.

To recover, the application pool must be restarted, but after doing so, the memory usage again climbs to a high level. When you see the error above, the application pool has already restarted automatically.

## Data collection

The first thing you should do when you encounter the high memory usage is to determine whether the memory of a worker process on an application pool in IIS is leaked or not. You can use Performance Monitor. For more information on using Performance Monitor, see [Analyzing Performance Data](#analyzing-performance-data).

> [!TIP]
> If you need to identify which application pool is associated with a particular *w3wp.exe* process, open an Administrative Command Prompt, switch into the *%windir%\\System32\\inetsrv* folder (*cd %windir%\\System32\\inetsrv*) and run `appcmd list wp`. This will show the process identifier (PID) of the *w3wp.exe* process in quotes. You can match that PID with the PID available in Task Manager.

Once you have confirmed that a *w3wp.exe* process is experiencing high memory usage, you need to two pieces of information in order to determine what is causing the problem.

- A Performance Monitor data collector set.
- A user-mode memory dump of the *w3wp.exe* process.

Both of these need to be collected from the low memory usage such as starting the process until the high memory usage such as experiencing an out-of-memory exception.

### Collecting a Performance Monitor Data Collector Set

Performance Monitor (Perfmon) data can be viewed in real-time or it can be collected in a data collector set that can be reviewed later. For troubleshooting a high memory issue, we need to collect a data collector set. To create a data collector set for troubleshooting high memory, follow these steps:

1. Open **Administrative Tools** from the **Windows Control Panel**.
1. Double-click on **Performance Monitor**.
1. Expand the **Data Collector Sets** node.
1. Right-click on **User Defined** and select **New** > **Data Collector Set**.
1. Enter *High Memory* as the name of the data collector set.
1. Select the **Create Manually (Advanced)** radio button.
1. Select **Next**.
1. Select the **Create Data Logs** radio button.
1. Check the **Performance Counter* checkbox.
1. Select **Next**.
1. Select the **Add** button.
1. Expand **Process** from the list of counters.
1. Select **Private Bytes**, **Virtual Bytes** and **Working Set** from the **Thread** object.
1. Select \<ALL instances\> from the list of instances.
1. Select **Add**.
1. Expand **Memory** from the list of counters.
1. Select **Available Bytes** from the **Thread** object.
1. Select **Add**.
1. Select **OK**.
1. Set **Sample interval** to **1 Seconds** and then **Next** and Finish.

Your dialog should now look like the following one:

:::image type="content" source="media/troubleshooting-native-memory-leak-in-an-iis-7x-application-pool/data-collector-01-properties-dialog-box.png" alt-text="Screenshot of the Data Collector 01 Properties dialog box. The Performance Counters tab is open." lightbox="media/troubleshooting-native-memory-leak-in-an-iis-7x-application-pool/data-collector-01-properties-dialog-box.png":::

### Creating a Debug Diagnostics 1.2 Rule

The easiest way to collect user-mode process dumps when a high memory condition occurs is to use Debug Diagnostics (DebugDiag.) You can download [Debug Diagnostic Tool v2 Update 3](https://www.microsoft.com/download/details.aspx?id=58210).

Install DebugDiag on your server and run it. (You'll find it on the **Start** menu after installation.)

The most important information to figure out which function caused the memory leak is the stack traces of the heap allocations. By default, these stack traces aren't acquired. You can enable this feature per-process. Use the following command to enable stack tracing:

```cmd
gflags -i w3wp.exe +ust
```

The command doesn't enable stack tracing for a process that is already running. Therefore, for processes that you can't restart (for example, services, lsass, winlogon), you must restart your test computer.

Use the following commands to verify what settings have been set for a specific process:

```cmd
gflags -i w3wp.exe
```

When you run DebugDiag, it displays the **Select Rule Type** dialog. Follow these steps to create a leak rule for your application pool:

1. Select **Native (non-.NET) Memory** > **Handle Leak** > **Next**.
1. Select a process and select **Next**.
1. Select **Configure**.
1. Set the rule as shown in the following image:

    You can adjust these values if needed, but be careful not to specify a small number of MB in order to generate the tons of dump files. Generate a userdump when private bytes reach 800 MB and each additional 100 MB thereafter. Generate a userdump when virtual bytes reach 1024 MB and each additional 200 MB thereafter.

    :::image type="content" source="media/troubleshooting-native-memory-leak-in-an-iis-7x-application-pool/configure-user-dumps-leak-rule.png" alt-text="Screenshot of the Configure user dumps for Leak Rule dialog box. All options are checked." lightbox="media/troubleshooting-native-memory-leak-in-an-iis-7x-application-pool/configure-user-dumps-leak-rule.png":::

1. Select **Save & Close**.
1. Select **Next**.
1. Enter a name for your rule if you wish and make note of the location where the dumps will be saved. You can change this location if desired.
1. Select **Next**.
1. Select **Activate the Rule Now** > **Finish**.

If you get the out of memory error even when you get the memory dumps, you can get the memory dumps manually.

1. Select **Process** tab.
1. Right-click the target process.
1. Select **Create Full Userdump**.

## Data analysis

After getting the out of memory error or creating the memory dumps, you'll have two sets of data to review; the Perfmon data collector set and the memory dumps. Let's begin by reviewing the Perfmon data.

### Analyzing performance data

To review the Perfmon data for your issue, right-click on the **High Memory data collector set** listed under the **User Defined** node and select **Latest Report**. You can see something similar to the following image:

:::image type="content" source="media/troubleshooting-native-memory-leak-in-an-iis-7x-application-pool/performance-data-high-memory-data-collector-set.png" alt-text="Screenshot of the Performance data on the High Memory data collector set." lightbox="media/troubleshooting-native-memory-leak-in-an-iis-7x-application-pool/performance-data-high-memory-data-collector-set.png":::

To get to the root of what is causing the high CPU problem, review the dumps that were created using DebugDiag.

### Dump analysis with DebugDiag

DebugDiag has the ability to recognize many problems by doing an automated dump analysis. For this particular issue, DebugDiag's Performance Analyzers are well-suited to help identify the root cause of the high CPU issue. To use the analyzer, follow these steps:

1. Select the **Advanced Analysis** tab in DebugDiag.
1. Select **Memory Pressure Analyzers**. Make sure that you use *MemoryAnalysis.asp* instead of *DotNetMemoryAnalysis-BETA.asp*.
1. Select **Add Data Files**.
1. Browse to the location where the dumps were created. By default, this is a subfolder of the *C:\\Program Files\\DebugDiag\\Logs* folder.
1. Select one of the dumps and then select <kbd>Ctrl</kbd>+<kbd>A</kbd> to select all of the dumps in that folder.
1. Select **Open**.
1. Select **Start Analysis**.

DebugDiag takes a few minutes to parse through the dumps and provide an analysis. When it has completed the analysis, you see a page similar to the following image:

:::image type="content" source="media/troubleshooting-native-memory-leak-in-an-iis-7x-application-pool/debug-diag-analysis-report.png" alt-text="Screenshot of a DebugDiag analysis report." lightbox="media/troubleshooting-native-memory-leak-in-an-iis-7x-application-pool/debug-diag-analysis-report.png":::

> [!NOTE]
> The top of the report tells you that the memory leak was detected. In the Table Of Contents, you'll see a link to the details of Leak Analysis Report. Select that link and you'll see information about what those top 10 modules by allocation count or allocation size. Here is the example:

:::image type="content" source="media/troubleshooting-native-memory-leak-in-an-iis-7x-application-pool/details-high-memory-module.png" alt-text="Screenshot of details on high memory module." lightbox="media/troubleshooting-native-memory-leak-in-an-iis-7x-application-pool/details-high-memory-module.png":::

From this analysis, you can see the leakcom component is running. To look further down the **Module Information** of leakcom as shown below, you can see that `CFoo::crtheap` method allocates the outstanding memory.

:::image type="content" source="media/troubleshooting-native-memory-leak-in-an-iis-7x-application-pool/details-leak-com-module.png" alt-text="Screenshot of details for leakcom on the module." lightbox="media/troubleshooting-native-memory-leak-in-an-iis-7x-application-pool/details-leak-com-module.png":::

The next step is to review the code of `CFoo::crtheap` method. When you do that, you find the following code snippet:

```cpp
STDMETHODIMP CFoo::crtheap(void)
{
    malloc(1024 * 10);

    return S_OK;
}
```

The above code will definitely cause memory leak because allocated memory isn't released.

> [!TIP]
> If you enable stack tracing (`gflags -i w3wp.exe +ust`), you can see the following call stack by analyzing dumps with WinDBG. You will never see the following call stack if you disable stack tracing by default.

```cmd
0:000> !heap -p -a 42ae5b28
    address 42ae5b28 found in
    _HEAP @ 6690000
      HEAP_ENTRY Size Prev Flags    UserPtr UserSize - state
        42ae5b28 0541 0000  [00]   42ae5b40    02800 - (busy)
        77e9df42 ntdll!RtlAllocateHeap+0x00000274
        75133db8 msvcr90!malloc+0x00000079
        513f3cc7 LeakTrack!CCRTMemoryLT::R90mallocDetour+0x00000067
        75933cef oleaut32!CTypeInfo2::Invoke+0x0000023f
        61f527b8 leakcom!ATL::IDispatchImpl::Invoke+0x00000058
        f05cb4d vbscript!IDispatchInvoke+0x00000059
        f053f40 vbscript!InvokeDispatch+0x000001a5
        f060795 vbscript!InvokeByName+0x00000043
        f06080d vbscript!CScriptRuntime::RunNoEH+0x000022cf
        f054122 vbscript!CScriptRuntime::Run+0x00000064
        f054099 vbscript!CScriptEntryPoint::Call+0x00000074
        f054279 vbscript!CSession::Execute+0x000000c8
        f0544c0 vbscript!COleScript::ExecutePendingScripts+0x00000146
        f052013 vbscript!COleScript::SetScriptState+0x0000014d
        513023c0 asp!CActiveScriptEngine::TryCall+0x00000019
        513027b3 asp!CActiveScriptEngine::Call+0x000000e7
        513022c7 asp!CallScriptFunctionOfEngine+0x0000003e
        513063d5 asp!ExecuteRequest+0x0000014a
        51302676 asp!Execute+0x000001c4
        513028f2 asp!CHitObj::ViperAsyncCallback+0x000003fc
        51302030 asp!CViperAsyncRequest::OnCall+0x0000006a
        563de19 comsvcs!CSTAActivityWork::STAActivityWorkHelper+0x00000032
        771304fb ole32!EnterForCallback+0x000000f4
        771284c7 ole32!SwitchForCallback+0x000001a8
        77126964 ole32!PerformCallback+0x000000a3
        7713df32 ole32!CObjectContext::InternalContextCallback+0x0000015b
        771f47ef ole32!CObjectContext::DoCallback+0x0000001c
        563dfbd comsvcs!CSTAActivityWork::DoWork+0x0000012f
        563e51b comsvcs!CSTAThread::DoWork+0x00000018
        563f24d comsvcs!CSTAThread::ProcessQueueWork+0x00000037
        563f4c0 comsvcs!CSTAThread::WorkerLoop+0x00000135
        773a1287 msvcrt!_endthreadex+0x00000044
```

## Conclusion

By using Perfmon and DebugDiag, you can easily collect data that can be helpful in determining the cause of memory leak in application pools. If you're unable to find the root cause using these techniques, you can open a support ticket with Microsoft. Be sure to include the Perfmon data and stack tracing dumps in your support ticket to help reduce the turnaround time.

## Other resources

- [How to use the IIS Debug Diagnostics tool to troubleshoot a memory leak in an IIS process](https://support.microsoft.com/topic/how-to-use-the-debug-diagnostics-tool-to-troubleshoot-a-process-that-has-stopped-responding-in-iis-995db9a3-a3be-6d20-cf2f-c48101a64444)
