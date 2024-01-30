---
title: Can't bring a physical disk online in a cluster
description: Provides guidance for when a physical disk fails to come online in a Windows-based failover cluster
ms.date: 04/21/2022
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:cannot-bring-a-resource-online, csstroubleshoot
ms.subservice: high-availability
---
# Can't bring a physical disk online in a failover cluster

## Troubleshooting checklist

1. Review the system and the cluster log to find the exact errors or warnings that prevent the physical disk from coming online.

2. Set the cluster log to a detail level of 5 to have verbose information from the online attempt:

   `Set-ClusterLog -Level 5`

3. Capture a performance monitor log or a Storport trace to check for poor disk performance, which might delay the online process.

4. Cluster validation is useful in this scenario also. You can create a new cluster disk from the same SAN and point the cluster validation to that disk.

5. If the cluster Resource Hosting Subsystem (Rhs.exe) process crashes during the failed online attempt, then you need to configure the server to generate a full memory dump and set the following registry keys:

   - For Windows Server 2012:

     `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Failover Clusters\DebugBreakOnDeadlock to DWORD 3.`

   - For Windows Server 2012 R2:

     `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClusSvc\Parameters\DebugBreakOnDeadlock to DWORD 3.`

   > [!NOTE]
   > After the registry key is configured, the server on which the RHS deadlock occurs displays a blue screen and generates a stop 0x9E memory dump. You can then analyze it and address the cause.

### Possible solutions

- If disks read or write response times are slow (slow disk performance), contact the storage vendor.

- If the antivirus interferes with the online attempt, uninstall and reboot the server to remove the filter drivers.

- HBA or RAID controller drivers need to be updated.

- Permissions on the root disks are missing.

- If there are persistent reservation issues, the recommendation is to contact the storage vendor to diagnose the issues.

   Alternatively, you can run the `Clear-ClusterDiskReservation -Disk <Number>` cmdlet to clear the persistent reservation.

   > [!NOTE]
   > The placeholder \<Number> represents the disk number.

## Common issues and solutions

### Event ID 1035

> While disk resource '%1' was being brought online, access to one or more volumes failed with error '%2'.
>
> In a failover cluster, most clustered services or applications use at least one disk, also called a disk resource, that you assign when you configure the clustered service or application. Clients can use the clustered service or application only when the disk is functioning correctly.

#### Review the logs to find more information about the issue

1. Use Event Viewer to review the application and system logs.

   > [!NOTE]
   > In particular, search for any events related to domain controller functionality.

2. To search for information about an error code, use one of the following methods:

   - See [system error codes](/windows/win32/debug/system-error-codes).

   - At a command prompt, run the following command:

     ```console
     NET HELPMSG <Code>
     ```

     > [!NOTE]
     > The placeholder \<Code> represents the error code.

3. Generate a fresh cluster log and review it. To generate a fresh cluster log, reproduce the issue and open an elevated PowerShell prompt. At the elevated PowerShell prompt, run the following cmdlet:

   `Get-ClusterLog -Destination C:\temp\ -TimeSpan 5 -UseLocalTime`

If you identify an issue that you can fix, fix it and try to bring the cluster resource online again before you proceed.

> [!NOTE]
> If you change the storage configuration, we recommend that you use the Validate a Configuration wizard to validate the storage configuration.

### Event ID 1183

> Cluster disk resource '%1' contains an invalid mount point.
>
> In a failover cluster, most clustered services or applications use at least one disk, also called a disk resource, that you assign when you configure the clustered service or application. Clients can use the clustered service or application only when the disk is functioning correctly.

#### Check the disk configuration

Confirm that the mounted disk is configured according to the following guidelines:

- Clustered disks can only be mounted onto clustered disks (not local disks).

- The mounted disk and the disk it's mounted onto must be part of the same clustered service or application. The disks can't be in two different clustered services or applications, and they can't be in the general pool of available storage in the cluster.

For more information, see [Use Cluster Shared Volumes in a failover cluster](/windows-server/failover-clustering/failover-cluster-csvs).

#### Generate a fresh cluster log that records the issue

To generate a fresh cluster log, reproduce the issue and open an elevated PowerShell prompt. At the elevated PowerShell prompt, run the following cmdlet:

`Get-ClusterLog -Destination C:\temp\ -TimeSpan 5 -UseLocalTime`

If you identify an issue that you can fix, fix it and try to bring the resource online again before you proceed.

### Event ID 5394

> The Cluster service encountered some storage errors while trying to bring storage pool online.

#### Check the status of the disks

1. In **Disk Management** (available on the **Storage** menu in Server Manager), make sure that the disks are healthy and connected.

2. In **Computer Management** (available on the **Tools** menu in Server Manager), select **Device Manager** and make sure that the disks are online with the latest drivers and firmware installed.

#### Use the Validate a Configuration wizard to review the storage configuration

> [!IMPORTANT]
> Be aware that the clustered service or application remains offline for the duration of the storage validation testing.

1. In the **Failover Cluster Manager** snap-in, select **Failover Cluster Management** > **Management** > **Validate a Configuration**.

2. Follow the instructions in the wizard to specify the cluster you want to test.

3. On the **Testing Options** page, select **Run only tests I select**.

4. On the **Test Selection** page, clear all check boxes except those for the **Storage and Inventory** tests that appear to be relevant to your situation.

5. Follow the instructions in the wizard to run the tests.

6. On the **Summary** page, select **View Report**.
