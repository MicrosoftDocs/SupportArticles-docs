---
title: Data Capture for Managed Memory Leaks
description: This article provides methods to capture data for managed memory leaks.
ms.date: 12/25/2024
ms.custom: sap:Site Behavior and Performance
ms.reviewer: 
---
# Data capture for managed memory leaks

This article provides methods to capture data for managed memory leaks that are easily replicable and intermittent.

## Memory leak issue is easily replicable (on-demand)

### Method 1: Using Procdump

> [!NOTE]
> If you're using **Procdump** for the first time, you need to accept the license agreement that appears to use the tool.

1. Download the [Procdump.exe](/sysinternals/downloads/procdump) tool on the server.
1. Monitor memory usage:

   Once the memory used by **w3wp.exe** (the IIS worker process) reaches a certain limit (as described in the [Overview of troubleshooting high memory issues]()), follow these steps to find the Process ID (PID):

   1. Open **IIS Manager**.
   1. Select your server name (on the left).
   1. Double-click **Worker Processes**.
   1. Find the **w3wp.exe** process that is using lots of memory. The PID is shown next to it. You might need to refresh this view manually.

      :::image type="content" source="media/data-capture-managed-memory-leak/worker-process.png" alt-text="Screenshot of Worker Process.":::

1. Run Procdump:

   1. Run **Command Prompt** as an administrator.
   1. In **Command Prompt**, navigate to the folder where **Procdump.exe** is saved.
   1. Run the command `procdump.exe -s 30 -ma -n 3 PID`, replacing `PID` with the actual PID that you found in step 2.

      - `-n`: The number of memory dumps to collect.
      - `-s`: Controls the time (in seconds) between dumps.

1. The first memory dump will be created, and you'll see confirmation in **Command Prompt**.
1. If you're using other Procdump options that rely on specific conditions to trigger a dump, keep an eye on the PID. If it changes, you need to stop the command and run it again with the new PID. Otherwise, no dumps will be captured.

### Method 2: Using DebugDiag

1. Install [Debug Diagnostic Tool v2 Update 3.2](https://www.microsoft.com/en-us/download/details.aspx?id=103453).
1. When a memory leak occurs, open **DebugDiag 2 Collection** from the **Start** menu:

   :::image type="content" source="media/data-capture-managed-memory-leak/debugdiag-2-collection.png" alt-text="Screenshot of DebugDiag 2 Collection.":::

   > [!NOTE]
   > If you need to change the path where dumps are generated, select **Tools** > **Options And Settings** > **Manual Userdump Save Folder** to change it.

1. Select the **Processes** tab.
1. Locate the **w3wp** process with the **Process ID** column of the application in question.

   For more information on how to get the PID, see step 2 in [Method 1: Using Procdump](#method-1-using-procdump).

1. Right-click the **w3wp** process, select **Create Userdump Series**, and set the following options (adjust the numbers as needed). Don't select **Save & Close**.

   :::image type="content" source="media/data-capture-managed-memory-leak/configure-userdump-series.png" alt-text="Screenshot of Configure UserDump Series.":::

1. Once the memory consumption of **w3wp.exe** reaches the limit (the decision is based on the memory consumption values given in the table in the [Overview of troubleshooting high memory issues]()), select **Save & Close**.

## Memory leak issue is too intermittent (automation needed)

1. Download the [Procdump.exe](/sysinternals/downloads/procdump) tool on the server.
1. Run **Command Prompt** as an administrator.
1. In **Command Prompt**, navigate to the folder containing **procdump.exe**.
1. Run the command: `procdump.exe -s 30 -m <memoryConsumption> -ma -n 3 PID`.

   Replace `PID` with the actual PID of the **w3wp.exe** process that is facing the high memory issue. For more information on how to get the PID, see step 2 in [Method 1: Using Procdump](#method-1-using-procdump).

   - `-n`: This parameter is the number of memory dumps to collect.
   - `-m`: This parameter is the memory commit threshold (in MB) for creating dumps.
   - `-s`: This parameter might have different meanings based on the other parameters in the procdump command.  

   When you use `-m` in the command, `-s` indicates the number of consecutive seconds during which **w3wp.exe**'s memory consumption is >= the threshold specified by `-m`.  

   For example, if the command is `procdump.exe -s 30 -m 5120 -ma -n 3 PID`, the process memory consumption must be >= 5120 MB (5 GB) for at least 30 seconds to generate a dump. If the first dump is written but then memory drops to less than 5,120 MB, the second and third dumps won't be collected, and the memory must increase back to 5,120 MB or higher and remain so for 30 seconds for the second dump to be generated, and so on. So, `-n` here doesn't necessarily mean the interval between the dumps.

1. The first memory dump will be created, and you'll see confirmation in **Command Prompt**. By default, the memory dump is saved in the same location as **procdump.exe**.

1. Keep monitoring the PID, as it might change over time. If it changes and you still run the old command with the old PID, no memory dumps will be generated. In such cases, you have to stop the command and run it again with the new PID.

## More information

[Overview of troubleshooting high memory issues]()