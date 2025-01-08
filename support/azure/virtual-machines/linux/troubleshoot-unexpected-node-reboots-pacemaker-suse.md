---
title: Troubleshoot Unexpected Node Reboots in Azure SUSE Pacemaker Cluster
description: This article provides troubleshooting steps for resolving unexpected node reboots in SUSE Linux Pacemaker Clusters
author: lariasjaen
ms.author: rnirek
ms.reviewer: divargas, rnirek
ms.topic: troubleshooting
ms.date: 1/8/2025
ms.service: azure-virtual-machines
ms.collection: linux
---

# Troubleshooting Unexpected Node Reboots in Azure Linux SUSE Pacemaker Cluster Nodes

**Applies to:** :heavy_check_mark: Linux VMs

This article provides guidance on troubleshooting, analysis, and resolution of the most common frequent scenarios for unexpected node reboots in SUSE Pacemaker Clusters.

## Prerequisites

1. Make sure that the setup is correctly configured as documented in [SUSE - set up Pacemaker on SUSE Linux Enterprise Server in Azure ](/azure/sap/workloads/high-availability-guide-suse-pacemaker).

2. For a Microsoft Azure Pacemaker cluster that has Azure Fence Agent as STONITH device, make sure following documentation is followed [SUSE - Create Azure Fence agent STONITH device](/azure/sap/workloads/high-availability-guide-suse-pacemaker?tabs=msi#use-an-azure-fence-agent-1).

3. For a Microsoft Azure Pacemaker cluster that has SBD (STONITH Block Device) storage protection as STONITH device, you can use either of the following options for the setup. For more information about these mechanisms, see:

- [SBD with an iscsi target server](/azure/sap/workloads/high-availability-guide-suse-pacemaker?tabs=msi#sbd-with-an-iscsi-target-server)
- [SBD with an Azure shared disk](/azure/sap/workloads/high-availability-guide-suse-pacemaker?tabs=msi#sbd-with-an-azure-shared-disk)


### Scenario 1: Network Outage
* The cluster nodes are experiencing `corosync` communication errors, resulting in continuous retransmissions due to an inability to establish communication between nodes. This issue triggers application timeouts, ultimately leading to node fencing and subsequent reboots.
* Additionally, services dependent on network connectivity, such as `waagent`, generate communication-related error messages in the logs, further indicating network-related disruptions.

Following message can be observed in `/var/log/messages`:

```output
2021-07-29 05:08:03  [node name] corosync: message repeated 156 times: [   [TOTEM ] Retransmit List: 1be7]
2021-07-29 05:09:07  [node name] corosync: [TOTEM ] Retransmit List: 1bef
2021-07-29 05:12:20  [node name] corosync: [TOTEM ] Retransmit List: 1c01
2021-07-29 05:12:20  [node name] corosync: [TOTEM ] Retransmit List: 1c01
```

#### Cause:
It is observed that the unexpected node reboot is observed due to Network Maintenance activity or an outage . For confirmation, the timestamp can be matched by reviewing the [Azure Maintenance Notification](azure/virtual-machines/maintenance-notifications) in Azure Portal. For more information about Azure Scheduled Events, see [Azure Metadata Service: Scheduled Events for Linux VMs](/azure/virtual-machines/linux/scheduled-events).

#### Resolution:
If the unexpected reboot timestamp aligns with a maintenance activity, the analysis confirms that the cluster was impacted by either platform or network maintenance. For further assistance or additional queries, you can open a support request by following these [instructions](#next-steps).

### Scenario 2: Cluster Misconfiguration

### Cause:
Unexpected reboots in an Azure SUSE Pacemaker cluster often occur due to misconfigurations:

1. Incorrect STONITH configuration: 
   * No STONITH or Fencing Misconfigured: Not configuring STONITH (Shoot-The-Other-Node-In-The-Head) properly can lead to nodes being marked as unhealthy and triggering unnecessary reboots.
   * Wrong STONITH Resource Settings: Incorrect parameters for Azure fencing agents like `fence_azure_arm` can cause nodes to reboot unexpectedly during failovers.
   * Insufficient Permissions: The Azure resource group or credentials used for fencing may lack required permissions, causing STONITH failures.

2. Missing/Incorrect Resource Constraints:
   Poorly set constraints can cause resources to be redistributed unnecessarily, leading to node overload and reboots.Misaligned resource dependency configurations can cause nodes to go into a fail/reboot loop.

3.  Cluster Threshold and Timeout Misconfigurations:
    * `failure-timeout`, `migration-threshold`, or `monitor-timeout` values may result in nodes being prematurely rebooted.
    * Heartbeat Timeout Settings: Incorrect `corosync` timeout settings for heartbeat intervals can cause nodes to assume each other are offline, triggering unnecessary reboots.

4. Lack of Proper Health Checks
    Insufficient Monitoring of Critical Resources: Not setting proper health-check intervals for critical services like SAP HANA can cause resource or node failures.

5. Resource Agent Misconfiguration
   * Custom Resource Agents Misaligned with Cluster: Resource agents that don't adhere to Pacemaker standards can create unpredictable behavior, including node reboots.
   * Wrong Resource Start/Stop Parameters: Improperly tuned start/stop parameters in cluster configuration may lead to nodes rebooting during resource recovery.

6. Corosync Configuration Issues
   * Unoptimized Network Settings: Incorrect multicast/unicast configuration can lead to heartbeat communication failures.Mismatched `ring0` and `ring1` network configurations cause split-brain scenarios and node fencing.
   * Token Timeout Mismatches: Token timeout values not aligned with the environment’s latency can trigger node isolation and reboots.

### Resolution:
It is necessary that proper guidelines are followed as mentioned for setting [SUSE Pacemaker Cluster](#prerequisites) and proper resources are are applied for application such as SAP HANA or SAP Netweaver as mentioned in our MS documentation. 

### Scenario 3: Migration from on-premises to Azure

#### Cause

When migrating a SUSE Pacemaker cluster from on-premises to Azure, unexpected reboots can arise from specific misconfigurations or overlooked dependencies. Below are common mistakes in this category:

1. Incomplete or Incorrect STONITH Configuration:
   * No STONITH or Fencing Misconfigured: Not configuring STONITH (Shoot-The-Other-Node-In-The-Head) properly can lead to nodes being marked as unhealthy and triggering unnecessary reboots.
   * Wrong STONITH Resource Settings: Incorrect parameters for Azure fencing agents like `fence_azure_arm` can cause nodes to reboot unexpectedly during failovers.
   * Insufficient Permissions: The Azure resource group or credentials used for fencing may lack required permissions, causing STONITH failures. Key Azure-specific parameters, such as subscription ID, resource group, or VM names, must be correctly configured in the fencing agent. Omissions here can result in fencing failures and unexpected reboots.

2. Network Misconfigurations:
   Misconfigured VNets, subnets, or security group rules can block essential cluster communication, leading to perceived node failures and reboots.

3. Metadata Service Issues:
   Azure's cloud metadata services must be correctly handled; otherwise, resource detection or startup processes can fail.

4. Performance and Latency Mismatches:
   * Inadequate VM Sizing: Migrated workloads may not align with the selected Azure VM(Virtual Machine) size, causing resource overutilization and triggering reboots.
   * Disk I/O Mismatches: On-prem workloads with high IOPS(Input/output operations per second) demands must be paired with the appropriate Azure disk or storage performance tier.

5. Security and Firewall Rules:
   * Port Blockages: On-prem clusters often have open, internal communication, while Azure NSGs (Network Security Groups) or firewalls may block ports required for Pacemaker/Corosync communication.


### Resolution:
It is necessary to follow the proper guidelines outlined for setting up a [SUSE Pacemaker Cluster](#prerequisites).Additionally, ensure that appropriate resources are allocated for applications such as SAP HANA or SAP NetWeaver, as specified in our Microsoft documentation.

### Scenario 4: `HANA_CALL` timed out after 60 seconds

The Azure SUSE Pacemaker Cluster is running SAP HANA as application and experiences unexpected reboot on one of the nodes or both the nodes in the Pacemaker Cluster. Reviewing the  `/var/log/messages` or  `/var/log/pacemaker.log`,  the node reboot is due to `HANA_CALL` time out. 
Example from `/var/log/messages`:

```output
2023-01-13T11:04:03.788922+09:00 hostname SAPHana(rsc_SAPHana_SID_HDB00)[44016]: WARNING: RA: HANA_CALL timed out after 10 seconds running command 'HDB version'
2023-01-13T11:04:20.388990+09:00 hostname SAPHanaTopology(rsc_SAPHanaTopology_SID_HDB00)[43281]: WARNING: RA: HANA_CALL timed out after 60 seconds running command 'hdbnsutil -sr_stateConfiguration --sapcontrol=1'
2023-01-13T11:05:14.715528+09:00 hostname SAPHana(rsc_SAPHana_SID_HDB00)[44016]: WARNING: RA: HANA_CALL timed out after 60 seconds running command 'hdbnsutil -sr_state'
2023-01-13T11:05:24.440091+09:00 hostname SAPHanaTopology(rsc_SAPHanaTopology_A1P_HDB00)[43281]: WARNING: RA: HANA_CALL timed out after 60 seconds running command 'hdbnsutil -sr_stateConfiguration --sapcontrol=1'
2023-01-13T11:06:26.132815+09:00 hostname SAPHana(rsc_SAPHana_SID_HDB00)[44016]: WARNING: RA: HANA_CALL timed out after 60 seconds running command 'hdbnsutil -sr_state'
2023-01-13T11:06:28.500448+09:00 hostname SAPHanaTopology(rsc_SAPHanaTopology_SID_HDB00)[43281]: WARNING: RA: HANA_CALL timed out after 60 seconds running command 'hdbnsutil -sr_stateConfiguration --sapcontrol=1'
2023-01-13T11:07:32.547155+09:00 hostname SAPHanaTopology(rsc_SAPHanaTopology_SID_HDB00)[43281]: WARNING: RA: HANA_CALL timed out after 60 seconds running command 'HDBSettings.sh getParameter.py --key=global.ini/system_replication/actual_mode --key=global.ini/system_replication/mode --key=global.ini/system_replication/site_name --key=global.ini/system_replication/site_id --sapcontrol=1'
2023-01-13T11:07:39.636239+09:00 hostname SAPHana(rsc_SAPHana_SID_HDB00)[44016]: WARNING: RA: HANA_CALL timed out after 60 seconds running command 'hdbnsutil -sr_state'
2023-01-13T11:08:36.814532+09:00 hostname SAPHanaTopology(rsc_SAPHanaTopology_SID_HDB00)[43281]: WARNING: RA: HANA_CALL timed out after 60 seconds running command 'hdbnsutil -sr_stateHostMapping --sapcontrol=1'
2023-01-13T11:08:56.120394+09:00 hostname SAPHana(rsc_SAPHana_SID_HDB00)[44016]: WARNING: RA: HANA_CALL timed out after 60 seconds running command 'HDBSettings.sh getParameter.py --key=global.ini/system_replication/actual_mode --key=global.ini/system_replication/mode --sapcontrol=1'
```

#### Cause:
The SAP HANA time-out messages are commonly considered internal application time-outs, and the SAP vendor should be engaged.

#### Resolution:
To identify the root cause of the issue, it is essential to review the [OS performance](collect-performance-metrics-from-a-linux-system.md). 
Particular attention should be given to memory pressure and storage devices, their configuration, especially if HANA is hosted on Network File System (NFS), Azure NetApp Files (ANF), or Azure Files. 
Once external factors, such as platform or network outages, are ruled out, it is recommended to engage the application vendor for trace call analysis and log review.

### Scenario 5:`sapstartsrv` isn't running for instance `XXXX-ASCS` or `XXXX-ERS`

The Azure SUSE Pacemaker Cluster is running SAP Netweaver ASCS/ERS as application and experiences unexpected reboot on one of the nodes or both the nodes in the Pacemaker Cluster. Reviewing the  `/var/log/messages` or  `/var/log/pacemaker.log`,  the node reboot is due to ``SAPInstance`` time out. 
Example from `/var/log/messages`:
```output
node01 pacemaker-execd[5807]:  warning: rsc_sapinst_HA1_SCS01_stop_0     process (PID 28237) timed out
node01 pacemaker-execd[5807]:  warning: rsc_sapinst_HA1_SCS01_stop_0[29105] timed out after 600000ms
node01 pacemaker-controld[5809]: notice: Requesting fencing (reboot) of node node01
node01 pacemaker-fenced[5808]: notice: Requesting that node02 perform 'reboot' action targeting node01
```

#### Cause:
The `ASCS/ERS` resource is considered the application for SAP Netweaver clusters. When its monitor times-out, it triggers a failover process.

#### Resolution:
To identify the root cause of the issue, it is essential to review the [OS performance](collect-performance-metrics-from-a-linux-system.md). 
Particular attention should be given to memory pressure and storage devices, their configuration especially if SAP Netweaver is hosted on Network File System (NFS), Azure NetApp Files (ANF), or Azure Files. 
Once external factors, such as platform or network outages, are ruled out, it is recommended to engage the application vendor  for trace call analysis and log review.

## Next steps
For additional help, open a support request by using the following instructions. When you submit your request, attach [supportconfig](https://documentation.suse.com/smart/systems-management/html/supportconfig/index.html) and [hb_report](https://www.suse.com/support/kb/doc/?id=000019142) logs for troubleshooting.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
