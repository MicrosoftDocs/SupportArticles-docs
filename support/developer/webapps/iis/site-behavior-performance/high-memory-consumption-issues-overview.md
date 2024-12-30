---
title: High Memory Consumption Issues Overview
description: This article provides methods to capture data for managed memory leak.
ms.date: 12/25/2024
ms.custom: sap:Site Behavior and Performance
ms.reviewer: 
---
# High memory consumption issues overview

This article helps troubleshoot high memory consumption issues in applications.

## Data capture prerequisites

### Tools required

- [Performance Monitor](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc749154(v%3dws.11))
- [ProcDump](/sysinternals/downloads/procdump)
- [DebugDiag](https://www.microsoft.com/en-us/download/details.aspx?id=103453)

> [!NOTE]
>
> - Avoid using Task Manager for collecting memory dumps. Specialized tools like DebugDiag and Procdump are more effective for ASP.NET applications as they understand managed code better and handle process bitness automatically.
> - Multiple attempts might be needed to get a useful set of memory dumps.
> - Ensure you have sufficient disk space for memory dumps. Each dump will be approximately the size of the process at that time. For instance, if the process is 1GB, generating 3 dumps requires about 4GB of space.

## Identifying the high memory usage

The simplest way to identify high memory usage is monitoring the **Private Bytes** counter, which indicates the amount of private committed memory used by the process. To use IIS Manager's Worker Process module for checking the **Private Bytes (KB)**, follow these steps:

1. Open **IIS Manager**.
1. Select your server name (on the left).
1. Double-click **Worker Processes**.
1. Find the **w3wp.exe** process that's using lots of memory. The PID is shown next to it. You might need to refresh this view manually.

:::image type="content" source="media/data-capture-managed-memory-leak/worker-process.png" alt-text="A screenshot of Worker Process.":::

## Symptoms for different scenarios

Memory leaks generally result in a steady increase in memory usage, leading to crashes or performance declines:

- **32-bit applications**: Might crash and throw an `OutOfMemory` exception when running out of memory, possibly without reporting errors before crashing.
- **64-bit applications**: Due to the large address space of 64-bit applications, it's rare to fail when trying to allocate virtual memory. However, it can grow to have a very large virtual address space and cause excessive paging of physical memory, which affects applications and other applications that are competing for physical memory.

|Scenario | Memory limit |More information|
| --- | --- | --- |
| 32-bit app on 32-bit Windows | 4 GB in total (2 GB in [user mode](/windows-hardware/drivers/gettingstarted/user-mode-and-kernel-mode), 2 GB in [kernel mode](/windows-hardware/drivers/gettingstarted/user-mode-and-kernel-mode))|If you use the **/LARGEADDRESSAWARE** flag in your 32-bit app and use the **/3GB** switch in the **boot.ini** file of the operating system during boot time, it makes the user mode memory 3 GB and kernel mode 1 GB. |
| 32-bit app on 64-bit Windows | 4 GB in total (2 GB in [user mode](/windows-hardware/drivers/gettingstarted/user-mode-and-kernel-mode), 2 GB in [kernel mode](/windows-hardware/drivers/gettingstarted/user-mode-and-kernel-mode)) |If you use the **/LARGEADDRESSAWARE** flag in your 32-bit app, it makes the user mode memory 4 GB. Kernel doesn't use the 32-bit address space on 64-bit operating system. It just uses the required space from the 64-bit address space |
| 64-bit app on 64-bit Windows | Supports up to 256 TB (128 TB in user mode, 128 TB in kernel mode) |NA|
|64-bit application on 32-bit Windows |Invalid Scenario  |NA|

High memory usage may not always indicate a leak; processes might recover if allocated memory is freed later.

## Validate if it's a managed or native memory leak

To set up Perfmon, follow these steps:

1. Open **Performance Monitor** and select the **+** icon to add counters.

   :::image type="content" source="media/high-memory-consumption-issues-overview/performance-monitor.png" alt-text="A screenshot of Performance Monitor.":::

1. Select all the **.Net Clr Memory Counters (#Bytes in all heaps)** and the target process. Here is **w3wp** and select **Add**.
1. Select **Private Bytes** and **Virtual Bytes** under **Process** counter, select the target process and Click Add (You can ignore the working set).

   :::image type="content" source="media/high-memory-consumption-issues-overview/add-counters-performance-monitor.png" alt-text="A screenshot of Add Counters in Performance Monitor.":::

1. Select **OK** and reproduce the issue.

You can monitor how the counters will vary depending on whether it's a managed or a native memory leak:

### Indicators for managed and native memory leaks

- **Managed Memory Leaks**: If the **Private Bytes** counter and the .NET bytes in all heaps counter are increasing at the same rate (the difference between the two remains constant), it indicates a managed memory leak.

   :::image type="content" source="media/high-memory-consumption-issues-overview/managed-memory-leak-indicator.png" alt-text="A screenshot of managed memory leak indicator.":::

  For more information, see [Data capture for managed memory leak](data-capture-managed-memory-leak.md).

- **Native Memory Leaks**: If the **Private Bytes** counter is increasing but the .NET bytes in all heaps counter remains constant, it indicates a native memory leak.

   :::image type="content" source="media/high-memory-consumption-issues-overview/native-memory-leak-indicator.png" alt-text="A screenshot of native memory leak indicator.":::

## .NET Core applications

If the app in question is .NET Core and hosted on IIS in-process mode, this above option for log collection applies as is. But if the app is hosted on IIS as out-of-proc mode then the action plan should be modified so that the dotnet process(dotnet.exe unless otherwise specified) is investigated instead of w3wp.exe. Same thing applies for self-hosted .NET Core applications.

## Troubleshooting example

Consider you have an application hosted on an IIS server and you have high memory usage (The memory spikes up to around 7 GB by doing a stress test) when accessing a specific URL, follow these steps to diagnose:

1. Check Performance Monitor by following the steps in [Validate if it's a managed or native memory leak](#validate-if-its-a-managed-or-native-memory-leak), you notice **Private Bytes** and **Bytes in all Heaps** remain constant which indicates it's a managed memory leak.
1. Collect dump files by using DebugDiag.
1. Open the dump files in [WinDbg](/windows-hardware/drivers/debugger/) and run the following commands based on your scenario.

    |Command|Usage|
    |---|---|
    |`!dumpheap -stat`   |This command shows you all the statistics about the managed heap. You can use the different switches of `!dumpheap` to customize the output to focus on specific types of objects, sizes, or states, making it easier to analyze the managed heap and identify issues such as memory leaks. |
    |`!eeheap -gc` |This command can be used to get the managed heap size. |
    |`!threads`  |This command helps check if there're any finalizer threads which displays all managed threads. |
    |`!finalizequeue` |This command is used to dospaly all objects which are in finalize queue. |

1. Run `!dumpheap -stat`, you see that `system.char[]`, `system.Text.Stringbuilder`, and `BuggyBits.Models.Link` are the ones consuming 3,22,547, 3,22,408 and 3,20,031 objects on the heap which are the highest among the lot.
1. Dump out statistics for various size `char[]` to find out if there is a pattern (This is a trial-and-error process, so you have to try different sizes to figure out where the bulk of the strings are).
1. Get the method table (MT) for `System.Char[]` (first column in `!dumpheap -stat`), you can see that most of them are of the same size.
1. Dump out a few of them to find out what they contain.
1. run `gcroot` on some of those address, you see there is a finalizer queue.
1. Look at the finalizer thread to see what it is doing. Running the !threads will list out all threads and show us the state of those threads.
1. You can see there is one thread 42 having Finalizer, dumping out that and checking stack:  
1. From the above, you can see buggybits.models.link calling out some Thread.Sleep. So, checking the code we can see that in Link.cs, there is explicit call to Thread.sleep which is causing high memory usage.  

## More information

[Use Performance Monitor to find a user-mode memory leak](/windows-hardware/drivers/debugger/using-performance-monitor-to-find-a-user-mode-memory-leak)