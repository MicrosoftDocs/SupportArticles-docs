---
title: Disk <number> has been surprise removed (event ID 157)
description: Learn how to troubleshoot event ID 157, in which a disk has been surprise removed from an Azure virtual machine (VM) that runs Windows.
author: kegregoi
ms.author: kegregoi
ms.reviewer: cssakscic, ruedward, clfuseli, scotro, v-leedennis
ms.date: 06/19/2024
ms.service: virtual-machines
ms.collection: windows
ms.topic: troubleshooting-general
ms.custom: sap:VM Admin - Windows (Guest OS)
---
# "Disk \<number> has been surprise removed" (event ID 157)

This article discusses how to troubleshoot event ID 157, a scenario in which a data disk disappeared, was lost, or was removed from the Windows guest operating system (OS) of a Microsoft Azure virtual machine (VM).

## Symptoms

You might discover that a disk removal occurred if you experience any of the following symptoms:

- Disks appear to be attached in the Azure portal even though the guest OS reports the disks as removed from the VM.

- Disks within SQL cluster environments and Azure VMs are unexpectedly removed, causing disruptions in workloads.

- Microsoft SQL Server-based servers and data become compromised because of these unexpected disk removals.

- Excessive workload, misconfigured registry settings, and low memory are identified as potential triggers for event ID 157.

If you experience these symptoms, open the **Event Viewer** app on the Windows VM to investigate. Select the **Event Viewer (Local)** > **Windows Logs** > **System** node in the **Console Tree** pane. In the event list, select the **Event ID** column label to sort by event ID, and then search for and double-click the log entry that has an **Event ID** value of **157**. The **General** tab of the **Event Properties** dialog box displays information that resembles the following table.

| Event field     | Value                                         |
|-----------------|-----------------------------------------------|
| Log Name        | System                                        |
| Source          | disk                                          |
| Logged (Date)   | \<timestamp>                                  |
| **Event ID**    | **157**                                       |
| Task Category   | None                                          |
| Level           | Warning                                       |
| Keywords        | Classic                                       |
| User            | N/A                                           |
| Computer        | SERVER-\<hash-value>.domain1.priv             |
| **Description** | **Disk \<number> has been surprise removed.** |

## Cause

The disk disappearance most often occurs when something disrupts communication between the system and the disk, such as a storage area network (SAN) fabric error or a Small Computer System Interface (SCSI) bus problem. Alternatively, you might experience a disk disappearance if a disk fails or you unplug a disk while the OS is running.

Event ID 157 occurs within the guest OS (or while operating a Windows Failover Clustering role). This usually occurs because of the following underlying factors:

- Excessive I/O workload causes throttling and I/O delays. These problems, in turn, cause the disk to reach the I/O time-out threshold.

- The **HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\disk** registry subkey is misconfigured. Specifically, the **IoTimeoutValue** registry entry within that subkey is set to a value that's too small, such as 60 seconds.

  > [!NOTE]
  > If the time-out value is too small, increase this value, but don't use a value that's more than 179 seconds. After a delay of 180 seconds, the system invokes event ID 17 within the host node and triggers the VM to restart.

- You ran a cluster validation inside the guest OS to check local storage on the cluster node. (That is, an intentional operation caused event ID 157.)

- A low memory condition exists within the VM.

## Solution

The guidance for fixing the disk disappearance issue differs depending on whether your disks are in a cluster environment or a non-cluster environment.

### [Cluster environment](#tab/cluster)

- Run the [PerfInsights](./how-to-use-perfInsights.md) self-help diagnostics tool.

- If you're operating in a Windows Failover Clustering role, collect the Windows cluster logs for the affected time period. If PerfInsights didn't collect these logs, run the [Get-ClusterLog](/powershell/module/failoverclusters/get-clusterlog) cmdlet in PowerShell.

- Get the registry setting for disk time-out by inspecting the PerfInsights report.

- Check for a misconfigured registry setting on the guest OS. If there's also excessive I/O throttling, this scenario might explain why the time-out threshold is being reached.

- Upgrade from Standard HDD (hard disk drive) to a different [Azure-managed disk type](/azure/virtual-machines/disks-types). We recommend that you don't run a cluster role that uses standard storage HDDs because they can cause issues such as disk disappearance.

### [Non-cluster environment](#tab/non-cluster)

- In the [Azure portal](https://portal.azure.com), check the status of attached disks. Make sure that the disks are all in a healthy state.

- If necessary, detach and then reattach the disk to determine whether the disk disappearance problem is resolved.

- Inspect VM performance metrics in Azure Monitor. Check for any unusual disk I/O patterns, latency, or throttling.

- Check for any maintenance events or issues that occurred in the region in which your VM is hosted.

- Check the disk configuration and performance. Make sure that the disk configuration matches the workload requirements. (For example, select the Premium SSD (solid-state drive) as your type of Azure managed disk for high I/O operations.) Verify disk performance metrics by using tools such as PerfInsights within the VM.

- Run diagnostics by enabling and configuring the [Azure Diagnostics extension](/azure/azure-monitor/agents/diagnostics-extension-overview) on the VM. Collect logs and performance metrics for further analysis.

- Check for disk corruption. Look for file system integrity issues by running the [chkdsk](/windows-server/administration/windows-commands/chkdsk?tabs=event-viewer) command or by running the [sfc](/windows-server/administration/windows-commands/sfc) command together with the `/scannow` parameter.

---

## Related content

- [Event ID 157 "Disk # has been surprise removed"](/archive/blogs/ntdebugging/event-id-157-disk-has-been-surprise-removed)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
