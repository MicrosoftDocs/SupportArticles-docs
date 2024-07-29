---
title: Troubleshoot memory consumption between identical Windows Server environments
description: Describes how to use Performance Monitor to measure and compare memory consumption between identical server environments.
ms.date: 08/01/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika,5x5perf
ms.custom: sap:System Performance\Performance tools (Task Manager, Perfmon, WSRM, and WPA), csstroubleshoot
---
# Troubleshoot memory consumption between identical Windows Server environments

This article helps you measure and compare memory consumption between identical server environments. The goal is to reach Data-Based Conclusions (DBC) by establishing a baseline, collecting data over the same period, and ensuring that systems have the same workload.

## Prerequisites

- Create Performance Monitor data collector sets on both servers.
- Ensure that you can collect data traces from each server environment.
- Understand different user workloads and their impacts on resource usage.

## Quick workaround: restart the servers

1. Restarts both servers to clear any memory usage.
2. Monitor memory consumption for a predefined period after the reboot.

## Measure the memory performance

### Establish baseline with vanilla installation

Perform a vanilla installation on one server. Collect an eight-hour Performance Monitor trace during a normal working day.

### Collect data from client servers

During the same period as the vanilla installation, collect an eight-hour Performance Monitor trace from another two clients servers, client A and client B.

### Analyze user workload impact

1. Identify the workload types (Light, Medium, Heavy, Power) for each environment.
2. Use examples provided in [session host virtual machine sizing guidelines](/windows-server/remote/remote-desktop-services/virtual-machine-recs) to categorize user workload.
   - Light: Basic data entry tasks (for example, database entry applications).
   - Medium: Tasks such as market research using static web pages and Microsoft Word.
   - Heavy: Software development involving dynamic web pages, Microsoft Outlook, PowerPoint.
   - Power: Graphic design or 3D modeling with photo/video editing tools.
3. Use the following Performance counter objects to compare the activity on the system.
   - Memory
   - CPU
   - Disk Activity
   - Number of Processes
   - Number of sessions

### Compare key performance counters for memory

- Available MB: Remaining free RAM
- %committed bytes: Allocated physical resources
- Paged Pool: Kernel memory that can be paged out
- Non-Paged Pool: Kernel memory that can't be paged out
- Cache bytes: disk Usage kernel memory
- Working Set: Active process memory in RAM

### Different workloads affecting resource usage

Different user workloads lead to varying requirements for physical resources like CPU, RAM, and storage.

## Solution: standardize user behavior based on data collection

Identify similar usage patterns across all traces collected from the vanilla installation, client A, and client B.

Ensure workloads are comparable by reviewing performance counters under similar conditions:

|Counter|Vanilla installation|client A|client B|
|---|---|---|---|
|%committed bytes|X%|Y%|Z%|
|Available Mbytes|X|Y|Z|
|Process\Working set (_Total)|X|Y|Z|

Address discrepancies by adjusting resource allocations or optimizing applications accordingly.

## Scenario guide: Compare systems using the performance counters

Use tables to compare three systems (vanilla / client A / client B) by using the counters that are mentioned in the previous sections.

|Counter|Vanilla installation|client A|client B|
|---|---|---|---|
|%committed bytes|28.5%|42.7%|83%|
|Available MB (Min)|10.8 GB|7.5 GB|2.6 GB|
|Working set (_Total) (Max)|5.2 GB|8.7 GB|15.8 GB|

The result seems to confirm a different user load behavior. The result can be also confirmed by checking the number of processes:

|Counter|Vanilla installation|client A|client B|
|---|---|---|---|
|System\Processes (Max)|199|268|338|

If you want further confirmation, you can use the CPU-Usage, **Processor\\%idle time** (**_Total**), to identify a different user load pattern. Here are screenshots of some samples (The first one is for the vanilla installation, the second one is for client A and the third one is for client B).

Vanilla:  
:::image type="content" source="media/memory-consumption-between-identical-windows-server-setup/performance-monitor-trace-on-vanilla-installation.png" alt-text="Performance Monitor trace on vanilla installation." border="true":::

Client A:  
:::image type="content" source="media/memory-consumption-between-identical-windows-server-setup/performance-monitor-trace-on-client-a.png" alt-text="Performance Monitor trace on client A." border="true":::

Client B:  
:::image type="content" source="media/memory-consumption-between-identical-windows-server-setup/performance-monitor-trace-on-client-b.png" alt-text="Performance Monitor trace on client B." border="true":::

If you want to drill further down on user load behavior, try to check for the following processes:

- Outlook
- Office
- Teams (and with the teams process, there are msedgewebview2 processes)
- Microsoft Edge
- non-Microsoft browsers

## Data collection

If you still need help from Microsoft Support for further analysis and guidance, contact us with comprehensive logs.

To prepare detailed logs of all performance counters across extended periods, follow these steps:

- Make sure to record the same time and duration if you wish to compare.
- Run the following command to create an eight-hour performance data collector set that overwrites itself:

  ```console
  Logman.exe create counter PerfLog-30Sec-%ComputerName% -o "c:\perflogs\%computername%_PerfLog-30sec.blg" -f bincirc -v mmddhhmm -max 800 -c "Hyper-V Dynamic Memory Balancer (*)\*" "Hyper-V Hypervisor Virtual Processor(*)\*" "Hyper-V Hypervisor Logical Processor(*)\*" "\LogicalDisk(*)\*" "\Memory\*" "\Cache\*" "\Network Interface(*)\*" "\Paging File(*)\*" "\PhysicalDisk(*)\*" "\Processor(*)\*" "\Processor Information(*)\*" "\Processor Performance(*)\*" "\Process(*)\*" "\Redirector\*" "\Server\*" "\System\*" "\Server Work Queues(*)\*" "\Terminal Services\*" -si 00:00:30
  ```

  You still need to start the data collector set manually.
