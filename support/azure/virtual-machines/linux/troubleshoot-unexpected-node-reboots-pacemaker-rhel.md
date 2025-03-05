---
title: Troubleshoot Unexpected Node Restarts in Azure Linux RHEL Pacemaker Cluster
description: This article provides troubleshooting steps for resolving unexpected node restarts in RHEL Linux Pacemaker Clusters
author: rnirek
ms.author: rnirek
ms.reviewer: divargas, rnirek, lariasjaen
ms.topic: troubleshooting
ms.date: 2/19/2025
ms.service: azure-virtual-machines
ms.collection: linux
ms.custom: sap:Issue with Pacemaker cluster, and fencing
---

# Troubleshooting unexpected node restarts in Azure Linux RHEL Pacemaker Cluster nodes

**Applies to:** :heavy_check_mark: Linux VMs

This article provides guidance for troubleshooting, analysis, and resolution of most common scenarios for unexpected node restarts in RedHat Enterprise Linux (RHEL) Pacemaker Clusters.

## Prerequisites

- Make sure that the Pacemaker Cluster setup is correctly configured by following the guidelines that are provided in [Set up Pacemaker on Red Hat Enterprise Linux in Azure](/azure/sap/workloads/high-availability-guide-rhel-pacemaker).
- For a Microsoft Azure Pacemaker Cluster that uses the Azure Fence Agent as the STONITH (Shoot-The-Other-Node-In-The-Head) device, refer to the [RHEL - Create Azure Fence agent STONITH device](/azure/sap/workloads/high-availability-guide-rhel-pacemaker#azure-fence-agent-configuration) documentation.
- For a Microsoft Azure Pacemaker cluster that uses SBD (STONITH Block Device) storage protection as the STONITH device, choose one of the following setup options (see the articles for detailed information):
    - [SBD with an iSCSI target server](/azure/sap/workloads/high-availability-guide-rhel-pacemaker#sbd-with-an-iscsi-target-server)
    - [SBD with an Azure shared disk](/azure/sap/workloads/high-availability-guide-rhel-pacemaker#sbd-with-an-azure-shared-disk)

## Scenario 1: Network outage

- The cluster nodes are experiencing `corosync` communication errors. This causes continuous retransmissions because of an inability to establish communication between nodes. This issue triggers application time-outs and ultimately causes node fencing and subsequent restarts.
- Services that are dependent on network connectivity, such as `waagent`, generate communication-related error entries in the logs. These entries further indicate network-related disruptions.

The following messages are logged in the `/var/log/messages` log:

From `node 01`:
```output
Aug 21 01:48:00 node  01 corosync[19389]:  [TOTEM ] Token has not been received in 30000 ms
Aug 21 01:48:00 node  01 corosync[19389]:  [TOTEM ] A processor failed, forming new configuration: token timed out (40000ms), waiting 48000ms for consensus. 
```
From `node 02`:
```output
Aug 21 01:47:27 node  02 corosync[15241]:  [KNET  ] link: host: 2 link: 0 is down
Aug 21 01:47:27 node  02 corosync[15241]:  [KNET  ] host: host: 2 (passive) best link: 0 (pri: 1)
Aug 21 01:47:27 node  02 corosync[15241]:  [KNET  ] host: host: 2 has no active links
Aug 21 01:47:31 node  02 corosync[15241]:  [TOTEM ] Token has not been received in 30000 ms
```

### Cause of scenario 1

An unexpected node restart occurs because of a network maintenance activity or an outage. For verification, you can match the timestamp by reviewing the [Azure Maintenance Notification](/azure/virtual-machines/linux/maintenance-notifications) in the Azure portal. For more information about Azure Scheduled Events, see [Azure Metadata Service: Scheduled Events for Linux VMs](/azure/virtual-machines/linux/scheduled-events).

### Resolution for scenario 1

If the unexpected restart timestamp aligns with a maintenance activity, the analysis confirms that either platform or network maintenance affected the cluster.

For further assistance or other inquiries, you can open a support request by following [these instructions](#next-steps).

## Scenario 2: Cluster misconfiguration

The cluster nodes experience unexpected failovers or node restarts. These issues often occur becuase of cluster misconfigurations that affect the stability of Pacemaker Clusters.

To review the cluster configuration, run the following command:
```bash
sudo pcs configure show
```

### Cause of scenario 2

Unexpected restarts in an Azure SUSE Pacemaker cluster often occur because of misconfigurations:

- Incorrect STONITH configuration: 
    - No STONITH or fencing misconfigured: Not configuring STONITH correctly could cause nodes to be marked as unhealthy and trigger unnecessary restarts.
    - Wrong STONITH resource settings: Incorrect parameters for Azure fencing agents, such as `fence_azure_arm`, could cause nodes to restart unexpectedly during failovers.
    - Insufficient permissions: The Azure resource group or credentials that are used for fencing might lack required permissions and cause STONITH failures.

- Missing or incorrect resource constraints:
   Poorly set constraints could cause resources to be redistributed unnecessarily. This situation, in turn, could cause node overload and restarts. Misaligned resource dependency configurations could cause nodes to fail or go into a restart loop.

- Cluster threshold and time-out misconfigurations:
    - `failure-time-out`, `migration-threshold`, or `monitor-time-out` values might cause nodes to be prematurely restarted.
    - Heartbeat Timeout Settings: Incorrect `corosync` time-out settings for heartbeat intervals could cause nodes to assume that the other nodes are offline. This situation can trigger unnecessary restarts.

- Lack of proper health checks:
    Not setting correct health check intervals for critical services such as SAP HANA (High-performance ANalytic Application) could cause resource or node failures.

- Resource agent misconfiguration:
    - Custom resource agents misaligned with cluster: Resource agents that don't adhere to Pacemaker standards can create unpredictable behavior, including node restarts.
    - Wrong resource start/stop parameters: Incorrectly tuned start/stop parameters in cluster configuration might cause nodes to restart during resource recovery.

### Resolution for scenario 2

- Follow the proper guidelines to set up a [RHEL Pacemaker Cluster](#prerequisites). Additionally, make sure that appropriate resources are allocated for applications such as [SAP HANA](/azure/sap/workloads/sap-hana-high-availability-rhel) or [SAP NetWeaver](/azure/sap/workloads/high-availability-guide-rhel), as specified in the Microsoft documentation.
- Steps to make necessary changes to the cluster configuration: 
    1. Stop the application on both nodes. 
    2. Put the cluster into maintenance-mode: 

       ```bash
       sudo pcs property set maintenance-mode=true 
       ```
    3. Edit the cluster configuration:
    
       ```bash
       sudo pcs configure edit 
       ```
    4. Save the changes. 
    5. Remove the cluster from maintenance mode.
       ```bash
       sudo pcs property set maintenance-mode=false
       ``` 

> [!IMPORTANT]
> When you troubleshoot unexpected node restarts or failures, it's crucial to assess the effect of security tools that are installed on the system. These tools might interfere with cluster operations by blocking essential processes or modifying system files. This situation could cause instability, unexpected time-outs, or node restarts.  
>  
> To mitigate such risks, we recommend that you disable security tools on systems that are running a Pacemaker Cluster. Alternatively, you can configure appropriate exclusions to prevent conflicts with the cluster and its associated applications.

## Scenario 3: Migration from on-premises to Azure

When you migrate a SUSE Pacemaker cluster from on-premises to Azure, unexpected restarts can occur because of specific misconfigurations or overlooked dependencies. 

### Cause of scenario 3

The following are common mistakes that are made in this category:

- Incomplete or incorrect STONITH configuration:
    - No STONITH or fencing misfconfigured: Not configuring STONITH correctly could cause nodes to be marked as unhealthy and trigger unnecessary restarts.
    - Wrong STONITH resource settings: Incorrect parameters for Azure fencing agents such as `fence_azure_arm` could cause nodes to restart unexpectedly during failovers.
    - Insufficient permissions: The Azure resource group or credentials that are used for fencing might lack required permissions and cause STONITH failures. Key Azure-specific parameters, such as subscription ID, resource group, or VM (Virtual Machine) names, must be correctly configured in the fencing agent. Omissions here could cause fencing failures and unexpected restarts.
    
   For more information, see [Troubleshoot Azure Fence Agent startup issues in RHEL](troubleshoot-azure-fence-agent-rhel.md) and [Troubleshoot SBD service failure in RHEL Pacemaker clusters](troubleshoot-sbd-issues-rhel.md)

- Network misconfigurations:
   Misconfigured VNets, subnets, or security group rules can block essential cluster communication and cause perceived node failures and restarts.
   
   For more information, see [Virtual networks and virtual machines in Azure](/azure/virtual-machines/linux/network-overview)

- Metadata Service issues:
   Azure's cloud metadata services must be correctly handled. Otherwise, resource detection or startup processes can fail.
   
   For more information, see [Azure Instance Metadata Service](/azure/virtual-machines/instance-metadata-service) and [Azure Metadata Service: Scheduled Events for Linux VMs](/azure/virtual-machines/linux/scheduled-events)

- Performance and latency mismatches:
    - Inadequate VM sizing: Migrated workloads might not align with the selected Azure VM size. This causes excessive resource use and triggers restarts.
    - Disk I/O mismatches: On-premises workloads that have high IOPS (Input/output operations per second) demands must be paired with the appropriate Azure disk or storage performance tier.
   
   For more information, see [Collect performance metrics for a Linux VM](collect-performance-metrics-from-a-linux-system.md)

- Security and firewall rules:
    - Port Block: On-premises clusters often have open, internal communication. Additionally, Azure NSGs (Network Security Groups) or firewalls might block ports that are required for Pacemaker or Corosync communication.
   
   For more information, see [Network security group test](/azure/virtual-machines/network-security-group-test)

### Resolution for scenario 3

Follow the proper guidelines to set up an [RHEL Pacemaker Cluster](#prerequisites). Additionally, make sure that appropriate resources are allocated for applications such as [SAP HANA](/azure/sap/workloads/sap-hana-high-availability) or [SAP NetWeaver](/azure/sap/workloads/high-availability-guide-suse), as specified in the Microsoft documentation.

## Scenario 4: Both cluster nodes are terminated after a failover event on RHEL 8

The Pacemaker Cluster anticipates an outage, and it proceeds to trigger a failover event. In a two-node cluster configuration, both nodes are terminated and stay offline until manual intervention can occur.

The logs indicate that the STONITH device, `python-user`, triggers the shutdown instruction for both nodes.

### Cause of scenario 4

During an outage, such as a platform or network interruption [see Scenario 1](#scenario-1-network-outage), both nodes try to write to the STONITH device to fence the other because they lose the totem token. Typically, the STONITH device takes instruction from the first available node to write on it in order to shut down the other node. If both nodes are allowed to write to the STONITH device, they might terminate each other.

### Resolution for scenario 4

We recommended that you use the `priority-fencing-delay` or `pcmk_delay_max` parameter so that only one VM is acknowledged by the STONITH device:

1. Set the cluster under maintenance-mode:

    ```bash
    sudo pcs property set maintenance-mode=true
    ```

2. Edit the cluster configuration:

    ```bash
    sudo pcs configure edit 
    ```

3. If the Pacemaker version is earlier than `2.0.4-6.el8`, add the `pcmk_delay_max` parameter:

    ```bash
    sudo pcs property set pcmk_delay_max=15s
    ```

    If the Pacemaker version is later than `2.0.4-6.el8`, use the `priority-fencing-delay` parameter instead:

    ```bash
    sudo pcs property set priority-fencing-delay=15s
    ```

4. Save the changes, and remove the cluster from maintenance mode:

    ```bash
    sudo pcs property set maintenance-mode=false
    ```

For more information, see [RHEL - Create Azure Fence agent STONITH device](/azure/sap/workloads/high-availability-guide-rhel-pacemaker#azure-fence-agent-configuration).

## Scenario 5: `HANA_CALL` time-out after 60 seconds

The Azure RHEL Pacemaker Cluster is running SAP HANA as an application, and it experiences unexpected restarts on one of the nodes or both nodes in the Pacemaker Cluster. Per the `/var/log/messages` or  `/var/log/pacemaker.log` log entries, the node restart is caused by a `HANA_CALL` time-out, as follows:

```output
2024-06-04T09:25:37.772406+00:00 node01 SAPHanaTopology(rsc_SAPHanaTopology_H00_HDB02)[99440]: WARNING: RA: HANA_CALL timed out after 60 seconds running command 'hdbnsutil -sr_stateConfiguration --sapcontrol=1'
2024-06-04T09:25:38.711650+00:00 node01 SAPHana(rsc_SAPHana_H00_HDB02)[99475]: WARNING: RA: HANA_CALL timed out after 60 seconds running command 'hdbnsutil -sr_stateConfiguration'
2024-06-04T09:25:38.724146+00:00 node01 SAPHana(rsc_SAPHana_H00_HDB02)[99475]: ERROR: ACT: check_for_primary:  we didn't expect node_status to be: <>
2024-06-04T09:25:38.736748+00:00 node01 SAPHana(rsc_SAPHana_H00_HDB02)[99475]: ERROR: ACT: check_for_primary:  we didn't expect node_status to be: DUMP <00000000  0a                                                |.|#01200000001>
```

### Cause of scenario 5

The SAP HANA time-out messages are commonly considered to be internal application time-outs. Therefore, the SAP vendor should be engaged.

### Resolution for scenario 5

- To identify the root cause of the issue, review the [OS performance](collect-performance-metrics-from-a-linux-system.md).
- You should pay particular attention to memory pressure and storage devices and their configuration. This is especially true if HANA is hosted on Network File System (NFS), Azure NetApp Files (ANF), or Azure Files.
- After you rule out external factors, such as platform or network outages, we recommend that you contact the application vendor for trace call analysis and log review.

## Scenario 6: `ASCS/ERS` time-out in SAP Netweaver clusters

The Azure SUSE Pacemaker Cluster is running SAP Netweaver ASCS/ERS as an application, and it experiences unexpected restarts on one of the nodes or both nodes in the Pacemaker Cluster. The following messages are logged in the `/var/log/messages` log:

```output
2024-11-09T07:36:42.037589-05:00 node  01 SAPInstance(RSC_SAP_ERS10)[8689]: ERROR: SAP instance service enrepserver is not running with status GRAY !
2024-11-09T07:36:42.044583-05:00 node  01 pacemaker-controld[2596]: notice: Result of monitor operation for RSC_SAP_ERS10 on node01: not running 
```

```output
2024-11-09T07:39:42.789404-05:00 node01 SAPInstance(RSC_SAP_ASCS00)[16393]: ERROR: SAP Instance CP2-ASCS00 start failed: #01109.11.2024 07:39:42#012WaitforStarted#012FAIL: process msg_server MessageServer not running
2024-11-09T07:39:420.796280-05:00 node01 pacemaker-execd[2404]: notice: RSC_SAP_ASCS00 start (call 78, PID 16393) exited with status 7 (execution time 23.488s)
2024-11-09T07:39:42.828845-05:00 node  01 pacemaker-schedulerd[2406]: warning: Unexpected result (not running) was recorded for start of RSC_SAP_ASCS00 on node01 at Nov  9 07:39:42 2024 
2024-11-09T07:39:42.828955-05:00 node  01 pacemaker-schedulerd[2406]: warning: Unexpected result (not running) was recorded for start of RSC_SAP_ASCS00 on node01 at Nov  9 07:39:42 2024 
```

### Cause of scenario 6

The `ASCS/ERS` resource is considered to be the application for SAP Netweaver clusters. When the corresponding cluster monitoring resource times out, it triggers a failover process.

### Resolution for scenario 6

- To identify the root cause of the issue, we recommend that you review the [OS performance](collect-performance-metrics-from-a-linux-system.md). 
- You should pay particular attention to memory pressure and storage devices and their configuration. This is especially true if SAP Netweaver is hosted on Network File System (NFS), Azure NetApp Files (ANF), or Azure Files.
- After you rule out external factors, such as platform or network outages, we recommend that you engage the application vendor for trace call analysis and log review.

## Next steps
For more help, open a support request, and submit your request by attaching [sosreport](https://access.redhat.com/solutions/3592) logs for troubleshooting.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
