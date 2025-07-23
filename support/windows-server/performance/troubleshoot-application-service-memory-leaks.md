---
title: Application or service memory leaks troubleshooting guidance
description: Provides guidance on how to troubleshoot application or service memory leaks.
ms.date: 07/22/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna
ms.custom:
- sap:system performance\app,process,service performance (slow,unresponsive)
- pcy:WinComm Performance
---
# Application or service memory leaks troubleshooting guidance

This article provides guidance to troubleshoot applications or services with memory leak behaviors and how to proceed.

_Applies to:_ &nbsp; All supported versions of Windows Server and Windows Client

You see Event ID 2004 repeatedly in the system log. As the event source mentions, there's a resource exhaustion in the system on the virtual memory space. The description lists the system's top memory consumers at that time.

Apart from this event, you also notice high memory consumption by checking live or historical data from monitoring tools, or by using the Windows Task Manager.

The following troubleshooting process is helpful for both scenarios where first-party and third-party processes might be leaking memory. For first-party processes, you can use the public symbol store available. However, if you can't see the actual function in a third-party process, you can engage the vendor for further checking. Even if the function doesn't show, the allocation stack should indicate a third-party module.

A few SysInternals tools and Windows Performance Toolkit are used.

## Before you begin

You might see the following examples in the system event log and Task Manager.

```output
Log Name:      System
Source:        Microsoft-Windows-Resource-Exhaustion-Detector
Date:          <DateTime>
Event ID:      2004
Task Category: Resource Exhaustion Diagnosis Events
Level:         Warning
Keywords:      Events related to exhaustion of system commit limit (virtual memory).
User:          SYSTEM
Computer:      WIN-LAB
Description:
Windows successfully diagnosed a low virtual memory condition. The following programs consumed the most virtual memory:wpa.exe (9844) consumed 13714722816 bytes, msedgewebview2.exe (112572) consumed 3037757440 bytes, and EngHost.exe (37280) consumed 2619834368 bytes.
```

:::image type="content" source="./media/troubleshoot-application-service-memory-leaks/task-manager-test-limit.png" alt-text="Screenshot of Task Manager showing the process with high memory consumption.":::

The memory shown in the default list of columns isn't the one that should be focused on, since it represents the memory privately used by the process but backed by physical memory (working set). You need to verify virtual memory that is used by the operating system for its operation regardless of the way the virtual memory is backed (RAM or pagefile). In this case, you need to verify **Commit size**.

Here are some examples:

:::image type="content" source="./media/troubleshoot-application-service-memory-leaks/task-manager-test-limit-commit-size.png" alt-text="Screenshot of Task Manager showing the process with high commit size.":::

:::image type="content" source="./media/troubleshoot-application-service-memory-leaks/task-manager-virtual-memory-commit-size.png" alt-text="Screenshot of Task Manager showing the VirtMemTest32 process with high commit size.":::

You can use [VMMap](/sysinternals/downloads/vmmap) and [Windows Performance Toolkit](/windows-hardware/test/wpt) for the troubleshooting.

VMMap is used to determine the type of memory leaks. The Windows Performance Toolkit includes the Windows Performance Recorder (WPR) tool and the Windows Performance Analyzer (WPA) tool, which are used to collect and analyze data.

## Gather data

During this stage, if the memory usage is growing over time and not releasing, which indicates a leak pattern. The increase doesn't need to be a straight line to fall into this pattern, the key point is that the memory usage keeps on increasing over time.

:::image type="content" source="./media/troubleshoot-application-service-memory-leaks/increase-leak-pattern.png" alt-text="Screenshot of the memory usage with an increase pattern.":::

At this point, with a leak pattern, you need to determine the leaking memory type. Open VMMap and select the process that has been identified as the leaking memory.

### Determining the memory type

When virtual allocation memory is leaked, it's represented in VMMap as **Private Data**:

:::image type="content" source="./media/troubleshoot-application-service-memory-leaks/virtual-memory-private-data.png" alt-text="Screenshot of the virtual allocation memory leaks represented as Private Data in VMMap.":::

If you have a memory dump of the process, you can run the following command to see the memory layout. Virtual allocation shows as `<unknown>`:

```console
0:000> !address -summary

--- Usage Summary ---------------- RgnCount ----------- Total Size -------- %ofBusy %ofTotal
Free                                     58        0`85c87000 (   2.090 GB)           52.26%
<unknown>                                56        0`7866f000 (   1.881 GB)  98.52%   47.03%
Image                                   116        0`016de000 (  22.867 MB)   1.17%    0.56%
Stack32                                   9        0`00240000 (   2.250 MB)   0.12%    0.05%
Other                                     6        0`001aa000 (   1.664 MB)   0.09%    0.04%
Heap32                                    8        0`0012b000 (   1.168 MB)   0.06%    0.03%
Stack64                                   9        0`000c0000 ( 768.000 kB)   0.04%    0.02%
Heap64                                    4        0`00039000 ( 228.000 kB)   0.01%    0.01%
TEB64                                     3        0`00006000 (  24.000 kB)   0.00%    0.00%
TEB32                                     3        0`00006000 (  24.000 kB)   0.00%    0.00%
PEB64                                     1        0`00001000 (   4.000 kB)   0.00%    0.00%
PEB32                                     1        0`00001000 (   4.000 kB)   0.00%    0.00%
```

When heap allocation memory is leaked, it's represented with **Heap**:

:::image type="content" source="./media/troubleshoot-application-service-memory-leaks/virtual-memory-heap-allocation.png" alt-text="Screenshot of the VirMemTest32 process with the heap allocation memory leaks represented as Heap in VMMap.":::

If you have a memory dump of the process, you can run the following command to see the memory layout. Heap allocation shows as `Heap`:

```console
0:000> !address -summary

--- Usage Summary ---------------- RgnCount ----------- Total Size -------- %ofBusy %ofTotal
Heap32                                   67        0`709f3000 (   1.760 GB)  91.47%   87.99%
Free                                    115        0`04e03000 (  78.012 MB)            3.81%
<unknown>                                59        0`0470c000 (  71.047 MB)   3.61%    3.47%
Image                                   225        0`02e8f000 (  46.559 MB)   2.36%    2.27%
Other                                    37        0`021af000 (  33.684 MB)   1.71%    1.64%
Stack32                                  39        0`00d00000 (  13.000 MB)   0.66%    0.63%
Stack64                                  39        0`00340000 (   3.250 MB)   0.16%    0.16%
Heap64                                    4        0`00039000 ( 228.000 kB)   0.01%    0.01%
TEB64                                    13        0`0001a000 ( 104.000 kB)   0.01%    0.00%
TEB32                                    13        0`0001a000 ( 104.000 kB)   0.01%    0.00%
Other32                                   1        0`00001000 (   4.000 kB)   0.00%    0.00%
PEB64                                     1        0`00001000 (   4.000 kB)   0.00%    0.00%
PEB32                                     1        0`00001000 (   4.000 kB)   0.00%    0.00%
```

### Collect trace data for virtual allocation memory

With the way to identify the leaking memory, the next step is to collect reproducible data to determine the driver responsible for the leaking allocations.

Use the following command to collect data when the process shows the behavior. **WPR.exe** is included natively on operating systems after Windows 10 or Windows Server 2016.

Run the following command from a command prompt as an administrator:

```console
C:\>wpr -start VirtualAllocation
```

Allow the process to run for some time. You can monitor the growth of memory consumption with Task Manager (**Commit size**).

Since it only collects virtual allocation data, the trace file won't grow that large, so you can let it run for several minutes. Once you see enough leaked memory, stop the trace by using the following command:

```console
C:\>wpr -stop virtalloc.etl
```

### Collect trace data for heap allocation memory

Like virtual allocation, you can also use WPR for heap tracing.

However, a registry modification is required to enable the heap tracing. You can manually modify the registry or run the following command to enable heap tracing for the target process (for example, **VirtMemTest32.exe**).

Run the following command from a command prompt as an administrator:

```console
C:\>wpr -heaptracingconfig VirtMemTest32.exe enable
```

> [!NOTE]
> If the process is running when you run the command, restart the process for the setting to be enabled.

Heap tracing was successfully enabled for process **VirtMemTest64.exe**.

The result is:

Registry key: `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsNT\CurrentVersion\Image File Execution Options\VirtMemTest32.exe`
Value name: `Tracing Flags`
Value type: `REG_DWORD`
Value data: `0x00000001 (1)`

You can delete the registry key after the troubleshooting or set the value to `0`.

Use the following command to collect data when the process shows the behavior. **WPR.exe** is included natively on operating systems after Windows 10 or Windows Server 2016.

Run the following command from a command prompt as an administrator:

```console
C:\>wpr -start Heap
```

Allow the process to run for some time. You can monitor the growth of memory consumption with Task Manager (**Commit size**).

Since it only collects heap data, the trace file won't grow that large, so you can let it run for several minutes. Once you see enough leaked memory, stop the trace by using the following command:

```console
C:\>wpr -stop Heap.etl
```

## Analyze data

Use **WPA.exe** to open the trace. WPA can be downloaded via the Assessment and Deployment Kit (ADK) package for the Windows Performance Toolkit.

Open WPA and set up the symbol path. In the menu, select **Trace** > **Configure Symbol Paths**. Configure symbols by adding the public symbol path as **srv*C:\LocalPubSymbols*https://msdl.microsoft.com/download/symbols**, so you can load symbols (in the menu, select **Trace** > **Load Symbols**) before checking the trace.

### Analyze trace data for virtual allocation memory

Replicate the following view by replacing the process with the one you've identified as relevant. Ensure that the **Commit Stack** column is on the left of the gold/yellow line. Drill down by expanding the stack, and you'll see the function that shows the allocation of virtual memory. The driver listed before (up) the function is the one calling to that operation.

:::image type="content" source="./media/troubleshoot-application-service-memory-leaks/trace-data-virtual-allocation.png" alt-text="Screenshot of the analysis trace data for virtual allocation memory.":::

### Analyze trace data for heap allocation memory

Replicate the following view by replacing the process with the one you've already identified as relevant. Ensure that the **Handle** and **Stack** columns are on the left of the gold/yellow line. Drill down by expanding the stack, and you'll see the function that shows the allocation of heap memory. The driver listed before (up) the function is the one calling to that operation.

:::image type="content" source="./media/troubleshoot-application-service-memory-leaks/trace-data-heap-allocation.png" alt-text="Screenshot of the analysis of the trace data for heap allocation memory.":::

:::image type="content" source="./media/troubleshoot-application-service-memory-leaks/heap-allocation-function-driver.png" alt-text="Screenshot of the analysis of the trace data for heap allocation memory with the drive listed.":::

> [!NOTE]
> If you don't see the heap allocation graph, it's because the registry key isn't set correctly. Review the steps.
