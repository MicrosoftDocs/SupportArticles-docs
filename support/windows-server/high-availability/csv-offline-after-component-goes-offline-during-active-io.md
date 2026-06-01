---
title: CSV Goes Offline after a Node or Storage Component Goes Offline During Active I/O
description: Discusses a change in Cluster Shared Volume behavior that sends the CSV offline and could cause it to fail.
ms.date: 02/12/2026
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.custom:
- sap:clustering and high availability\cluster shared volume (csv)
- pcy:WinComm Storage High Avail
ms.reviewer: kaushika, v-mikiwu, v-appelgatet
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Windows Server 2025</a>
---
# Cluster Shared Volume goes offline after a node or storage component goes offline

This article discusses a situation in which the Cluster Shared Volume (CSV) of a cluster goes offline after other components go offline. The article includes steps to resolve the issue and, if it's necessary, recover any affected virtual machines (VMs).

## Symptoms

This issue starts under the following circumstances:

1. A cluster node or storage component becomes unavailable, but I/O operations continue. For example, a disk array fails or requires maintenance.
1. As I/O operations continue, metadata records accumulate.
1. When the metadata records reach their allocated limits, I/O operations fail.
1. The associated CSV enters a Failed state.
1. Every 15 minutes (the default setting), the cluster tries to bring the CSV online. If the Virtual Machine Management Service (VMMS) manages VMs on the cluster, VMMS periodically tries to start the VMs.
1. After 30 minutes, VMMS stops trying to start the VMs. Any VMs that use the affected CSV can't automatically recover.

## Cause

A recent change in cluster behavior affects how the CSV responds in the situation that's mentioned in the "Symptoms" section. Previously, when metadata records accumulated to the allocated limits, I/O operations could stop indefinitely. Because of the change, I/O operations fail in this situation instead of hanging. The I/O failure, in turn, causes the CSV to go offline and enter a Failed state.

## Recovery

You can use one of two methods to recover the cluster. The method to use depends on whether you can restore the previous cluster components, or you have to replace parts of the cluster.

### Method 1: Restore the offline component and automatically repair the cluster

After you restore the offline node or storage, the following steps occur automatically.

1. The next time that the cluster automatically tries to bring the CSV online, it succeeds.
1. Automatic repair processes start, and then the volume becomes available.

> [!IMPORTANT]  
> After the cluster recovers, you might have to manually start any VMMS-managed VMs that use the cluster. After the cluster is down for 30 minutes, VMMS stops automatically trying to restart the VMs.

### Method 2: Replace the offline component and manually recover the cluster

If you can't restore the missing node or storage, follow these steps to manually recover the cluster.

> [!IMPORTANT]  
>
> - This procedure temporarily takes all volumes in the pool offline.
> - You can use this procedure for either Storage Spaces or failover clusters. Every step that applies to virtual disks or volumes also applies to Cluster Virtual Disks and Cluster Shared Volumes.

Run the following steps as a cluster administrator on a node that has full access to the storage pool.

1. On a cluster node that has full access to the storage pool, open an administrative PowerShell Command Prompt window.

1. To get the properties of the affected storage pool, run the following command at the PowerShell command prompt:

   ```powershell
   Get-ClusterResource <Pool>  
   ```

   > [!NOTE]  
   >
   > - In this cmdlet, \<Pool> is the name of the storage pool resource.
   > - Later steps in this procedure use properties such as the name and owner group of the resource.

1. To get the properties of the storage pool's virtual disks and CSVs, run the following command:

   ```powershell
   Get-ClusterResource | Where-Object { $_.ResourceType -eq "Physical Disk" }
   ```

   ```powershell
   Get-ClusterSharedVolume
   ```

1. Review the properties to determine which resources are in a "Failed" state.

   > [!NOTE]  
   > If you intend to reuse name and ID information for any resources that you replace, you can use `Get-ClusterResource` and `Get-ClusterParameter` to get that information.

1. Whether you're replacing a node, or just storage, run the following cmdlets to add unpooled disks to the storage pool:

   ```powershell
   Get-StoragePool -isprimordial $false | Add-PhysicalDisk -PhysicalDisks $(Get-PhysicalDisk -CanPool $true)
   ```

1. To retire unhealthy disks (or disks that are associated with a failed node), run the following cmdlets:

   ```powershell
   Get-PhysicalDisk | Where-Object { $_.OperationalStatus -eq "Lost Communication" } | Set-PhysicalDisk -usage Retired
   ```

1. Monitor the virtual disks by running `Get-VirtualDisk` and looking for `OperationalStatus = InService` in the cmdlet output. When the `OperationalStatus` parameter is clear for all the virtual disks, go to the next step.

1. To move the affected storage pool (that you identified previously) to the current node, run a PowerShell cmdlet that resembles the following command:

   ```powershell
   Move-ClusterResource -node <Current Node> -name <OwnerGroup>
   ```

   > [!NOTE]  
   > In this command, \<Current Node> is the name of the node that you're working from, and \<OwnerGroup> is the value of the OwnerGroup property of the storage group resource.

1. To move the failed disk and CSV resources to the current node, run `Move-ClusterResource` again for each physical disk and CSV resource. To see the OwnerGroup value of the CSV, run `Get-ClusterSharedVolume | get-ClusterGroup`.

1. To remove all cluster virtual disks and CSVs from cluster management, run the following PowerShell commands in sequence:

   ```powershell
   Remove-ClusterSharedVolume
   Get-ClusterResource | Where-Object { $_.ResourceType -eq "Physical Disk" } | Remove-ClusterResource
   ```

1. To remove the storage pool from cluster management, run the `Remove-ClusterResource` command for the storage pool objects that you identified in step 2 of this procedure.

1. To make the storage pool writable, run the following commands:

   ```powershell
   Get-StoragePool -isPrimordial $false | Set-StoragePool -IsReadOnly $false
   ```

1. To configure the virtual disks, run the following commands for each virtual disk that you identified in step 3 of this procedure.

   ```powershell
   Get-VirtualDisk | Set-VirtualDisk -IsManualAttach $false
   ```

1. Use the `Get-StorageJob` cmdlet to monitor the storage jobs that are related to repair. After the jobs start (the percentage completed is greater than 0), go to the next step.

1. To restore the storage pool to cluster management, run the following commands:

   ```powershell
   Get-CimInstance -Namespace "root\MSCluster" -ClassName "MSCluster_AvailableStoragePool" | invoke-cimmethod -MethodName AddToCluster
   ```

1. Restore all non-failed virtual disks to cluster management. If any of the virtual disks from the previous step were configured as CSVs before the failure, convert them to CSVs.

   For example, you can bring back any of the virtual disk or CSV resources that weren't in a failed state. To restore these resources, use the `virtualdiskid` and `name` property values from step 3, and then run commands that resemble the following script excerpt:

   ```powershell
   `$virtualdiskname = "ClusterPerformanceHistory"`
   `$virtualdiskid = "603bb5d0-9c4d-4fc6-9c25-eec92a478733"`
   `(get-clusteravailabledisk  | Where-Object { $_.Id -eq $virtualdiskid} | add-clusterdisk).Name = $virtualdiskname`
   ```

   You can use `Add-ClusterSharedVolume` to reconfigure the CSVs.

1. Monitor the virtual disks by running `Get-VirtualDisk` and looking for `OperationalStatus = InService` in the cmdlet output. When the `OperationalStatus` parameter is clear for all of the virtual disks, continue to the next step.

1. To bring the virtual disks online and configure them as read/write, run the following commands:

   ```powershell
   Get-VirtualDisk | get-disk | Where-Object { $_.IsReadonly -eq $true } | set-disk -IsReadOnly $false
   Get-VirtualDisk | get-disk | Where-Object { $_.IsOffline -eq $true} | set-disk -IsOffline $false
   ```

1. Monitor the virtual disk footprints of the retired physical disks by running the following cmdlet:

   ```powershell
    get-physicaldisk -Usage Retired | ft Deviceid, Usage, VirtualDiskFootprint 
   ```

   When the footprint reaches zero, go to the next step.

1. Restore the previously failed virtual disks to cluster management. If any of these virtual disks were previously configured as CSVs, convert them to CSVs.

1. Bring the virtual disks from the previous step online, and configure them as read/write.

> [!IMPORTANT]  
> After the cluster recovers, you might have to manually start any VMMS-managed VMs that use the cluster. After the cluster is down for 30 minutes, VMMS stops automatically trying to restart the VMs.

## Status

This behavior is by design in Windows Server 2025. It's intended to prevent indefinite I/O unresponsiveness.
