---
title: Troubleshoot Rolling Upgrade Issues
description: Discusses how to troubleshoot rolling upgrade issues.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.author: jeffhugh
ms.reviewer: kaushika, v-ryanberg, v-gsitser
ms.custom:
- sap:rolling upgrade and high availability\rolling upgrade issues
- pcy:WinComm Storage High Avail
- appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Troubleshoot rolling upgrade issues

## Summary

This article provides a structured troubleshooting method to resolve common issues that you might encounter during rolling upgrades in Windows Server Failover Clustering (WSFC), Storage Spaces Direct, SQL Server Always On availability groups, and Hyper-V. 

Rolling upgrades are essential for maintaining and upgrading systems while experiencing minimal downtime. However, challenges such as compatibility and configuration errors can affect availability, and potentially cause data loss. 

## Prerequisites

Before you start a rolling upgrade:

- Verify that the rolling upgrade feature is supported for your workload and operating system (OS) versions.
- Verify that all cluster nodes are healthy by using the `Get-ClusterNode` PowerShell command.
- Make sure that you have up-to-date backups, including:    
    - System state
    - Cluster configuration
    - User data

## Potential workarounds

### Address rolling upgrade failures

1. Move core resources to another node by using Failover Cluster Manager or the `Move-ClusterGroup` PowerShell command.
2. Migrate roles and resources off the node by using `Suspend-ClusterNode -Drain`.
3. Check cluster logs for dependencies or errors that might block the operation.

## Troubleshooting checklist

1. **Review prerequisites**: Make sure that the environment meets all prerequisites that are mentioned in this article.

2. **Validate cluster status**: Resolve any validation warnings or errors by running `Test-Cluster`.
    - Verify the current cluster functional level by using `Get-Cluster | Select ClusterFunctionalLevel`.
    - Validate network connectivity among all nodes.

3. **Plan and sequence upgrades**: Document the sequence of node upgrades (one node at a time).
    - Move cluster roles (such as virtual machines (VMs), availability groups, or file shares) off the node that's being upgraded.
    - Update all nodes to the latest supported updates or hotfixes for the current OS.

4. **Communicate with stakeholders**: Inform stakeholders and schedule maintenance windows.
    - Notify monitoring teams in order to avoid unnecessary alerts.

5. **Ensure application awareness**: Verify application compatibility for workloads such as SQL Server, Hyper-V, or file services.
    - Inform application owners about planned upgrades.

6. **Conduct pre-upgrade tests**: Review logs for Windows, applications, clusters, and storage to identify any pre-existing issues.

## Common issues and their respective solutions

### 1. Rolling upgrade doesn't start or node can't be evicted

**Symptoms** 

You can't pause, drain, or remove a node from the cluster. You receive error messages such as the following example:

> Node... cannot be removed from the cluster.

**Cause** 

The node hosts core cluster resources, dependencies are misconfigured or the cluster is unstable.

**Solution**    

1. Move core resources to another node by using Failover Cluster Manager or `Move-ClusterGroup`.
2. move roles and resources by running `Suspend-ClusterNode -Drain`.
3. Make sure that the node isn't the last up-to-date or quorum node.
4. Check cluster logs for blocking dependencies.

### 2. Can't restore upgraded node to cluster

**Symptoms** 

You receive a version mismatch message or error messages such as the following example:

> A node attempted to join a failover cluster but failed due to incompatibility.

**Cause** 

Unsupported OS version mix or nonupdated node.

**Solution**

1. Verify the supported OS and cluster version matrix.
2. Update the node to the latest cumulative update (CU).
3. Upgrade the OS versions sequentially (for example, 2016 → 2019 → 2022).
4. Identify versioning errors by using `Get-ClusterLog`.

### 3. Resource or service doesn't come online

**Symptoms** 

Resources such as VMs or file shares enter a failed or offline state post-upgrade. Common Event IDs include `1069`, `1146`, and `1230`.

**Cause** 

Misconfiguration during upgrade, missing registry keys or files, or service account failures.

**Solution**
 
1. Check cluster events in Failover Cluster Manager.
2. Verify resource owner configurations by running `Get-ClusterResource | Get-ClusterOwnerNode`.
3. Repair or re-create missing dependencies.
4. Restart cluster services by running `Restart-Service ClusSvc`.

### 4. Quorum or communication loss

**Symptoms** 

Cluster goes offline, nodes enter quarantine, or Event IDs `1135` and `1136` appear.

**Cause** 

Network partition, firewall configuration, or quorum misconfiguration.

**Solution**    

1. Make sure that all required ports are open.
2. Check network, DNS, and routing configurations.
3. Check quorum settings by running `Get-ClusterQuorum`. Update settings as appropriate.
4. To identify root causes, run `Validate-Cluster`.

### 5. Update failure or known bug

**Symptoms** 

Cluster services stop responding after an update, or resources fail because of a known problematic update.

**Cause** 

Cluster instability occurred after a Microsoft update installation.

**Solution**    

1. Review Microsoft Knowledge Base (KB) articles for known issues.
2. Remove problematic updates, if it's necessary.
3. Apply recommended hotfixes or wait for new updates.
4. Open a support case if the issue remains unresolved.

### 6. Cluster validation or functional level errors

**Symptoms** 

Can't update the cluster functional level, or validation fails.

**Cause** 

Mixed OS versions, incomplete upgrades, or outdated drivers.

**Solution**    

1. Update all nodes, and make sure that they're joined to the cluster.
2. Update hardware drivers (such as network and storage) and firmware.
3. Complete the upgrade by using `Update-ClusterFunctionalLevel`.
4. Review logs for driver or validation failures.

## Advanced troubleshooting and data collection

For persistent or complex issues, collect the following data.

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

**Update history**

```powershell

Get-HotFix | Export-Csv \Hotfix.csv

```

## References

- [Upgrade a Windows Server failover cluster with a cluster OS rolling upgrade](/windows-server/failover-clustering/cluster-operating-system-rolling-upgrade)
- [Update-ClusterFunctionalLevel](/powershell/module/failoverclusters/update-clusterfunctionallevel)
- [Known issues - KB5062557](https://support.microsoft.com/help/5062557)
