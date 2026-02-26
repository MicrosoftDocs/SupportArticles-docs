---
title: Cluster-Aware Updating (CAU) Troubleshooting Guide
description: Resolves issues that affect Cluster-Aware Updating (CAU) in Windows Failover Clusters.
ms.date: 02/12/2026
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap: clustering and high availability\cluster-aware updating (CAU)
- pcy: High availability\Cluster-Aware Updating (CAU)
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Cluster-aware updating (CAU) troubleshooting guide

## Summary

Cluster-Aware Updating (CAU) is a powerful feature designed to streamline updating for nodes in Windows Failover Clusters with minimal disruption to workloads. While CAU enhances high availability and maintenance efficiency, various operational and configuration issues can arise—ranging from updating failures and cluster service interruptions to permission errors and resource outages. This guide provides a thorough, field-tested approach for diagnosing and resolving the most common CAU and cluster update failures, ensuring your clustered workloads remain healthy and up-to-date.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting:

- Review Recent Changes:
    - Was there an OS version upgrade, driver or firmware update, or Active Directory change?
    - Are there new nodes, network configurations, or changes to updating schedules?
- Verify cluster and CAU Setup:
    - Is the CAU clustered role installed and running?
    - Is each node healthy and able to communicate with others?
    - Are cluster networks and storage in a healthy state?
- Check update source and Management Tools:
    - Are all nodes configured to use the same update source?
    - Are SCCM or other management tools compatible with CAU in your environment?
- Verify Active Directory permissions:
    - Does the Cluster Name Object (CNO) have full control to create and manage Virtual Computer Objects (VCOs)?
    - Are there any AD replication or delegation issues?
- Monitor for service failures and crash dump files:
    - Are nodes or virtual machines (VMs) restarting unexpectedly?
    - Are there crash dump files or event log errors that point to driver, storage, or network issues?
- Collect logs and error messages:
    - Gather cluster logs, update logs, and system/application event logs.
    - Note any specific error messages or event IDs.

## Common issues and solutions

### 1. CAU role missing or failed

#### Symptoms

- CAU role cannot be managed or checked for status.
- Errors: “The cluster resource could not be found,” WU_E_PT_ENDPOINT_DISCONNECTED, CAUUpdatePlugin failures.

#### Resolution

- Verify CAU role in Failover Cluster Manager or through PowerShell (Get-ClusterResource).
- Remove any conflicting or misnamed cluster resources (Remove-ClusterRole -ClusterName \<ClusterName> -force).
- Re-create and pre-stage the CAU computer object in Active Directory.
- Re-add the CAU role (Add-CauClusterRole ...), ensuring correct plugin, account, and scheduling.
- Confirm cluster validation passes with Test-Cluster.

### 2. Permission or Active Directory Issues

#### Symptoms

- Update plugin reports “Access is denied.”
- Event IDs: 1194, 1069. CNO can't create VCO. Resources don't come online after update.

#### Resolution

- In Active Directory Users and Computers, verify that the CNO has full control and "Create Computer Object" privilege on the appropriate OU.
- If the cluster resource fails, reset or repair it: Right-click to repair or reset the password as necessary.
- Reapply permissions and verify functionality by using a CAU test run.
- Make sure that cluster network name resource is enabled and present in AD.

### 3. Cluster nodes not using same update source

#### Symptoms

- Some nodes don't receive updates during update cycles.
- Error: “Cluster-aware updating failed on one node,” consistent 0x80072ee2 in update logs.

#### Resolution

- Compare registry settings for update source (for example, WSUS server) on all nodes (reg query).
- Export working node’s update-related registry. Import to affected nodes.
- Check group policy for settings that might revert update sources.
- Validate consistency post-restart, and make sure success of future CAU runs.

### 4. Network or storage failures affecting updates

#### Symptoms

- VMs restart instead of migrating.
- Event IDs: 158, 58, 155 (storage/fs), “Cluster network is down,” device removals.
- Cluster shared volumes enter a paused state, loss of storage access.

#### Resolution

- Review physical network and storage connections/cables on affected nodes.
- Verify cluster network health (Get-ClusterNetwork), address adapter or VLAN issues.
- Use Test-Cluster to identify hardware health problems.
- Engage storage/network teams for persistent device or connectivity errors.
- Restore storage, correct network issues, retry updating.

### 5. Incorrect update sequencing or forced node failover

#### Symptoms

- Updates install before draining cluster roles, causing workload outages.
- Updating proceeds after multiple failed drain attempts (forced restart/failover of VMs).

#### Resolution

- Always use the -ForcePauseAndDrain flag when scheduling update scripts or CAU runs.
- Review update policies to make sure that node drain and maintenance mode precede updating.
- Don't use custom pre/post-update resource move scripts that might cause a corrupted state.
- Increase concurrent VM migration limits, if it's necessary (Set-VMHost -MaximumVirtualMachineMigrations).

### 6. Driver-related cluster or node failures

#### Symptoms

- Host node restarts unexpectedly. Many VMs restart.
- Bugchecks ("a"), random memory corruption, kernel pages filled with nulls.
- WinDbg reports memory corruption involving graphics or storage adapter drivers.

#### Resolution

- Identify and update outdated drivers (for example, GRID/Nvidia, storage HBA).
- Install the manufacturer-recommended driver versions (for example, Nvidia GRID = 573.48).
- Restart nodes, monitor for further crashes.
- Analyze crash dump files by using WinDbg for confirmation.

### 7. Stale or orphaned cluster roles not removed

#### Symptoms

- Cluster resources remain after removal attempts.
- PowerShell returns: “WARNING: The current cluster isn't configured with a Cluster-Aware Updating clustered role.”

#### Resolution

- Use PowerShell (Remove-ClusterRole... -force) to remove persistent roles.
- Try to move core cluster group to another node before retrying removal.
- If all else fails, review cluster database hive and clear residual entries manually.

### 8. Management tools and update source integration issues

#### Symptoms

- Updates scheduled in SCCM don't reflect or apply to cluster nodes.
- Integration attempts by using third-party update management fail.

#### Resolution

- Acknowledge that SCCM isn't cluster-aware and doesn't natively integrate with CAU.
- Run cluster-aware updating and SCCM updating as separate processes.
- Review documentation for any available integration or escalate for custom solution/support.

## Data collection

- Cluster Logs: Get-ClusterLog -UseLocalTime
- Event Logs: Export through Event Viewer: System, Application, FailoverClustering, Hyper-V-High-Availability
- Update Logs: Get-WindowsUpdateLog
- Diagnostic Data Packages (SDP): .\SDP_Cluster.exe -SDP -SkipSDPList -acceptlogs
- Network Trace: netsh trace start capture=yes
- Registry settings: reg export "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" C:\WU-Reg-Backup.reg
- Driver information and dump files: System crash dump files, analyzed by using WinDbg or similar.

## Common issues quick reference table

| Symptom/error | Root cause | Resolution |
| --- | --- | --- |
| CAU role missing or error “resource could not be found” | Role missing or misconfigured | Remove conflicting role, recreate in AD, re-add CAU role |
| Update plugin “Access is denied”, VCO errors | AD permission/ delegation issues | Grant CNO/VCO full control, reset permissions, repair resource |
| Update fails on a node, 0x80072ee2 codes, split update sources | GPO/Registry inconsistency | Align registry settings, fix GPO, make sure all nodes use same source |
| VMs restart instead of migrate, storage/network fails, Event IDs 158/58/155 | Storage/network/driver failure | Check cables, validate cluster health, update drivers, review logs |
| Updates run before draining, unexpected role failover | update algorithm change, missing flag | Use -ForcePauseAndDrain flag, adjust migration limits |
| “Cluster resource remains after remove”, removal warnings | Stale/orphaned resource | Use Remove-ClusterRole... -force, move core group, clear in hive |
| SCCM or third-party update tool cannot update cluster nodes | No native tool integration | Use CAU separately, escalate for custom/unsupported integrations |
| Host restarts, VM mass restart, memory corruption in dumps | Outdated driver (for example, Nvidia GRID) | Update driver to fixed version. Check for hardware defects |

## References

- [Cluster-Aware Updating Documentation](/windows-server/failover-clustering/cluster-aware-updating)
- [Best Practices for Hyper-V Cluster updating](/system-center/vmm/hyper-v-update)
- [Windows Update Log Analysis](/windows/deployment/update/windows-update-logs)
- [Diagnosing Memory Dumps with WinDbg](/windows-hardware/drivers/debugger/)
