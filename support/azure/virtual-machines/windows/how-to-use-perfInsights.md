---
title: Troubleshoot Windows virtual machine performance issues using the Performance Diagnostics (PerfInsights) CLI tool
description: Learns how to use PerfInsights to troubleshoot Windows virtual machine (VM) performance problems.
services: virtual-machines
documentationcenter: ''
author: anandhms
manager: dcscontentpm
tags: ''
ms.service: azure-virtual-machines
ms.collection: windows
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting
ms.date: 05/02/2025
ms.author: genli
ms.custom: sap:VM Performance
---
#  Troubleshoot Windows virtual machine performance issues using the Performance Diagnostics (PerfInsights) CLI tool

**Applies to:** :heavy_check_mark: Windows VMs

The [Performance Diagnostics (PerfInsights) extension](https://aka.ms/perfinsightsdownload) is a self-help diagnostics tool that collects and analyzes diagnostic data, and provides a report to help troubleshoot Windows virtual machine (VM) performance problems in Azure. Use Performance Diagnostics to identify and troubleshoot performance issues in one of two modes: 

- **Continuous diagnostics** collects data at five-second intervals and reports actionable insights about high resource usage every five minutes. 
- **On-demand diagnostics** helps you troubleshoot an ongoing performance issue with more in-depth data, insights, and recommendations based on data collected at a single point in time. 


This article explains how to download the Performance Diagnostics extension to your Windows VM and run the tool using the CLI tool. You can also [run Performance Diagnostics from the portal](performance-diagnostics.md), and [deploy the Performance Diagnostics extension using an ARM template or PowerShell](performance-diagnostics-vm-extension.md).

If you're experiencing performance problems with virtual machines, before contacting support, run Performance Diagnostics.

## Supported troubleshooting scenarios

You can use Performance Diagnostics to troubleshoot various scenarios. The following sections describe common scenarios for using Continuous and On-Demand Performance Diagnostics to identify and troubleshoot performance issues. For a comparison of Continuous and On-Demand Performance Diagnostics, see [Performance Diagnostics insights and reports](performance-diagnostics.md)

> [!NOTE]
> For information about using PerfInsights across an Azure virtual machine scale set, see [PerfInsights and scale set VM instances](perfinsights-and-scale-set-vm-instances.md).

### Continuous diagnostics

Continuous Performance diagnostics lets you identify high resource usage by monitoring your VM regularly for:

- High CPU usage: Detects high CPU usage periods, and shows the top CPU usage consumers during those periods.
- High memory usage: Detects high memory usage periods, and shows the top memory usage consumers during those periods.
- High disk usage: Detects high disk usage periods on physical disks, and shows the top disk usage consumers during those periods.

### On-demand diagnostics

#### Quick analysis

This scenario collects the disk configuration and other important information, including:

- Event logs

- Network status for all incoming and outgoing connections

- Network and firewall configuration settings

- Task list for all applications that are currently running on the system

- Microsoft SQL Server database configuration settings (if the VM is identified
    as a server that is running SQL Server)

- Storage reliability counters

- Important Windows hotfixes

- Installed filter drivers

This is a passive collection of information that shouldn't affect the system.

>[!Note]
>This scenario is automatically included in each of the following scenarios.

#### Benchmarking

This scenario runs the [Diskspd](https://github.com/Microsoft/diskspd) benchmark test (IOPS and MBPS) for all drives that are attached to the VM.

> [!Note]
> This scenario can affect the system, and shouldn't be run on a live production system. If necessary, run this scenario in a dedicated maintenance window to avoid any problems. An increased workload that is caused by a trace or benchmark test can adversely affect the performance of your VM.
>

#### Performance analysis

This scenario runs a [performance counter](/windows/win32/perfctrs/performance-counters-portal) trace by using the counters that are specified in the RuleEngineConfig.json file. If the VM is identified as a server that is running SQL Server, a performance counter trace is run. It does so by using the counters that are found in the RuleEngineConfig.json file. This scenario also includes performance diagnostics data.

#### Azure Files analysis

This scenario runs a special performance counter capture together with a network trace. The capture includes all the Server Message Block (SMB) client shares counters. The following are some key SMB client share performance counters that are part of the capture:

| **Type**     | **SMB client shares counter** |
|--------------|-------------------------------|
| IOPS         | Data Requests/sec             |
|              | Read Requests/sec             |
|              | Write Requests/sec            |
| Latency      | Avg. sec/Data Request         |
|              | Avg. sec/Read                 |
|              | Avg. sec/Write                |
| IO Size      | Avg. Bytes/Data Request       |
|              | Avg. Bytes/Read               |
|              | Avg. Bytes/Write              |
| Throughput   | Data Bytes/sec                |
|              | Read Bytes/sec                |
|              | Write Bytes/sec               |
| Queue Length | Avg. Read Queue Length        |
|              | Avg. Write Queue Length       |
|              | Avg. Data Queue Length        |

#### Advanced performance analysis

When you run an advanced performance analysis, you select traces to run in parallel. If you want, you can run them all (Performance Counter, Xperf, Network, and StorPort).  

> [!Note]
> This scenario can affect the system, and shouldn't be run on a live production system. If necessary, run this scenario in a dedicated maintenance window to avoid any problems. An increased workload that is caused by a trace or benchmark test can adversely affect the performance of your VM.
>

## What information does Performance Diagnostics collect in Windows?

Information about Windows VM, disks or storage pools configuration, performance counters, logs, and various traces are collected. It depends on the performance scenario you're using. The following table provides details:

| Data collected | Quick performance analysis | Benchmarking | Performance analysis | Azure Files analysis | Advanced performance analysis |
|----------------------------------|----------------------------|------------------------------------|--------------------------|--------------------------------|----------------------|
| Information from event logs       | Yes                        | Yes                                | Yes                      | Yes                  | Yes                  |
| System information                | Yes                        | Yes                                | Yes                      | Yes                  | Yes                  |
| Volume map                        | Yes                        | Yes                                | Yes                      | Yes                  | Yes                  |
| Disk map                          | Yes                        | Yes                                | Yes                      | Yes                  | Yes                  |
| Running tasks                     | Yes                        | Yes                                | Yes                      | Yes                  | Yes                  |
| Storage reliability counters      | Yes                        | Yes                                | Yes                      | Yes                  | Yes                  |
| Storage information               | Yes                        | Yes                                | Yes                      | Yes                  | Yes                  |
| Fsutil output                     | Yes                        | Yes                                | Yes                      | Yes                  | Yes                  |
| Filter driver info                | Yes                        | Yes                                | Yes                      | Yes                  | Yes                  |
| Netstat output                    | Yes                        | Yes                                | Yes                      | Yes                  | Yes                  |
| Network configuration             | Yes                        | Yes                                | Yes                      | Yes                  | Yes                  |
| Firewall configuration            | Yes                        | Yes                                | Yes                      | Yes                  | Yes                  |
| SQL Server configuration          | Yes                        | Yes                                | Yes                      | Yes                  | Yes                  |
| Performance diagnostics traces *  | Yes                        | Yes                                | Yes                      | Yes                  | Yes                  |
| Performance counter trace **      |                            |                                    | Yes                      |                      | Yes                  |
| SMB counter trace **              |                            |                                    |                          | Yes                  |                      |
| SQL Server counter trace **       |                            |                                    | Yes                      |                      | Yes                  |
| Xperf trace                       |                            |                                    |                          |                      | Yes                  |
| StorPort trace                    |                            |                                    |                          |                      | Yes                  |
| Network trace                     |                            |                                    |                          | Yes                  | Yes                  |
| Diskspd benchmark trace ***       |                            | Yes                                |                          |                      |                      |
|       |                            |                         |                                                   |                      |                      |

### Performance diagnostics trace (*)

Runs a rule-based engine in the background to collect data and diagnose ongoing performance issues. Rules are displayed in the report under the Category -> Finding tab.

Each rule consists of the following items:

- Finding: Description of the finding.
- Recommendation: Recommendation on what action could be taken for the finding. There are also reference links to documentation containing more information on the finding and/or recommendation.
- Impact Level: Represents the potential for having an impact on performance.

The following categories of rules are currently supported:

- High resource usage:
  - High CPU usage: Detects high CPU usage periods, and shows the top CPU usage consumers during those periods.
  - High memory usage: Detects high memory usage periods, and shows the top memory usage consumers during those periods.
  - High disk usage: Detects high disk usage periods on physical disks, and shows the top disk usage consumers during those periods.
  - High resolution disk usage: Shows IOPS, throughput, and I/O latency metrics per 50 milliseconds for each physical disk. It helps to quickly identify disk throttling periods.
- Knowledge base: Detects if specific Knowledge Base (KB) articles aren't installed.
- Disk: Detects specific disk configuration settings.
- SQL: Detects specific SQL settings.
- Network: Detects specific network settings.
- Server cluster: Detects specific server cluster configuration settings.
- System: Detects specific system configuration settings.
- CLR: Detects long garbage collection pauses on managed processes.

> [!NOTE]
> Currently, Windows versions that include the .NET Framework 4.5 or later versions are supported.

### Performance counter trace (**)

Collects the following performance counters:

- \System, \Process, \Processor, \Memory, \Thread, \PhysicalDisk, and \LogicalDisk
- \Cache\Dirty Pages, \Cache\Lazy Write Flushes/sec, \Server\Pool Nonpaged, Failures, and \Server\Pool Paged Failures
- Selected counters under \Network Interface, \IPv4\Datagrams, \IPv6\Datagrams, \TCPv4\Segments, \TCPv6\Segments,  \Network Adapter, \WFPv4\Packets, \WFPv6\Packets, \UDPv4\Datagrams, \UDPv6\Datagrams, \TCPv4\Connection, \TCPv6\Connection, \Network QoS Policy\Packets, \Per Processor Network Interface Card Activity, and \Microsoft Winsock BSP

#### For SQL Server instances

- \SQL Server:Buffer Manager, \SQLServer:Resource Pool Stats, and \SQLServer:SQL Statistics\
- \SQLServer:Locks, \SQLServer:General, Statistics
- \SQLServer:Access Methods

#### For Azure Files

\SMB Client Shares

### Diskspd benchmark trace (***)

Diskspd I/O workload tests (OS Disk [write] and pool drives [read/write])

## Run Performance Diagnostics on your VM using the CLI tool

### What do I have to know before I run the tool?

#### Tool requirements

- This tool must be run on the VM that has the performance issue.

- The following operating systems are supported:
  - Windows Server 2022
  - Windows Server 2019
  - Windows Server 2016
  - Windows Server 2012 R2
  - Windows Server 2012
  - Windows 11
  - Windows 10

#### Accessing SQL Server

If the VM has SQL Server instances installed on it, PerfInsights uses the account NT AUTHORITY\SYSTEM to access the SQL Server instances to collect configuration information and run rules. The account NT AUTHORITY\SYSTEM must be granted View Server State permission and Connect SQL permission for each instance, otherwise PerfInsights won't be able to connect to the SQL Server and the PerfInsights report won't show any SQL Server related information.

#### Possible problems when you run the tool on production VMs

- For the benchmarking scenario or the "Advanced performance analysis" scenario that is configured to use Xperf or Diskspd, the tool might adversely affect the performance of the VM. These scenarios shouldn't be run in a live production environment.

- For the benchmarking scenario or the "Advanced performance analysis" scenario that is configured to use Diskspd, ensure that no other background activity interferes with the I/O workload.

- By default, the tool uses the temporary storage drive to collect data. If tracing stays enabled for a longer time, the amount of data that is collected might be relevant. This can reduce the availability of space on the temporary disk, and can therefore affect any application that relies on this drive.

### How do I run PerfInsights?

You can run PerfInsights on a virtual machine by installing [Azure Performance Diagnostics VM Extension](performance-diagnostics-vm-extension.md). You can also run it as a standalone tool.

**Install and run PerfInsights from the Azure portal**

For more information about this option, see [Install Azure Performance Diagnostics VM Extension](performance-diagnostics-vm-extension.md#install-the-extension).  

**Run PerfInsights in standalone mode**

To run the PerfInsights tool, follow these steps:

1. Download [PerfInsights.zip](https://aka.ms/perfinsightsdownload).

2. Unblock the PerfInsights.zip file. To do this, right-click the PerfInsights.zip file, and select **Properties**. In the **General** tab, select **Unblock**, and then select **OK**. This action ensures that the tool runs without any other security prompts.  

    :::image type="content" source="media/how-to-use-perfInsights/pi-unlock-file.png" alt-text="Screenshot of PerfInsights Properties, with Unblock highlighted.":::

3. Expand the compressed PerfInsights.zip file into your temporary drive (by default, this is usually the D drive).

4. Open Windows command prompt as an administrator, and then run PerfInsights.exe to view the available commandline parameters.

    ```console
    cd <the path of PerfInsights folder>
    PerfInsights
    ```

    :::image type="content" source="media/how-to-use-perfInsights/pi-commandline.png" alt-text="Screenshot of PerfInsights commandline output.":::

    The basic syntax for running PerfInsights scenarios is:

    ```console
    PerfInsights /run <ScenarioName> [AdditionalOptions]
    ```

    Look up all the available scenarios and options by using the **/list** command:

    ```console
    PerfInsights /list
    ```

    These are examples of how to use the CLI tool to run the various [troubleshooting scenarios](#supported-troubleshooting-scenarios):

    - Run the performance analysis scenario for 5 mins:

      ```console
      PerfInsights /run vmslow /d 300 /AcceptDisclaimerAndShareDiagnostics
      ```

    - Run the advanced scenario with Xperf and Performance counter traces for 5 mins:

      ```console
      PerfInsights /run advanced xp /d 300 /AcceptDisclaimerAndShareDiagnostics
      ```

    - Run the benchmark scenario for 5 mins:

      ```console
      PerfInsights /run benchmark /d 300 /AcceptDisclaimerAndShareDiagnostics
      ```

    - Run the performance analysis scenario for 5 mins and upload the result zip file to the storage account:

      ```console
      PerfInsights /run vmslow /d 300 /AcceptDisclaimerAndShareDiagnostics /sa <StorageAccountName> /sk <StorageAccountKey>
      ```


    >[!Note]
    >Before running a scenario, PerfInsights prompts the user to agree to share diagnostic information and to agree to the EULA. Use **/AcceptDisclaimerAndShareDiagnostics** option to skip these prompts.
    >
    >If you have an active support ticket with Microsoft and running PerfInsights per the request of the support engineer you are working with, make sure to provide the support ticket number using the **/sr** option.
    >
    >By default, PerfInsights will try updating itself to the latest version if available. Use **/SkipAutoUpdate** or **/sau** parameter to skip auto update.  
    >
    >If the duration switch **/d** is not specified, PerfInsights will prompt you to repro the issue while running vmslow, azurefiles and advanced scenarios.

When the traces or operations are completed, a new file appears in the same folder as PerfInsights. The name of the file is **PerformanceDiagnostics\_yyyy-MM-dd\_hh-mm-ss-fff.zip.** You can send this file to the support agent for analysis or open the report inside the zip file to review findings and recommendations.

## Review the diagnostics report

Within the **PerformanceDiagnostics\_yyyy-MM-dd\_hh-mm-ss-fff.zip** file, you can find an HTML report that details the findings of PerfInsights. To review the report, expand the **PerformanceDiagnostics\_yyyy-MM-dd\_hh-mm-ss-fff.zip** file, and then open the **PerfInsights Report.html** file.

Select the **Findings** tab.

:::image type="content" source="media/how-to-use-perfInsights/pi-overview-findings-tab.png" alt-text="Screenshot of Findings tab under Overview tab of the PerfInsights Report.":::

:::image type="content" source="media/how-to-use-perfInsights/pi-storage-findings-tab.png" alt-text="Screenshot of Findings tab under Storage tab of the PerfInsights Report.":::

> [!NOTE]
> Findings categorized as high are known issues that might cause performance issues. Findings categorized as medium represent non-optimal configurations that do not necessarily cause performance issues. Findings categorized as low are informative statements only.

Review the recommendations and links for all high and medium findings. Learn about how they can affect performance, and also about best practices for performance-optimized configurations.

### Storage tab

The **Findings** section displays various findings and recommendations related to storage.

The **Disk Map** and **Volume Map** sections describe how logical volumes and physical disks are related to each other.

In the physical disk perspective (Disk Map), the table shows all logical volumes that are running on the disk. In the following example, **PhysicalDrive2** runs two logical volumes created on multiple partitions (J and H):

:::image type="content" source="media/how-to-use-perfInsights/pi-disk-map.png" alt-text="Screenshot of disk map section under Findings tab of the PerfInsights Report.":::

In the volume perspective (Volume Map), the tables show all the physical disks under each logical volume. Notice that for RAID/Dynamic disks, you might run a logical volume on multiple physical disks. In the following example, *C:\\mount* is a mount point configured as *SpannedDisk* on physical disks 2 and 3:

:::image type="content" source="media/how-to-use-perfInsights/pi-volume-map.png" alt-text="Screenshot of volume map section under Findings tab of the PerfInsights Report.":::

### SQL tab

If the target VM hosts any SQL Server instances, you see another tab in the report, named **SQL**:

:::image type="content" source="media/how-to-use-perfInsights/pi-sql-tab.png" alt-text="Screenshot of SQL tab and the sub-tabs under it.":::

This section contains a **Findings** tab, and extra tabs for each of the SQL Server instances hosted on the VM.

The **Findings** tab contains a list of all the SQL related performance issues found, along with the recommendations.

In the following example, **PhysicalDrive0** (running the C drive) is displayed. This is because both the **modeldev** and **modellog** files are located on the C drive, and they are of different types (such as data file and transaction log, respectively).

:::image type="content" source="media/how-to-use-perfInsights/pi-physical-drive-0.png" alt-text="Screenshot of modeldev and modellog files information.":::

The tabs for specific instances of SQL Server contain a general section that displays basic information about the selected instance. The tabs also contain more sections for advanced information, including settings, configurations, and user options.

### Diagnostic tab

The **Diagnostic** tab contains information about top CPU, disk, and memory consumers on the computer during the Performance Diagnostics run. You can also find information about critical patches that the system might be missing, the task list, and important system events.

## References to the external tools used

### Diskspd

Diskspd is a storage load generator and performance test tool from Microsoft. For more information, see [Diskspd](https://github.com/Microsoft/diskspd).

### Xperf

Xperf is a command-line tool to capture traces from the Windows Performance Toolkit. For more information, see [Windows Performance Toolkit – Xperf](/archive/blogs/ntdebugging/windows-performance-toolkit-xperf).

## Next steps

You can upload diagnostics logs and reports to Microsoft Support for further review. Support might request that you transmit the output that is generated by PerfInsights to assist with the troubleshooting process.

The following screenshot shows a message similar to what you might receive:

:::image type="content" source="media/how-to-use-perfInsights/pi-support-email.png" alt-text="Screenshot of sample message from Microsoft Support.":::

Follow the instructions in the message to access the file transfer workspace. For extra security, you have to change your password on first use.

After you sign in, you'll find a dialog box to upload the **PerformanceDiagnostics\_yyyy-MM-dd\_hh-mm-ss-fff.zip** file that was collected by PerfInsights.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
