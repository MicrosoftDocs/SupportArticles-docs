---
title: Troubleshoot Rolling Upgrade Issues
description: Describes how to troubleshoot rolling upgrade issues.
ms.date: 12/05/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.author: jeffhugh
ms.reviewer: kaushika, v-ryanberg, v-gsitser
ms.custom:
- sap:rolling upgrade and high availability\rolling upgrade issues
- pcy:WinComm Storage High Avail
---
# Troubleshoot rolling upgrade issues

## Summary

This article provides a structured troubleshooting approach for addressing common issues encountered during rolling upgrades in Windows Server Failover Clustering (WSFC), Storage Spaces Direct, SQL Server Always On availability groups, and Hyper-V. 

Rolling upgrades are essential for maintaining and upgrading systems with minimal downtime. However, challenges like compatibility and configuration errors can impact availability and potentially cause data loss. 

## Prerequisites

Before starting a rolling upgrade:

- Verify that the rolling upgrade feature is supported for your workload and operating system (OS) versions.
- Confirm all cluster nodes are healthy using the `Get-ClusterNode` PowerShell command.
- Ensure you have up-to-date backups, including:    
    - System state
    - Cluster configuration
    - User data

## Potential workarounds

### Address rolling upgrade failures

1. Move core resources to another node using Failover Cluster Manager or the `Move-ClusterGroup` PowerShell command.
2. Use `Suspend-ClusterNode -Drain` to migrate roles and resources off the node.
3. Check cluster logs for dependencies or errors blocking the operation.

## Troubleshooting checklist

1. **Review prerequisites**: Ensure the environment meets all prerequisites previously cited in this article.

2. **Validate cluster status**: Run `Test-Cluster` and resolve any validation warnings or errors.
    - Verify the current cluster functional level using `Get-Cluster | Select ClusterFunctionalLevel`.
    - Validate network connectivity among all nodes.

3. **Plan and sequence upgrades**: Document the sequence of node upgrades (one node at a time).
    - Move cluster roles (like virtual machines (VMs), availability groups, or file shares) off the node being upgraded.
    - Update all nodes with the latest supported patches or hotfixes for the current OS.

4. **Communicate with stakeholders**: Inform stakeholders and schedule maintenance windows.
    - Notify monitoring teams to avoid unnecessary alerts.

5. **Ensure application awareness**: Confirm application compatibility for workloads like SQL Server, Hyper-V, or file services.
    - Inform application owners of planned upgrades.

6. **Conduct pre-upgrade tests**: Review logs for Windows, applications, clusters, and storage to identify any pre-existing issues.

## Common issues and their respective solutions

### 1. Rolling upgrade fails to start or node can't be evicted

**Symptoms** 

You're unable to pause, drain, or remove a node from the cluster. Errors like "Node ... cannot be removed from the cluster ..." appear.

**Cause** 

The node hosts core cluster resources, dependencies are misconfigured, or the cluster is unstable.

**Solution**    

1. Move core resources to another node using Failover Cluster Manager or `Move-ClusterGroup`.
2. Use `Suspend-ClusterNode -Drain` to move roles and resources.
3. Ensure the node isn't the last up-to-date or quorum node.
4. Check cluster logs for blocking dependencies.

### 2. Failure adding upgraded node back to cluster

**Symptoms** 

Errors like "A node attempted to join a failover cluster but failed due to incompatibility…" or version mismatch messages appear.

**Cause** 

Unsupported OS version mix or unpatched node.

**Solution**    

1. Verify the supported OS and cluster version matrix.
2. Patch the node to the latest cumulative update (CU).
3. Upgrade the OS versions sequentially (for example, 2016 → 2019 → 2022).
4. Use `Get-ClusterLog` to identify versioning errors.

### 3. Resource or service fails to come online

**Symptoms** 

Resources like VMs or file shares enter a failed or offline state post-upgrade. Common Event IDs include `1069`, `1146`, and `1230`.

**Cause** 

Misconfiguration during upgrade, missing registry keys or files, or service account failures.

**Solution**   
 
1. Check cluster events in Failover Cluster Manager.
2. Validate resource owner configurations using `Get-ClusterResource | Get-ClusterOwnerNode`.
3. Repair or recreate missing dependencies.
4. Restart cluster services with `Restart-Service ClusSvc`.

### 4. Quorum or communication loss

**Symptoms** 

Cluster goes offline, nodes enter quarantine, or Event IDs `1135` and `1136` appear.

**Cause** 

Network partition, firewall configuration, or quorum misconfiguration.

**Solution**    

1. Ensure all required ports are open.
2. Check network, DNS, and routing configurations.
3. Check quorum settings with `Get-ClusterQuorum` and update them if necessary.
4. Run `Validate-Cluster` to identify root causes.

### 5. Patch or update failure or known bug

**Symptoms** 

Cluster services crash post-update or resources fail due to a known problematic update.

**Cause** 

Microsoft updates or patches causing cluster instability.

**Solution**    

1. Review Microsoft Knowledge Base (KB) articles for known issues.
2. Remove problematic updates if needed.
3. Apply recommended hotfixes or wait for updated patches.
4. Open a support case if still unresolved.

### 6. Cluster validation or functional level errors

**Symptoms** 

Unable to update the cluster functional level or validation fails.

**Cause** 

Mixed OS versions, incomplete upgrades, or outdated drivers.

**Solution**    

1. Update all nodes and ensure they're joined to the cluster.
2. Update hardware drivers (like network and storage) and firmware.
3. Use `Update-ClusterFunctionalLevel` to complete the upgrade.
4. Review logs for driver or validation failures.

## Advanced troubleshooting and data collection

For persistent or complex issues, collect the following data:

**Cluster logs**

```powershell

Get-ClusterLog -TimeSpan 24:00 -Destination

```

**System and application event logs**

```powershell
    
    Get-WinEvent -LogName System -MaxEvents 1000 | Export-Csv <Path>\SystemLogs.csv
    Get-WinEvent -LogName Application -MaxEvents 1000 | Export-Csv <Path>\AppLogs.csv
    
```

**Resource and node status**

```powershell
   
   
    Get-ClusterNode
    Get-ClusterResource
    Get-ClusterGroup
    Test-Cluster
    
```

**Network and driver information**

```powershell
    
    Get-NetAdapter -IncludeHidden | Export-Csv <Path>\NetAdapters.csv
    
```

**Patch or update history**

```powershell

Get-HotFix | Export-Csv \Hotfix.csv

```

## References

- [Upgrade a Windows Server failover cluster with a cluster OS rolling upgrade](/windows-server/failover-clustering/cluster-operating-system-rolling-upgrade)
- [Update-ClusterFunctionalLevel](/powershell/module/failoverclusters/update-clusterfunctionallevel)
- [Known issues - KB5062557](https://support.microsoft.com/help/5062557)