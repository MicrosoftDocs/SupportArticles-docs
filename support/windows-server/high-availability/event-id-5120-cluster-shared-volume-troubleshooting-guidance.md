---
title: Event ID 5120 Cluster Shared Volume troubleshooting guidance
description: Provides guidance for finding the root cause of Event 5120 Cluster Shared Volume.
ms.date: 12/26/2023
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.custom: sap:Clustering and High Availability\Cluster Shared Volume (CSV), csstroubleshoot
localization_priority: medium
ms.reviewer: kaushika
---
# Event ID 5120 Cluster Shared Volume troubleshooting guidance

<p class="alert is-flex is-primary"><span class="has-padding-left-medium has-padding-top-extra-small"><a class="button is-primary" href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=32636509" target='_blank'><b>Try our Virtual Agent</b></a></span><span class="has-padding-small"> - It can help you quickly identify and fix common Active Directory replication issues</span>

This guidance is designed to help troubleshoot status codes related to Event ID 5120 Cluster Shared Volume.

## Troubleshooting checklist

Event ID 5120 indicates that there has been an interruption to communication between a cluster node and a volume in Cluster Shared Volumes (CSV). This interruption may be short enough that it isn't noticeable or long enough that it interferes with services and applications using the volume. If the interruption persists, review other events in the System or Application event logs for information about communication between the node and the volume.

1. Verify that the Cluster Shared Volume can come online. To confirm that a Cluster Shared Volume can come online:

    1. To open the failover cluster snap-in, select **Start** > **Administrative Tools** > **Failover Cluster Manager**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then select **Yes**.
    2. In the **Failover Cluster Manager** snap-in, check whether the cluster you want to manage is displayed. If it isn't displayed, then in the console tree, right-click **Failover Cluster Manager**, select **Manage a Cluster**, and then select or specify the cluster you want.
    3. If the console tree is collapsed, expand the tree under the cluster you want to manage, and then select **Cluster Shared Volumes**.
    4. In the center pane, expand the listing for the volume you're verifying and view the status of the volume.
    5. If a volume is offline, bring it online by right-clicking the volume and then selecting **Bring this resource online**.

2. Use a Windows PowerShell cmdlet to check the status of a resource in a failover cluster:

    1. On a node in the cluster, select **Start**, point to **Administrative Tools**, and then select **Windows PowerShell Modules**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then select **Yes**. Run the following cmdlet:

        ```powershell
        Get-ClusterSharedVolume
        ```

    2. If you run the preceding cmdlet without specifying a resource name, the status is displayed for all Cluster Shared Volumes in the cluster.

3. If you see a few random Events ID 5120 with an error of STATUS_CLUSTER_CSV_AUTO_PAUSE_ERROR or error code c0130021, they can be safely ignored. We recognize it isn't optimal as they create false positive alarms and trigger alerts in management software.

4. If you see Event ID 5120 is logged with error codes other than STATUS_CLUSTER_CSV_AUTO_PAUSE_ERROR, it's a sign of a problem. Make sure to review the error code in the description of each Event ID 5120 logged. Be careful not to dismiss the event because of a single event with STATUS_CLUSTER_CSV_AUTO_PAUSE_ERROR. If you see other errors logged, there are fixes available that need to be applied.

## Common issues and solutions

If you see Event ID 5120, the **Description** field of the event includes a status message that indicates the cause of the event. The following list consists of 20 status messages:

### Status code: STATUS_BAD_IMPERSONATION_LEVEL(0xC00000A5)

Certain operations, such as renaming that you perform on files or folders on a Cluster Shared Volume, may fail with the error "STATUS_BAD_IMPERSONATION_LEVEL (0xC00000A5)". This issue occurs when you perform the operation on a CSV owner node by using the context of a process that doesn't have administrator permissions.  

To work around this issue, do one of the following operations:

1. Perform the operation by using the context of a process that has administrator permissions.
2. Perform the operation by using a node that doesn't have CSV ownership.

Microsoft is working on a resolution and will provide an update in an upcoming release, as described in [February 12, 2019—KB4487020 (OS Build 15063.1631)](https://support.microsoft.com/help/4487020/windows-10-update-kb4487020).

### Status code: STATUS_BAD_NETWORK_NAME(c00000cc)

1. Check your system event log for events that indicate network connectivity problems, host bus adapter (HBA) problems, or disk problems.
2. Make sure that the affected system has the latest versions of network and storage drivers and firmware installed. Additionally, make sure that Microsoft updates and hotfixes are up to date.

### Status code: STATUS_BAD_NETWORK_PATH(c00000be)

Check the storage configuration and multipath I/O (MPIO) settings. You can enable MPIO path verification on all cluster nodes by using the PowerShell cmdlet `Set-MPIOSetting`. Follow these steps on each cluster node:

1. Open a PowerShell Command Prompt window.
2. Run the following cmdlets:
  
    ```powershell
    Set-MPIOSetting -NewPathVerificationState Enabled
    Set-MPIOSetting -NewPathVerificationPeriod <integer>
    ```
  
    > [!NOTE]
    > In this cmdlet, `<integer>` is the length of time for the server to verify every path (in seconds). The default is 30 seconds.

### Status code: STATUS_CLUSTER_CSV_AUTO_PAUSE_ERROR(c0130021)

Make sure that the affected system has the latest versions of network and storage drivers and firmware installed. Additionally, make sure that Microsoft updates and hotfixes are up to date.

In particular, make sure that the following update is installed on all Windows Server 2012 R2 and earlier servers.

[Update is available that improves the resiliency of the cloud service provider in Windows: December 2013 (KB2878635)](https://support.microsoft.com/help/2878635/update-is-available-that-improves-the-resiliency-of-the-cloud-service)

> [!NOTE]
> In Windows Server 2016 and later versions, the name of this status code is STATUS_CLUSTER_CSV_NO_SNAPSHOTS.

### Status code: STATUS_CONNECTION_DISCONNECTED(c000020c)

Communication between a cluster node and a CSV has been interrupted. This interruption may be short enough that it isn't noticeable or long enough that it interferes with services and applications that use the volume. If the interruption persists, review other events in the System or Application event logs for information about communication between the node and the volume.

In addition, confirm that the CSV can come online by using the following steps:

> [!NOTE]
> To perform the following procedures, the account you use has to be a domain account and has to belong to the local Administrators group on each clustered server, or it has to have the equivalent authority.

1. Select **Start** > **Administrative tools** > **Failover Cluster Manager**.  
2. In the **Failover Cluster Manager** snap-in, check whether the cluster you want to manage is displayed. If it isn't displayed, then in the console tree, right-click **Failover Cluster Manager**, select **Manage a Cluster**, and then select or specify the cluster you want.
3. In the center pane, expand the listing for the volume you're verifying. View the status of the volume.
4. If a volume is offline, bring it online by right-clicking the volume and then selecting **Bring this resource online**.

To use a PowerShell cmdlet to check the status of a resource in a failover cluster, open a PowerShell Command Prompt window on a node in the cluster, and run `Get-ClusterSharedVolume`.

> [!NOTE]
> If you run the preceding cmdlet without specifying a resource name, the status is displayed for all CSVs in the cluster.

For more information, see [Event ID 5120 — Cluster Shared Volume Functionality](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee830293(v=ws.10)).

### Status code: STATUS_CONNECTION_RESET(c000020d)

1. Check your system event log for events that indicate network connectivity problems, host bus adapter (HBA) problems, or disk problems.
2. Make sure that the affected system has the latest versions of network and storage drivers and firmware installed. Additionally, make sure that Microsoft updates and hotfixes are up to date.
3. Check the exclusions that are configured for your antivirus solution.

### Status code: STATUS_DEVICE_BUSY(80000011)

1. Check the status of the storage resources. This message might indicate that the persistent reservation of the volume has been lost.
2. Make sure that the affected system has the latest versions of network and storage drivers and firmware installed. Additionally, make sure that Microsoft updates and hotfixes are up to date.

### Status code: STATUS_DEVICE_NOT_CONNECTED(c000009d)

This status code indicates that connectivity between the cluster nodes and the storage has been lost.

1. Check your system event log for events that indicate network connectivity problems, host bus adapter (HBA) problems, or disk problems.  
2. Make sure that the affected system has the latest versions of network and storage drivers and firmware installed. Additionally, make sure that Microsoft updates and hotfixes are up to date.

### Status code: STATUS_FILE_CLOSED(c0000128)

1. Check network connectivity. Check the event logs for other events that are related to connectivity, such as Event ID 1135. Additionally, check the status of workloads that generate heavy network traffic (such as backups).
2. Make sure that the affected system has the latest versions of network and storage drivers and firmware installed. Additionally, make sure that Microsoft updates and hotfixes are up to date.

### Status code: STATUS_FILE_NOT_AVAILABLE(c0000467)

1. Check the health status of Smart Array. Make sure that related drivers and firmware are up to date.
2. Make sure that the affected system has the latest versions of network and storage drivers and firmware installed. Additionally, make sure that Microsoft updates and hotfixes are up to date.

### Status code: STATUS_INSUFFICIENT_RESOURCES(c000009a)

Make sure that the affected system has the latest versions of network and storage drivers and firmware installed. Additionally, make sure that Microsoft updates and hotfixes are up to date.

### Status code: STATUS_IO_TIMEOUT(c00000b5)

This status code indicates that a redirected file system IO operation took longer than the time allowed. The timeout is two minutes for synchronous operations and four minutes for asynchronous operations.

The cause of the timeout varies. It might indicate a software, configuration, or hardware problem.  

1. Check your system event log for events that indicate network connectivity problems, host bus adapter (HBA) problems, or disk problems.
2. Make sure that the affected system has the latest versions of network and storage drivers and firmware installed. Additionally, make sure that Microsoft updates and hotfixes are up to date.  In particular, make sure that [October 18, 2018—KB4462928 (OS Build 14393.2580)](https://support.microsoft.com/help/4462928/windows-10-update-kb4462928) is installed. This update addresses an issue that occurs when restarting a node after draining the node. Event ID 5120 appears in the log with a "STATUS_IO_TIMEOUT c00000b5" message. This may slow or stop input and output (I/O) to the VMs, and sometimes the nodes may drop out of cluster membership.

### Status code: STATUS_MEDIA_WRITE_PROTECTED(c00000a2)

This status code indicates that there's a connectivity issue. Make sure that the Server Message Block (SMB) protocol is enabled.

### Status code: STATUS_NETWORK_UNREACHABLE(c000023c)

This status code indicates that either there is a network fault between the node and the CSV or Disk Control Manager (DCM) has mapped an incorrect path to the volume.

Make sure that the affected system has the latest versions of network and storage drivers and firmware installed. Additionally, make sure that Microsoft updates and hotfixes are up to date.

### Status code: STATUS_NO_MEDIA_IN_DEVICE(c0000013)

This status code indicates a problem in the storage system. Check the health status of the storage system.

### Status code: STATUS_NO_SUCH_DEVICE(c000000e)

This code indicates that connectivity between a node and the CSV has been lost.

1. Check the network connectivity and the cluster exclusion in the firewall.
2. Make sure that the affected system has the latest versions of network and storage drivers and firmware installed. Additionally, make sure that Microsoft updates and hotfixes are up to date.

### Status code: STATUS_UNEXPECTED_NETWORK_ERROR(c00000c4)

Make sure that the affected system has the latest versions of network and storage drivers and firmware installed. Additionally, make sure that Microsoft updates and hotfixes are up to date.

### Status code: STATUS_UNSUCCESSFUL(c0000001)

1. Check the connectivity between the nodes and the CSV.
2. Make sure that the affected system has the latest versions of network and storage drivers and firmware installed. Additionally, make sure that Microsoft updates and hotfixes are up to date.

### Status code: STATUS_USER_SESSION_DELETED(c0000203)

Make sure that the affected system has the latest versions of network and storage drivers and firmware installed. Additionally, make sure that Microsoft updates and hotfixes are up to date.

In particular, make sure that [October 18, 2018—KB4462928 (OS Build 14393.2580)](https://support.microsoft.com/help/4462928/windows-10-update-kb4462928) is installed. This update addresses a problem that generates this status code in the case of multiple Windows Server 2016 Hyper-V clusters.

### Status code: STATUS_VOLUME_DISMOUNTED(c000026e)

1. Check your system event log for events that indicate storage problems, network connectivity problems, host bus adapter (HBA) problems, or disk problems.
2. Make sure that the affected system has the latest versions of network and storage drivers and firmware installed. Additionally, make sure that Microsoft updates and hotfixes are up to date.


## Data collection

Before contacting Microsoft Support, you can gather information about your issue.

Refer the [prerequisites](../../windows-client/windows-troubleshooters/introduction-to-troubleshootingscript-toolset-tss.md#prerequisites) for the toolset to run properly.

### Gather key information before you contact Microsoft Support

Use the Windows live dump feature to save a snapshot of kernel memory on the affected computer. To do this, follow these steps:

1. Check the live dump folder (*C:\\Windows\\LiveKernelReports\\*) for previous live dump files.
2. Make sure that the live dump feature has been enabled. For more information on enabling the feature, see [Troubleshooting Hangs Using Live Dump](https://techcommunity.microsoft.com/t5/failover-clustering/troubleshooting-hangs-using-live-dump/ba-p/372080).
3. Download [TSS](https://aka.ms/getTSS) and unzip it in the *C:\\tss* folder.
4. Open an elevated version of PowerShell and change the directory to the *C:\\tss* folder.
5. Run the SDP tool to collect the logs from the source and destination nodes.
6. Unzip the file and run the following cmdlet on both nodes:

    ```powershell
    TSS.ps1 -SDP Cluster -SkipSDPList skipHang,skipBPA,skipSDDC
    ```
7. Collect all logs. Zip and attach the live dump files to your support request.

