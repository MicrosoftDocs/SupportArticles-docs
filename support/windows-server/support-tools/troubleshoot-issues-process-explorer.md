---
title: Troubleshoot issues using Process Explorer
description: Helps troubleshoot issues using Process Explorer.
ms.date: 04/23/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-lianna
ms.custom: sap:System Performance\Performance tools (Task Manager, Perfmon, WSRM, and WPA)
---
# Troubleshoot issues using Process Explorer

This article helps troubleshoot issues using Process Explorer.

The Process Explorer tool is part of the [Sysinternals](/sysinternals) tool suite. It shows all the processes that are currently running on the computer, along with details about who invoked them and the total system resources they (including their stacks and threads) are consuming.

If you want to verify an operating system-related process (for example, System), follow these steps:

1. Run Process Explorer as an administrator.
2. Right-click the process, select **Properties**, and then select the **Threads** tab.
3. Select the thread that you want to verify, and then select **Stack** to view the functions that are being run.

To get a better stack information result, configure symbols in Process Explorer by following these steps:

1. Install [Debugging Tools for Windows](/windows-hardware/drivers/debugger/debugger-download-tools).
2. Run Process Explorer as an administrator.
3. Select the **Options** menu, and then select **Configure Symbols**.
4. Change the **Dbghelp.dll path** to _C:\\Program Files (x86)\\Windows Kits\\10\\Debuggers\\x64\\dbghelp.dll_.
5. Change the **Symbols path** to _srv*c:\\symbols\*https:\//msdl.microsoft.com/download/symbols_, and then select **OK**.

Here's an example of whether the symbols are resolved. If the symbols aren't resolved, the **Start Address** of thread 9384 shows **SearchUI.exe+0x120cd0**, where **0x120cd0** (in hexadecimal) is the offset of the function after the plus sign.

:::image type="content" source="media/troubleshoot-issues-process-explorer/process-explorer-symbols-not-resolved.png" alt-text="Screenshot showing that the Start Address of thread 9384 isn't resolved.":::

If the symbols are resolved, you'll see the actual function name as follows. For example, **SearchUI.exe!WinMainCRTStartup**:

:::image type="content" source="media/troubleshoot-issues-process-explorer/process-explorer-symbols-resolved.png" alt-text="Screenshot showing that the Start Address of thread 9384 is resolved.":::

You can view more information in Process Explorer by right-clicking a column and selecting **Select Columns**. Then, you can select the columns that will appear in Process Explorer and select **OK**.

## Troubleshooting example

When you use [CpuStres](/sysinternals/downloads/cpustres) to simulate CPU activity by running several threads, you can see that the **CPUSTRES.EXE** process in Process Explorer consumes the highest CPU. For example:

:::image type="content" source="media/troubleshoot-issues-process-explorer/cpustres-consume-high-cpu.png" alt-text="Screenshot showing that the CPUSTRES.EXE process in Process Explorer consumes the highest CPU.":::

Double-click **CPUSTRES.EXE** (or right-click **CPUSTRES.EXE** and select **Properties**) and go to the **Threads** tab.

:::image type="content" source="media/troubleshoot-issues-process-explorer/cpustres-thread-15080.png" alt-text="Screenshot showing that thread 15080 consumes the highest CPU in the CPUSTRES.EXE properties.":::

You can see that many threads are consuming the CPU, among which TID 15080 consumes the most. There are many more details. When you select the most consuming thread, you get the call stack information:

:::image type="content" source="media/troubleshoot-issues-process-explorer/stack-thread-15080.png" alt-text="Screenshot showing the call stack information of thread 15080.":::

The call stack information isn't updated automatically. To get the latest stack information, select **Refresh**. However, this refresh has a minimum interval of one second. To see what's happening in the thread each second, you can use Windows Performance Recorder (WPR) or Windows Performance Analyzer (WPA).

## References

[Defrag Tools: #2 - Process Explorer](/shows/defrag-tools/2-process-explorer)
