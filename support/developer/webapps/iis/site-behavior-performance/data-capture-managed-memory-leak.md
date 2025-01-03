---
title: Data Capture for Managed Memory Leaks
description: This article provides methods to capture data for managed memory leaks.
ms.date: 12/30/2024
ms.custom: sap:Site Behavior and Performance\High memory usage
ms.reviewer: khgupta, v-sidong
---

# Data capture for managed memory leaks

When you [confirm that the type of memory leak](high-memory-consumption-issues-overview.md#identify-whether-the-memory-leak-is-managed-or-native-leak) is managed memory leaks, collect memory dumps of the process during the high memory usage event. These dumps can help you analyze and diagnose the cause of these leaks.

This article outlines the steps to capture memory dumps associated with managed memory leaks, both for consistently reproducible and intermittent cases.

## Memory leak issue is easily replicable

If the memory leak issue can be consistently reproduced whenever needed, use one of the following methods to capture data.

### Method 1: Using Procdump

[!INCLUDE [Note when using Procdump](../../../../includes/note-using-procdump.md)]

[!INCLUDE [Same steps when using Procdump](../../../../includes/same-steps-using-procdump.md)]  

4. Run the command: `procdump.exe -s 30 -ma -n 3 <PID>`.

   [!INCLUDE [How to get actual PID](../../../../includes/how-get-pid.md)]

   - `-n`: This parameter is the number of memory dumps to collect.
   - `-s`: This parameter is the interval (in seconds) between dumps.

[!INCLUDE [Run command again with new PID](../../../../includes/run-command-new-pid-procdump.md)]

### Method 2: Using DebugDiag

1. Download and install [Debug Diagnostic Tool v2 Update 3.2](https://www.microsoft.com/download/details.aspx?id=103453).
1. When a memory leak occurs, open **DebugDiag 2 Collection** from the **Start** menu:  
   
   :::image type="content" source="media/data-capture-managed-memory-leak/debugdiag-2-collection.png" alt-text="Screenshot of DebugDiag 2 Collection.":::

   > [!NOTE]
   > If you need to change the path where dumps are generated, select **Tools** > **Options And Settings** > **Manual Userdump Save Folder** to change it.
1. Select the **Processes** tab.
1. Locate the **w3wp** process with the **Process ID** column of the application in question.  
   [!INCLUDE [How to get actual PID](../../../../includes/how-get-pid.md)]
1. Right-click the **w3wp** process, select **Create Userdump Series**, and set the following options (adjust the numbers as needed). Don't select **Save & Close**.  
   
   :::image type="content" source="media/data-capture-managed-memory-leak/configure-userdump-series.png" alt-text="Screenshot of Configure UserDump Series.":::
   
1. Once the memory consumption of **w3wp.exe** reaches the limit as described in the [Memory limits for different scenarios](high-memory-consumption-issues-overview.md#memory-limits-for-different-scenarios), select **Save & Close**.

   The dumps will start generating immediately.

## Memory leak issue is intermittent

If the memory leak issue is intermittent, you can automate the data capture process using the following steps:

[!INCLUDE [Note when using Procdump](../../../../includes/note-using-procdump.md)]

[!INCLUDE [Same steps when using Procdump](../../../../includes/same-steps-using-procdump.md)]  

4. Run the command: `procdump.exe -s 30 -m <memoryConsumption> -ma -n 3 <PID>`.

   [!INCLUDE [How to get actual PID](../../../../includes/how-get-pid.md)]

   - `-n`: This parameter is the number of memory dumps to collect.  
   - `-m`: This parameter is the memory commit threshold (in MB) for creating dumps.  
   - `-s`: This parameter might have different meanings based on the other parameters in the `procdump` command.  

   When you use `-m` in the command, `-s` indicates the number of consecutive seconds during which **w3wp.exe**'s memory consumption is >= the threshold specified by `-m`.  

   For example, if the command is `procdump.exe -s 30 -m 5120 -ma -n 3 <PID>`, the process memory consumption must be >= 5,120 MB (5 GB) for at least 30 seconds to generate a dump. If the first dump is written but then memory drops to less than 5,120 MB, the second and third dumps won't be collected, and the memory must increase back to 5,120 MB or higher and remain so for 30 seconds for the second dump to be generated, and so on. So, `-s` here doesn't necessarily mean the interval between the dumps.

[!INCLUDE [Run command again with new PID](../../../../includes/run-command-new-pid-procdump.md)]

## More information

[Overview of high memory consumption issues](high-memory-consumption-issues-overview.md)
