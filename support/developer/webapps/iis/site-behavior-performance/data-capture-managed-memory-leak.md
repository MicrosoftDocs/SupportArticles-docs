---
title: Data Capture for Managed Memory Leaks
description: This article provides methods to capture data for managed memory leaks.
description: This article provides methods to capture data for managed memory leaks.

ms.reviewer: v-sidong
ms.custom: sap:Site Behavior and Performance
---
# Data capture for managed memory leaks

This article provides methods to capture data for managed memory leaks that are easily replicable and intermittent.


This article provides methods to capture data for managed memory leaks that are easily replicable and intermittent.


## Memory leak issue is easily replicable (on-demand)
> If you're using **Procdump** for the first time, you need to accept the license agreement that appears to use the tool.
### Method 1: Using Procdump

> [!NOTE]
> If you're using **Procdump** for the first time, you need to accept the license agreement that appears to use the tool.
   Once the memory used by **w3wp.exe** (the IIS worker process) reaches a certain limit (as described in the [Overview of troubleshooting high memory issues]()), follow these steps to find the Process ID (PID):

1. Download the [Procdump.exe](/sysinternals/downloads/procdump) tool on the server.
1. Monitor memory usage:

   1. Find the **w3wp.exe** process that is using lots of memory. The PID is shown next to it. You might need to refresh this view manually.

      :::image type="content" source="media/data-capture-managed-memory-leak/worker-process.png" alt-text="Screenshot of Worker Process.":::

   1. Select your server name (on the left).
   1. Double-click **Worker Processes**.
   1. Run **Command Prompt** as an administrator.


      :::image type="content" source="media/data-capture-managed-memory-leak/worker-process.png" alt-text="Screenshot of Worker Process.":::



1. Run Procdump:
1. If you're using other Procdump options that rely on specific conditions to trigger a dump, keep an eye on the PID. If it changes, you need to stop the command and run it again with the new PID. Otherwise, no dumps will be captured.
   1. Run **Command Prompt** as an administrator.
### Method 2: Using DebugDiag
   1. In **Command Prompt**, navigate to the folder where **Procdump.exe** is saved.
1. Install [Debug Diagnostic Tool v2 Update 3.2](https://www.microsoft.com/en-us/download/details.aspx?id=103453).
1. When a memory leak occurs, open **DebugDiag 2 Collection** from the **Start** menu:
      - `-n`: The number of memory dumps to collect.
   :::image type="content" source="media/data-capture-managed-memory-leak/debugdiag-2-collection.png" alt-text="Screenshot of DebugDiag 2 Collection.":::

   > [!NOTE]
   > If you need to change the path where dumps are generated, select **Tools** > **Options And Settings** > **Manual Userdump Save Folder** to change it.


1. Locate the **w3wp** process with the **Process ID** column of the application in question.


1. Install [Debug Diagnostic Tool v2 Update 3.2](https://www.microsoft.com/en-us/download/details.aspx?id=103453).
1. Right-click the **w3wp** process, select **Create Userdump Series**, and set the following options (adjust the numbers as needed). Don't select **Save & Close**.
1. When a memory leak occurs, open **DebugDiag 2 Collection** from the **Start** menu:
   :::image type="content" source="media/data-capture-managed-memory-leak/configure-userdump-series.png" alt-text="Screenshot of Configure UserDump Series.":::

1. Once the memory consumption of **w3wp.exe** reaches the limit (the decision is based on the memory consumption values given in the table in the [Overview of troubleshooting high memory issues]()), select **Save & Close**.


   > [!NOTE]
1. Download the [Procdump.exe](/sysinternals/downloads/procdump) tool on the server.
1. Run **Command Prompt** as an administrator.

1. Run the command: `procdump.exe -s 30 -m <memoryConsumption> -ma -n 3 PID`.
   
   Replace `PID` with the actual PID of the **w3wp.exe** process that is facing the high memory issue. For more information on how to get the PID, see step 2 in [Method 1: Using Procdump](#method-1-using-procdump).
## Memory leak issue is too intermittent (automation needed)
   - `-n`: This parameter is the number of memory dumps to collect.
   - `-m`: This parameter is the memory commit threshold (in MB) for creating the dumps.
   - `-s`: This parameter might have different meanings based on the other parameters in the procdump command.  

   When you use `-m` in the command, `-s` indicates the number of consecutive seconds during which **w3wp.exe**'s memory consumption is >= the threshold specified by `-m`.  
  
   For example, if the command is `procdump.exe -s 30 -m 5120 -ma -n 3 PID`, the process memory consumption must be >= 5,120 MB (5 GB) for at least 30 seconds to generate a dump. If the first dump is written but then memory drops to less than 5,120 MB, the second and third dumps won't be collected, and the memory must increase back to 5,120 MB or higher and remain so for 30 seconds for the second dump to be generated, and so on. So, `-n` here doesn't necessarily mean the interval between the dumps.

1. The first memory dump will be created, and you'll see confirmation in **Command Prompt**. By default, the memory dump is saved in the same location as **procdump.exe**.
1. Keep monitoring the PID, as it might change over time. If it changes and you still run the old command with the old PID, no memory dumps will be generated. In such cases, you have to stop the command and run it again with the new PID.



[Overview of troubleshooting high memory issues]()


1. Run **Command Prompt** as an administrator.

1. Run **Command Prompt** as an Administrator.
1. In **Command Prompt**, navigate to the folder containing **procdump.exe**.
1. Run run the command: `procdump.exe -s 30 -m <memoryConsumption> -ma -n 3 PID`.
   Replace `PID` with the actual PID of the **w3wp.exe** process that is facing the high memory issue. For more information on how to get the PID, see step 2 in [Method 1: Using Procdump](#method-1-using-procdump).

   Change `PID` to the actual PID of the **w3wp.exe** process that is facing the high memory issue. For more information on how to get PID, see step 2 in [Method 1: Using Procdump](#method-1-using-procdump).
   - `-n`: This parameter is the number of memory dumps to collect.

   - `-m`: This parameter is the memory commit threshold (in MB) for creating the dumps.

   - `-s`: This parameter might have different meanings based on the other parameters in the procdump command.  

   - `-s`: The parameter could mean different things based on the other parameters in the procdump command.  
   When you use `-m` in the command, `-s` indicates the number of consecutive seconds during which **w3wp.exe**'s memory consumption is >= the threshold specified by `-m`.  

   When you use `-m` in the command, `-s` would indicate the number of consecutive seconds during which **w3wp.exe** memory consumption was >= threshold specified with `-m`.  
   For example, if the command is `procdump.exe -s 30 -m 5120 -ma -n 3 PID`, the process memory consumption must be >= 5,120 MB (5 GB) for at least 30 seconds to generate a dump. If the first dump is written but then memory drops to less than 5,120 MB, the second and third dumps won't be collected, and the memory must increase back to 5,120 MB or higher and remain so for 30 seconds for the second dump to be generated, and so on. So, `-n` here doesn't necessarily mean the interval between the dumps.

   For example, if the command was `procdump.exe -s 30 -m 5120 -ma -n 3 PID`, the process memory consumption must be >= 5120 MB (5 GB) for at least 30 seconds for the dump to be generated. If the first dump gets written but then memory drops to less than 5,120 MB, the second and third dumps won't be collected, and the memory must increase back to 5,120 or higher and stays so for 30 seconds for the second dump to get generated, and so on. So, `-n` here doesn't necessarily mean the spacing between the dumps.
1. The first memory dump will be created, and you'll see confirmation in **Command Prompt**. By default, the memory dump is saved in the same location as **procdump.exe**.

1. The first memory dump will be created, and you'll see confirmation in **Command Prompt**. Default location is the same as where the **procdump.exe** is.
1. Keep monitoring the PID, as it might change over time. If it changes and you still run the old command with the old PID, no memory dumps will be generated. In such cases, you have to stop the command and run it again with the new PID.

1. Keep monitoring the PID as it might change over time. If it changes and you still run the old command with the old PID, no memory dumps will be generated, and you have to stop the command and run it again with the new PID instead.

## More information
[Overview of troubleshooting high memory issues]()

[Troubleshoot high memory issues overview]()
