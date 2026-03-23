---
title: Guidance for troubleshooting high-availability virtual machines
description: Helps you troubleshoot issues that affect high-availability (HA) virtual machines (VMs) in a Windows Server failover cluster environment.
ms.date: 03/23/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jeffhughes, v-appelgatet
ms.custom:
- sap: virtualization and hyper-v\high availability virtual machines
- pcy: Virtualization\high availability virtual machines
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# High availability virtual machine troubleshooting guidance

## Summary

This article helps you troubleshoot issues that affect high-availability (HA) virtual machines (VMs) in a Windows Server failover cluster environment. Use this guidance if you experience issues such as VMs that don't migrate, cluster resources that become unresponsive, or storage and communication errors that affect VM availability.

The article is organized into the following sections:

- Troubleshooting checklist: Guidance to help you isolate the issue and fix the most common underlying issues before you begin deeper investigation.
- Common issues and solutions: Targeted guidance for specific symptoms, including migration failures, stuck VMs, quorum issues, storage errors, and configuration issues.
- Data collection: Instructions for gathering diagnostic data if you have to contact Microsoft Support.

Before you begin, make sure that you have administrative access to the cluster resources, Hyper-V hosts, and management tools such as Failover Cluster Manager and Hyper-V Manager.

## Troubleshooting checklist

Before you start to troubleshoot the issue, follow this checklist to help isolate the cause. The steps in this checklist might also help you fix the most common underlying issues.

### Step 1: Gather information and review the symptoms

- **Gather and review log data**. Review log entries for relevant events or messages that occurred near the time of your issue. As a starting point, review the following information:

  - System and Administration event log
  - Hyper-V event log (in Event Viewer, go to **Applications and Services Logs** > **Microsoft** > **Windows** > **Hyper-V**)
  - Any process dump files that you collected
  - Any network trace data that you collected
  - Cluster logs from all nodes  
    To collect logs, run the following command on one of the cluster nodes:

    ```powershell
    Get-ClusterLog -UseLocalTime -Destination <FolderPath>
    ```

- **Check the change and maintenance history**. Check for any recent changes or operational events, including the following events:

  - Operating system updates
  - Driver or firmware changes
  - Configuration changes
  - Third-party software installations or updates
  - Scheduled maintenance
  - Cluster failover tasks
  - Storage migrations that affect VMs

- **Check host and VM versions:** Make sure that the following components are up to date, and that the versions are compatible with one another:

  - Operating system of the Hyper-V host
  - VM configuration
  - Integration services

### Step 2: Check the health of the cluster and the underlying infrastructure

- To check the health of the failover clusters and cluster resources, use Failover Cluster Manager:

  - Identify any error messages in Failover Cluster Manager.
  - Identify which nodes are online and which, if any, are offline.
  - Identify any cluster resources that are stuck in Locked, Paused, or Not responding states.
  - Check the status of the CSV.
  - Make sure that the nodes can connect to the shared storage.

- To check the health of the storage subsystem, run `chkdsk` in scan mode. Open a Windows Command Prompt window as an administrator, and then run the following command:

  ```console
  chkdsk /scan
  ```

  If `chkdsk` identifies issues, see [Data corruption and disk errors troubleshooting guidance](../backup-and-storage/troubleshoot-data-corruption-and-disk-errors.md).

- Review the node network connections. Make sure that the following configurations are consistent on all nodes:
  - IP addresses
  - Network adapters
  - Teaming

  For more information, see [Network recommendations for Hyper-V in a failover cluster](/windows-server/virtualization/hyper-v/failover-cluster-network-recommendations).

  > [!IMPORTANT]  
  > [Network recommendations for Hyper-V in a failover cluster](/windows-server/virtualization/hyper-v/failover-cluster-network-recommendations) mentions load balancing and failover (LBFO) NIC Teaming. However, this technology is deprecated in favor of [Switch-Embedded Teaming (SET)](/azure/azure-local/concepts/host-network-requirements#switch-embedded-teaming-set). Whenever possible, use SET instead of NIC Teaming.

- Make sure that any network device drivers support clustering, and that they're up to date.

### Step 3: Check resource availability

For both the Hyper-V hosts and the guest VMs, use Task Manager and Performance Monitor (PerfMon) or other monitoring tools to assess the resource loads in the physical memory, CPU, storage, and network resource categories. Make sure that resources are consistently available. For more information about resource usage and Hyper-V, see [Performance Tuning Hyper-V Servers](/windows-server/administration/performance-tuning/role/hyper-v-server/).

### Step 4: Check the cluster node configurations

Make sure that each cluster node has the same hardware and configuration, including the following components:

- BIOS and firmware
- Windows Server version and edition
- CPU and memory

### Step 5: Check the VM settings

1. Make sure that the VMs are configured correctly to run on the cluster. For example, you can run the following command in a Windows PowerShell window on a cluster node:

   ```powershell
   Get-ClusterResource | Where-Object { $_.ResourceType -eq "Virtual Machine" }
   ```

   For more information about how to configure VMs for replication in different types of topologies, see [Replicate a virtual machine](/windows-server/virtualization/hyper-v/replication-virtual-machines?tabs=hyper-v-manager#replicate-a-virtual-machine).

1. Check the locations of the VM configuration files (.vmcx) and disk files (.vhd or .vhdx).

   - Make sure that the files reside on the shared storage that the cluster nodes use.
   - Make sure that your VM management client (such as Hyper-V Manager) uses the correct paths for these files.

1. Check the VMs for checkpoints (also known as snapshots). Consider merging any existing checkpoints. If any checkpoints don't merge, see [Hyper-V snapshots, checkpoints, and differencing disks (AVHDX) troubleshooting guidance](hyper-v-snapshots-checkpoints-differencing-disks.md).

1. Make sure that the VM configurations are up to date, and that all host nodes support the VM configuration version.

## Common issues and solutions

- [VMs don't  migrate](#vms-dont-migrate)
- [VM or host becomes "stuck" and unresponsive](#vm-or-host-becomes-stuck-and-unresponsive)
- [Cluster database or quorum issues](#cluster-database-or-quorum-issues)
- [Storage alerts, errors, or timeouts](#storage-alerts-errors-or-timeouts)
- [Communication issues between cluster resources](#communication-issues-between-cluster-resources)
- [VMs missing, not starting, or generating configuration error messages](#vms-missing-not-starting-or-generating-configuration-error-messages)

### VMs don't migrate

The most common reasons that VMs can't migrate from one cluster node to another involve differences in the node configurations, and VM configurations that aren't supported in the same manner on all nodes. The following list links to detailed descriptions and resolution steps for specific symptoms:

- Event ID 21502. This event typically has an error code that indicates the kind of issue that occurred. The following list includes these error codes, and a few other messages that this event might contain:

  - [`0x000013AB`](troubleshoot-live-migration-issues.md#failed-to-get-the-network-address-for-the-destination-node-host2-a-cluster-network-isnt-available-for-this-operation-0x000013ab)
  - [`0x80042001` and `0x8007000D`](troubleshoot-live-migration-issues.md#failed-live-migration-of-virtual-machine-vm1-at-migration-source-clu8n1-with-error-codes-80042001-and-8007000d)
  - [`0x80048054`](troubleshoot-live-migration-issues.md#fail-to-live-migrate-because-virtual-machine-migration-operation-for-vm01-failed-at-migration-source-node3)
  - [`0x8007000E`](troubleshoot-live-migration-issues.md#live-migration-failed-because-vm1-couldnt-initialize-memory-ran-out-of-memory-0x8007000e)
  - [`0x80070569`](troubleshoot-live-migration-issues.md#failed-to-create-planned-virtual-machine-at-migration-destination-logon-failure)
  - [`0x800705AA`](troubleshoot-live-migration-issues.md#failed-to-create-partition-insufficient-system-resources-exist-to-complete-the-requested-service-0x800705aa)
  - [`0x800705B4`](troubleshoot-live-migration-issues.md#failed-to-live-migrate-virtual-machine-vm1-at-migration-source-node1-with-error-code-0x800705b4)
  - [`0x80071398`](troubleshoot-live-migration-issues.md#live-migration-failed-because-the-action-move-didnt-complete-error-code-0x80071398)
  - [`0x8007271D`](troubleshoot-live-migration-issues.md#live-migration-failed-with-error-code-0x8007271d)
  - [`0x80072746`, `0x8007274C`, and `0x8007274D`](troubleshoot-live-migration-issues.md#live-migration-failed-because-test-failed-at-migration-source-host3)
  - [`0x8007274C`](troubleshoot-live-migration-issues.md#failed-to-establish-a-connection-for-a-virtual-machine-migration-with-host-host3-a-connection-attempt-failed)
  - [`0x8009030D`](troubleshoot-live-migration-issues.md#failed-to-establish-a-connection-with-host-destination-server-the-credentials-supplied-to-the-package-were-not-recognized-0x8009030d)
  - [`0x8009030E`](troubleshoot-live-migration-issues.md#failed-to-establish-a-connection-with-host-computer-name-no-credentials-are-available-in-the-security-package-0x8009030e)
  - [`0x80090322`](troubleshoot-live-migration-issues.md#fail-to-live-migrate-because-the-target-principal-name-is-incorrect-0x80090322)
  - [`0xC03A0014`](troubleshoot-live-migration-issues.md#failed-to-restore-with-error--a-virtual-disk-support-provider-for-the-specified-file-was-not-found-0xc03a0014)

  Other Event 21502 messages - virtual switch issues

  - [Virtual switch used by the VM doesn't exist on the destination node *DestinationNode*](troubleshoot-live-migration-issues.md#live-migration-failed-because-a-virtual-switch-used-by-the-vm-doesnt-exist-on-the-destination-node-host2)
  - [Destination has disconnected VM switch(s)](troubleshoot-live-migration-issues.md#failed-to-live-migrate-a-vm-across-nodes-in-a-cluster-when-connected-to-an-internal-or-private-virtual-switch)

  Other Event 21502 messages - hardware compatibility issues

  - [Hardware on the destination computer isn't compatible with the hardware requirements of this virtual machine](troubleshoot-live-migration-issues.md#live-migration-failed-because-the-hardware-on-the-destination-computer-isnt-compatible-with-the-hardware-requirements-of-this-virtual-machine)
  - [Hardware on the destination computer isn't compatible with the hardware requirements of this virtual machine when the destination node has an older microcode (uCode) version than the source node](troubleshoot-live-migration-issues.md#failed-to-live-migrate-a-vm-between-nodes-with-different-microcode-ucode-revisions)
  - [Virtual machine *VMName* is using processor-specific features not supported on host *DestinationNode*.](troubleshoot-live-migration-issues.md#failed-live-migrate-because-virtual-machine-name-is-using-processor-specific-features-not-supported-on-host-node-1)

  Other Event 21502 messages - host connection issue

  - [Virtual machine migration operation for *VMName* failed at migration source *SourceNode*)](troubleshoot-live-migration-issues.md#live-migration-failed-because-virtual-machine-name-failed-at-migration-source-source-host-name)

- [Event ID 20413](troubleshoot-live-migration-issues.md#event-id-20413)

- [Event ID 20417](troubleshoot-live-migration-issues.md#event-id-20417)

- [Event ID 21024](troubleshoot-live-migration-issues.md#event-id-21024)

- [Event ID 21125](troubleshoot-live-migration-issues.md#event-id-21125)

- [Event ID 21501](troubleshoot-live-migration-issues.md#event-id-21501)

### VM or host becomes "stuck" and unresponsive

#### Symptoms

- A VM becomes stuck in a transitional state (Starting or Stopping) or in the Offline state.
- A VM or host enters one of the following states:

  - Paused
  - Critical
  - Not responding
  - Resource-locked

- You might receive error messages that resemble the following examples:

  - `Resource lock`
  - `Service unable to pause`
  - `Storage inaccessible`

- The event logs contain events that indicate service issues or timeouts, such as the following examples:

  - Event ID 153
  - Event ID 5120

#### Possible causes

This kind of issue can have several different causes. Typically, the messages and events that you observe indicate which cause is involved. Possibilities include the following causes:

- A resource, such as a storage device, disconnected from the network.
- A resource lock wasn't released correctly because an operation failed.
- Hardware failed and reduced available resources (CPU, memory, storage IO), or resources are otherwise exhausted.
- Drivers or firmware are out of date.

#### Resolution

To isolate the kind of issue that you're experiencing and address the most common issues, complete the [Troubleshooting checklist](#troubleshooting-checklist). If the issue persists, use one of the following methods (depending on the kind of issue):

- If you receive Event ID 1069, see [Event ID 1069 (Cluster VM failed to start/can't bring a resource online)](hyper-v-start-state-access-failures-clustered-standalone.md#event-id-1069-cluster-vm-failed-to-startcant-bring-a-resource-online) in "Troubleshoot inaccessible or unresponsive Hyper-V VMs in clustered or standalone environments."

- If you receive any of the following storage subsystem events, see [Data corruption and disk errors troubleshooting guidance](../backup-and-storage/troubleshoot-data-corruption-and-disk-errors.md):

  - Event ID 55 and Event ID 98
  - Event ID 129
  - Event ID 153
  - Event ID 157

- If you receive Event ID 5120, see [Event ID 5120 Cluster Shared Volume troubleshooting guidance](../high-availability/event-id-5120-cluster-shared-volume-troubleshooting-guidance.md).

- If you notice locked resources that are associated with a single cluster node, schedule downtime for the cluster, and then restart the affected node.

- For other issues that involve cluster resources, see the following articles:

  - [Cluster service fails to start troubleshooting guidance](../high-availability/troubleshoot-cluster-service-fails-to-start.md)
  - [Can't bring a clustered resource online troubleshooting guidance](../high-availability/troubleshoot-cannot-bring-resource-online-guidance.md)

### Cluster database or quorum issues

#### Symptoms

- Cluster services don't start, and cluster doesn't come online.
- Cluster goes offline intermittently.
- CSV or VMs are offline or inaccessible.
- You receive error messages or events that refer to either of the following issues:

  - Corrupted cluster database (CLUSDB)
  - Lost quorum

#### Possible causes

- A failed operation corrupted the cluster database. Such operations include adding or removing a node, and shutting down the cluster.
- The quorum disk or cluster witness is lost or inaccessible.
- Firewall rules block communication between the cluster nodes.

#### Resolution

To isolate the kind of issue that you're experiencing and address the most common issues, complete the [Troubleshooting checklist](#troubleshooting-checklist). For detailed checklists and troubleshooting information, see the following articles:

- [Configuring Witness resource troubleshooting guide](../high-availability/configuring-witness-resource.md)
- [Cluster service fails to start troubleshooting guidance](../high-availability/troubleshoot-cluster-service-fails-to-start.md)
- [Can't bring a clustered resource online troubleshooting guidance](../high-availability/troubleshoot-cannot-bring-resource-online-guidance.md)

If you can't resolve the issue, you can, as a last resort, back up the cluster, validate the backup, and then rebuild the cluster.

### Storage alerts, errors, or timeouts

#### Symptoms

- The event logs contain events that indicate service issues or timeouts, such as the following examples:

  - Event ID 153
  - Event ID 157
  - Event ID 5120

- You receive error messages or alerts about storage hardware (such as RAID or SAN devices)
- Management tools label volumes as read-only, offline, missing, disconnected, or inaccessible
- VMs unexpectedly restart, become unresponsive, or don't migrate

#### Possible causes

- Storage drivers or firmware are faulty or outdated.
- Disks were removed incorrectly.
- A SAN failed over, or storage hardware malfunctioned
- Storage paths or partitions aren't configured correctly.

#### Resolution

To isolate the kind of issue that you're experiencing and address the most common issues, complete the [Troubleshooting checklist](#troubleshooting-checklist). If the issue persists, use one of the following methods (depending on the kind of issue):

- If you receive any of the following storage subsystem events, see [Data corruption and disk errors troubleshooting guidance](../backup-and-storage/troubleshoot-data-corruption-and-disk-errors.md):

  - Event ID 55 and Event ID 98
  - Event ID 129
  - Event ID 153
  - Event ID 157

- If you received Event ID 5120, see [Event ID 5120 Cluster Shared Volume troubleshooting guidance](../high-availability/event-id-5120-cluster-shared-volume-troubleshooting-guidance.md).

- If your issue appears to relate to multipath I/O (MPIO) configuration, see [Multipath I/O (MPIO) troubleshooting guidance](../backup-and-storage/windows-server-mpio-troubleshooting.md).

- If your issue appears to relate to iSCSI storage devices, see [iSCSI storage connectivity troubleshooting guidance](../backup-and-storage/iscsi-storage-connectivity-troubleshooting.md).

### Communication issues between cluster resources

#### Symptoms

- Nodes drop from the cluster or enter quarantine, or heartbeats are missed or dropped.
- RDP or discovery fails.
- VMs migrate unexpectedly or don't migrate, particularly after nodes are moved or maintained.

#### Possible causes

- Firewall rules are blocking required ports.
- Duplicate IP addresses are configured.
- DNS isn't configured correctly.
- A network interface failed.
- The cluster network isn't configured correctly (for example, client communication uses the wrong mode).
- Teaming or VLAN settings aren't configured correctly.

#### Resolution

To isolate the kind of issue that you're experiencing and address the most common issues, complete the [Troubleshooting checklist](#troubleshooting-checklist). If the issue persists, use one of the following methods (depending on the kind of issue):

- Use Failover Cluster Manager to make sure that the different types of cluster network traffic (management, cluster, and client) follow the correct routing.

- Make sure that all required ports are open. For more information about the required ports, see [Hyper-V service](../networking/service-overview-and-network-port-requirements.md#hyper-v-service) and [Cluster service](../networking/service-overview-and-network-port-requirements.md#cluster-service) in [Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md).

- Verify that IP addresses are static.

- Verify the DNS configuration, and resolve any conflicts. Make sure that no services make unexpected updates to DNS records.

### VMs missing, not starting, or generating configuration error messages

#### Symptoms

- After you restore or clone a VM, it won't start.
- Your management client doesn't include a particular VM.
- You can't import or export a VM.
- You receive error messages that refer to `Incomplete VM configuration`.
- The event logs contain Event ID 1069.

#### Possible causes

- VM configuration files are stored on local (nonshared) storage.
- Disk files or checkpoints are missing or orphaned, or the checkpoint merge process didn't complete correctly.
- Configuration versions don't match.

#### Resolution

To isolate the kind of issue that you're experiencing and address the most common issues, complete the [Troubleshooting checklist](#troubleshooting-checklist). If the issue persists, try the following methods:

- If you receive Event ID 1069 or `Incomplete VM configuration` error messages, see [Event ID 1069 (Cluster VM failed to start/can't bring a resource online)](hyper-v-start-state-access-failures-clustered-standalone.md#event-id-1069-cluster-vm-failed-to-startcant-bring-a-resource-online) in "Troubleshoot inaccessible or unresponsive Hyper-V VMs in clustered or standalone environments."

- If you found orphaned disks or snapshot issues, see [Hyper-V snapshots, checkpoints, and differencing disks (AVHDX) troubleshooting guidance](hyper-v-snapshots-checkpoints-differencing-disks.md).

- Make sure that all virtual disk files and configuration files reside in the cluster's shared storage. You might have to re-add the VM to the cluster after you move the files.

- Upgrade the VM configuration version. For more information, see [Upgrade virtual machine version in Hyper-V on Windows or Windows Server](/windows-server/virtualization/hyper-v/deploy/upgrade-virtual-machine-version-in-hyper-v-on-windows-or-windows-server).

  > [!IMPORTANT]  
  > Make sure that you turn off any features that aren't compatible with your cluster nodes.

## Data Collection

If you need additional assistance, collect the following data, and then contact [Microsoft Support](https://support.microsoft.com/contactus).

### General data

- Version information (and build information, if applicable) for your infrastructure, including the following components:

  - Windows Server
  - Hyper-V
  - Integration services
  - Storage devices, firmware, and drivers

- Screenshots of unexpected behavior or error messages
- Trace or dump file data, including data files from ProcDump, ProcMon, PerfMon, or `livekd`
- RAID and SAN logs
- Documentation of recent changes and maintenance for each cluster node
- Output of PowerShell queries that documents the state of the cluster, network, and storage systems

### Data for Hyper-V related issues

Use Microsoft's troubleshooting scripts (TSS) to automatically gather information for troubleshooting. For instructions, see [Collect data to analyze and troubleshoot Hyper-V scenarios](../../windows-client/windows-tss/collect-data-analyze-troubleshoot-hyperv-scenarios.md?context=/troubleshoot/windows-server/context/context).

Additionally, gather the following information:

- Relevant events from the System and Application logs, and events from the Hyper-V log. The Hyper-V log is available in Event Viewer at **Applications and Services** > **Microsoft** > **Windows** > **Hyper-V**. You can export this information from Event Viewer.

- VM configuration information. Use Hyper-V Manager or PowerShell to export this information.

### Data for cluster-related issues

Use Microsoft troubleshooting scripts (TSS) to automatically gather information for troubleshooting. For instructions, see [Collect data to analyze and troubleshoot clustering and high availability scenarios](../../windows-client/windows-tss/collect-data-analyze-troubleshoot-windows-clustering-scenarios.md?context=/troubleshoot/windows-server/context/context).

Additionally, gather the following information:

- Cluster logs from all nodes
  To collect logs, run the following command on one of the cluster nodes:

  ```powershell
  Get-ClusterLog -UseLocalTime -Destination <folder path>
  ```

- Relevant event logs from the FailoverClustering and DNS Server event log channels
- Details of the CNO object in Active Directory, including security permissions

## References

### Failover clusters

- [Can't bring a clustered resource online troubleshooting guidance](../high-availability/troubleshoot-cannot-bring-resource-online-guidance.md)
- [Cluster service fails to start troubleshooting guidance](../high-availability/troubleshoot-cluster-service-fails-to-start.md)
- [Configuring Witness resource troubleshooting guide](../high-availability/configuring-witness-resource.md)
- [Event ID 5120 Cluster Shared Volume troubleshooting guidance](../high-availability/event-id-5120-cluster-shared-volume-troubleshooting-guidance.md)
- [Failover clustering hardware requirements and storage options](/windows-server/failover-clustering/clustering-requirements)
- [Failover Clustering in Windows Server and Azure Local](/windows-server/failover-clustering/failover-clustering-overview)

### Hyper-V and virtual machines

- [Hyper-V snapshots, checkpoints, and differencing disks (AVHDX) troubleshooting guidance](hyper-v-snapshots-checkpoints-differencing-disks.md)
- [Network recommendations for Hyper-V in a failover cluster](/windows-server/virtualization/hyper-v/failover-cluster-network-recommendations)
- [Performance Tuning Hyper-V Servers](/windows-server/administration/performance-tuning/role/hyper-v-server/)
- [Replicate a virtual machine](/windows-server/virtualization/hyper-v/replication-virtual-machines?tabs=hyper-v-manager#replicate-a-virtual-machine)
- [Troubleshoot inaccessible or unresponsive Hyper-V VMs in clustered or standalone environments](hyper-v-start-state-access-failures-clustered-standalone.md)
- [Upgrade virtual machine version in Hyper-V on Windows or Windows Server](/windows-server/virtualization/hyper-v/deploy/upgrade-virtual-machine-version-in-hyper-v-on-windows-or-windows-server)
- [Virtual machine live migration troubleshooting guidance](troubleshoot-live-migration-guidance.md)

### PowerShell cmdlets 

- [Get-ClusterLog](/powershell/module/failoverclusters/get-clusterlog)
- [Get-ClusterResource](/powershell/module/failoverclusters/get-clusterresource)

### Storage

- [Data corruption and disk errors troubleshooting guidance](../backup-and-storage/troubleshoot-data-corruption-and-disk-errors.md)
- [iSCSI storage connectivity troubleshooting guidance](../backup-and-storage/iscsi-storage-connectivity-troubleshooting.md)
- [Multipath I/O (MPIO) troubleshooting guidance](../backup-and-storage/windows-server-mpio-troubleshooting.md)

### Windows Server

- [High Availability troubleshooting documentation for Windows Server](../high-availability/high-availability-overview.md)
- [Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md)

