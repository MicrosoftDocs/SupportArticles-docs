---
title: Troubleshoot Unexpected Node Reboots in Azure Linux SUSE Pacemaker Cluster
description: This article provides troubleshooting steps for resolving unexpected node reboots in SUSE Linux Pacemaker Clusters
author: rnirek
ms.author: rnirek
ms.reviewer: divargas, rnirek, lariasjaen
ms.topic: troubleshooting
ms.date: 1/13/2025
ms.service: azure-virtual-machines
ms.collection: linux
ms.custom: sap:Issue with Pacemaker cluster, and fencing
---

# Troubleshooting Unexpected Node reboots in Azure Linux SUSE Pacemaker Cluster Nodes

**Applies to:** :heavy_check_mark: Linux VMs

This article provides guidance on troubleshooting, analysis, and resolution of the most common frequent scenarios for unexpected node reboots in SUSE Pacemaker Clusters.

## Prerequisites

1. Ensure that the Pacemaker Cluster setup is correctly configured by following the guidelines provided in [SUSE - set up Pacemaker on SUSE Linux Enterprise Server in Azure ](/azure/sap/workloads/high-availability-guide-suse-pacemaker).

2. For a Microsoft Azure Pacemaker cluster using the Azure Fence Agent as the STONITH(Shoot-The-Other-Node-In-The-Head) device, refer to the documentation [SUSE - Create Azure Fence agent STONITH device](/azure/sap/workloads/high-availability-guide-suse-pacemaker?tabs=msi#use-an-azure-fence-agent-1).

3. For a Microsoft Azure Pacemaker cluster utilizing SBD (STONITH Block Device) storage protection as the STONITH device, choose one of the following setup options. For detailed information on these mechanisms, see:
    - [SBD with an iscsi target server](/azure/sap/workloads/high-availability-guide-suse-pacemaker?tabs=msi#sbd-with-an-iscsi-target-server)
    - [SBD with an Azure shared disk](/azure/sap/workloads/high-availability-guide-suse-pacemaker?tabs=msi#sbd-with-an-azure-shared-disk)

## Scenario 1: Network Outage
* The cluster nodes are experiencing `corosync` communication errors, resulting in continuous retransmissions due to an inability to establish communication between nodes. This issue triggers application timeouts, ultimately leading to node fencing and subsequent reboots.
* Additionally, services dependent on network connectivity, such as `waagent`, generate communication related error messages in the logs, further indicating network related disruptions.

The following  messages can be observed in `/var/log/messages`:

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

### Cause for scenario 1
The unexpected node reboot is noted as a result of a Network Maintenance activity or an outage. For confirmation, the timestamp can be matched by reviewing the [Azure Maintenance Notification](/azure/virtual-machines/linux/maintenance-notifications) in Azure Portal. For more information about Azure Scheduled Events, see [Azure Metadata Service: Scheduled Events for Linux VMs](/azure/virtual-machines/linux/scheduled-events).

### Resolution for scenario 1
If the unexpected reboot timestamp aligns with a maintenance activity, the analysis confirms that either platform or network maintenance impacted the cluster.

For further assistance or other queries, you can open a support request by following these [instructions](#next-steps).

## Scenario 2: Cluster Misconfiguration
The cluster nodes experience unexpected failovers or node reboots, often caused by cluster misconfigurations that affect the stability of Pacemaker Clusters.

The cluster configuration can be reviewed by running the following command:
```bash
sudo crm configure show
```

### Cause for scenario 2
Unexpected reboots in an Azure SUSE Pacemaker cluster often occur due to misconfigurations:

1. Incorrect STONITH configuration: 
    - No STONITH or fencing misconfigured: Not configuring STONITH properly can lead to nodes being marked as unhealthy and triggering unnecessary reboots.
    - Wrong STONITH resource settings: Incorrect parameters for Azure fencing agents like `fence_azure_arm` can cause nodes to reboot unexpectedly during failovers.
    - Insufficient permissions: The Azure resource group or credentials used for fencing may lack required permissions, causing STONITH failures.

2. Missing/Incorrect resource constraints:
   Poorly set constraints can cause resources to be redistributed unnecessarily, leading to node overload and, reboots. Misaligned resource dependency configurations can cause nodes to go into a fail/reboot loop.

3. Cluster threshold and timeout misconfigurations:
    - `failure-timeout`, `migration-threshold`, or `monitor-timeout` values may result in nodes being prematurely rebooted.
    - Heartbeat Timeout Settings: Incorrect `corosync` timeout settings for heartbeat intervals can cause nodes to assume each other are offline, triggering unnecessary reboots.

4. Lack of proper health checks:
    Not setting proper health-check intervals for critical services like SAP HANA(High-performance ANalytic Application) can cause resource or node failures.

5. Resource agent misconfiguration:
    - Custom resource agents misaligned with cluster: Resource agents that don't adhere to Pacemaker standards can create unpredictable behavior, including node reboots.
    - Wrong resource start/stop parameters: Improperly tuned start/stop parameters in cluster configuration may lead to nodes rebooting during resource recovery.

6. Corosync configuration issues:
    - Unoptimized network settings: Incorrect multicast/unicast configuration can lead to heartbeat communication failures. Mismatched `ring0` and `ring1` network configurations cause split-brain scenarios and node fencing.
    - Token timeout mismatches: Token timeout values not aligned with the environment’s latency can trigger node isolation and reboots.
    - Following command can be used to review Corosync configuration:
      ```bash
      sudo cat /etc/corosync/corosync.conf
      ```

### Resolution for scenario 2
- It's necessary to follow the proper guidelines outlined for setting up a [SUSE Pacemaker Cluster](#prerequisites). Additionally, ensure that appropriate resources are allocated for applications such as [SAP HANA](/azure/sap/workloads/sap-hana-high-availability) or [SAP NetWeaver](/azure/sap/workloads/high-availability-guide-suse), as specified in our Microsoft documentation.
- Steps to make necessary changes to the cluster configuration: 
    1. Stop the application on both the nodes. 
    2. Put the cluster under maintenance-mode. 
       ```bash
       crm configure property maintenance-mode=true 
       ```
    3. Edit the cluster configuration:
       ```bash
       crm configure edit 
       ```
    4. Save the changes. 
    5. Remove the cluster out of maintenance-mode.
       ```bash
       crm configure property maintenance-mode=false
       ``` 
## Scenario 3: Migration from On-premises to Azure
When migrating a SUSE Pacemaker cluster from on-premises to Azure, unexpected reboots can arise from specific misconfigurations or overlooked dependencies. 

### Cause for scenario 3
The following are common mistakes in this category:

1. Incomplete or incorrect STONITH configuration:
    - No STONITH or fencing misfconfigured: Not configuring STONITH (Shoot-The-Other-Node-In-The-Head) properly can lead to nodes being marked as unhealthy and triggering unnecessary reboots.
    - Wrong STONITH resource settings: Incorrect parameters for Azure fencing agents like `fence_azure_arm` can cause nodes to reboot unexpectedly during failovers.
    - Insufficient permissions: The Azure resource group or credentials used for fencing may lack required permissions, causing STONITH failures. Key Azure-specific parameters, such as subscription ID, resource group, or VM names, must be correctly configured in the fencing agent. Omissions here can result in fencing failures and unexpected reboots.
    
   For more information, see [Troubleshoot Azure Fence Agent startup issues in SUSE](troubleshoot-azure-fence-agent-startup-suse.md) and [Troubleshoot SBD service failure in SUSE Pacemaker clusters](troubleshoot-sbd-issues-sles.md)

2. Network misconfigurations:
   Misconfigured VNets, subnets, or security group rules can block essential cluster communication, leading to perceived node failures and reboots.
   
   For more information, see [Virtual networks and virtual machines in Azure](/azure/virtual-machines/linux/network-overview)

3. Metadata Service issues:
   Azure's cloud metadata services must be correctly handled; otherwise, resource detection or startup processes can fail.
   
   For more information, see [Azure Instance Metadata Service](/azure/virtual-machines/instance-metadata-service) and [Azure Metadata Service: Scheduled Events for Linux VMs](/azure/virtual-machines/linux/scheduled-events)

4. Performance and latency mismatches:
    - Inadequate VM sizing: Migrated workloads may not align with the selected Azure VM(Virtual Machine) size, causing resource overutilization and triggering reboots.
    - Disk I/O mismatches: On-premises workloads with high IOPS(Input/output operations per second) demands must be paired with the appropriate Azure disk or storage performance tier.
   
   For more information, see [Collect performance metrics for a Linux VM](collect-performance-metrics-from-a-linux-system.md)

5. Security and Firewall Rules:
    - Port Block: On-premises clusters often have open, internal communication, while Azure NSGs (Network Security Groups) or firewalls may block ports required for Pacemaker/Corosync communication.
   
   For more information, see [Network security group test](/azure/virtual-machines/network-security-group-test)


### Resolution for scenario 3

Follow the guidelines outlined to set up a [SUSE Pacemaker Cluster](#prerequisites). Additionally, ensure that appropriate resources are allocated for applications such as [SAP HANA](/azure/sap/workloads/sap-hana-high-availability) or [SAP NetWeaver](/azure/sap/workloads/high-availability-guide-suse), as specified in our Microsoft documentation.

## Scenario 4: `HANA_CALL` timeout after 60 seconds

The Azure SUSE Pacemaker Cluster is running SAP HANA as application and experiences unexpected reboot on one of the nodes or both the nodes in the Pacemaker Cluster. Reviewing the  `/var/log/messages` or  `/var/log/pacemaker.log`,  the node reboot is due to `HANA_CALL` time out as shown:

```output
2024-06-04T09:25:37.772406+00:00 node01 SAPHanaTopology(rsc_SAPHanaTopology_H00_HDB02)[99440]: WARNING: RA: HANA_CALL timed out after 60 seconds running command 'hdbnsutil -sr_stateConfiguration --sapcontrol=1'
2024-06-04T09:25:38.711650+00:00 node01 SAPHana(rsc_SAPHana_H00_HDB02)[99475]: WARNING: RA: HANA_CALL timed out after 60 seconds running command 'hdbnsutil -sr_stateConfiguration'
2024-06-04T09:25:38.724146+00:00 node01 SAPHana(rsc_SAPHana_H00_HDB02)[99475]: ERROR: ACT: check_for_primary:  we didn't expect node_status to be: <>
2024-06-04T09:25:38.736748+00:00 node01 SAPHana(rsc_SAPHana_H00_HDB02)[99475]: ERROR: ACT: check_for_primary:  we didn't expect node_status to be: DUMP <00000000  0a                                                |.|#01200000001>
```

### Cause for scenario 4
The SAP HANA timeout messages are commonly considered internal application timeouts, and the SAP vendor should be engaged.

### Resolution for scenario 4
- To identify the root cause of the issue, it's essential to review the [OS performance](collect-performance-metrics-from-a-linux-system.md). 
- Particular attention should be given to memory pressure and storage devices, their configuration, especially if HANA is hosted on Network File System (NFS), Azure NetApp Files (ANF), or Azure Files. 
- Once external factors, such as platform or network outages, are ruled out, engaging the application vendor for trace call analysis and log review is recommended.

## Scenario 5: `ASCS/ERS` timeout in SAP Netweaver Clusters

The Azure SUSE Pacemaker Cluster is running SAP Netweaver ASCS/ERS as application and experiences unexpected reboot on one of the nodes or both the nodes in the Pacemaker Cluster. Following messages can be observed  in `/var/log/messages` :

```output
2024-11-09T07:36:42.037589-05:00 node  01 SAPInstance(RSC_SAP_ERS10)[8689]: ERROR: SAP instance service enrepserver is not running with status GRAY !
2024-11-09T07:36:42.044583-05:00 node  01 pacemaker-controld[2596]: notice: Result of monitor operation for RSC_SAP_ERS10 on node01: not running 
```

```output
2024-11-09T07:39:42.789404-05:00 node01 SAPInstance(RSC_SAP_ASCS00)[16393]: ERROR: SAP Instance CP2-ASCS00 start failed: #01109.11.2024 07:39:42#012WaitforStarted#012FAIL: process msg_server MessageServer not running
2024-11-09T07:39:420.796280-05:00 node01 pacemaker-execd[2404]: notice: RSC_SAP_ASCS00 start (call 78, PID 16393) exited with status 7 (execution time 23.488s)
2024-11-09T07:39:42.828845-05:00 node  01 pacemaker-schedulerd[2406]: warning: Unexpected result (not running) was recorded for start of RSC_SAP_ASCS00 on node01 at Nov  9 07:39:42 2024 
2024-11-09T07:39:42.828955-05:00 node  01 pacemaker-schedulerd[2406]: warning: Unexpected result (not running) was recorded for start of RSC_SAP_ASCS00 on node01 at Nov  9 07:39:42 2024 
```

### Cause for scenario 5
The `ASCS/ERS` resource is considered the application for SAP Netweaver clusters. When the corresponding cluster monitoring resource times out, it triggers a failover process.

### Resolution scenario 5
- To identify the root cause of the issue, it's essential to review the [OS performance](collect-performance-metrics-from-a-linux-system.md). 
- Particular attention should be given to memory pressure and storage devices, their configuration especially if SAP Netweaver is hosted on Network File System (NFS), Azure NetApp Files (ANF), or Azure Files. 
- Once external factors, such as platform or network outages, are ruled out, engaging the application vendor for trace call analysis and log review is recommended.

## Next steps
For additional help, open a support request by using the following instructions. When you submit your request, attach [supportconfig](https://documentation.suse.com/smart/systems-management/html/supportconfig/index.html) and [hb_report](https://www.suse.com/support/kb/doc/?id=000019142) logs for troubleshooting.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
