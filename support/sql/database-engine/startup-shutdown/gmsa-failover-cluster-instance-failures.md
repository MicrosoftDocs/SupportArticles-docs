---
title: Resolve gMSA Failures in a SQL Server Failover Cluster Instance
description: Learn how to resolve SQL Server failover cluster instance (FCI) setup, add-node, startup, and failover failures when a possible owner node can't use the gMSA.
ms.reviewer: prmadhes, jopilov
ms.date: 09/29/2026
ms.custom: sap:Startup, shutdown, restart issues (instance or database)
ai-usage: ai-assisted
---

# Troubleshoot SQL Server failover cluster instance failures with gMSAs

_Applies to:_ &nbsp; SQL Server on Windows

## Summary

This article helps you troubleshoot SQL Server failover cluster instance (FCI) Setup, add-node, startup, and failover failures when the SQL Server service runs under a group managed service account (gMSA). It covers managed password retrieval on every possible owner node, node-specific rights and startup parameters, incomplete Setup state, and cluster resource failures.

Before you start, review the prerequisites and run the quick validation checklist in [Troubleshoot SQL Server setup, startup, and authentication failures with gMSAs](sql-server-setup-startup-authentication-issues-with-gmsas.md).

## Symptoms

- FCI Setup fails during account validation.
- An add-node operation reports inconsistent service-account information.
- SQL Server starts from the command line but not through the cluster.
- Failover fails because node-specific startup parameters or configuration are missing.

## Cause

FCI failures can involve password retrieval, incomplete Setup metadata, node-specific startup parameters, rights that differ by node, storage access, or Cluster Service health checks. The gMSA-specific cause is that one or more possible owner nodes aren't authorized to retrieve the managed password, so the instance works on some nodes and fails on others.

## Diagnose failover cluster instance failures

1. Run the [quick validation checklist](sql-server-setup-startup-authentication-issues-with-gmsas.md#quick-validation-checklist) on every possible owner node and compare the results.

    Run the following commands on every possible owner node.

    ```powershell
    Test-ADServiceAccount -Identity 'SQLgMSA'
    sc.exe qmanagedaccount MSSQLSERVER
    Get-ClusterResource | Format-Table Name, ResourceType, State, OwnerGroup -AutoSize
    ```

1. Compare service identity, managed-account state, effective rights, and startup parameters across nodes.

    _**Expected result:**_ `Test-ADServiceAccount` returns `True` on every possible owner node, and service configuration and startup parameters are consistent for the same FCI.

1. Review Setup history for canceled or incomplete add-node operations.
1. Collect the SQL Server error log and the cluster log for the same resource transition.

    Generate a cluster log by running the following command.

    ```powershell
    Get-ClusterLog -UseLocalTime -Destination C:\Temp
    ```

## Resolve failover cluster instance failures

Use the solution that matches the evidence from the diagnostic steps.

### Authorize every possible owner node to retrieve the managed password

Authorize every possible owner node to retrieve the managed password, and then retest failover to each node. If the gMSA authorizes individual computer accounts, `Set-ADServiceAccount` replaces the complete authorized-principal list. Review the existing value first, and include every principal that must remain authorized.

```powershell
# Review the gMSA configuration
Get-ADServiceAccount -Identity "SQLgMSA" `
    -Properties PrincipalsAllowedToRetrieveManagedPassword |
    Select-Object Name, PrincipalsAllowedToRetrieveManagedPassword

# If individual computer accounts are used, authorize each possible owner node
Set-ADServiceAccount -Identity "SQLgMSA" `
    -PrincipalsAllowedToRetrieveManagedPassword "NODE1$","NODE2$","NODE3$"

# Verify the gMSA from each possible owner node
Invoke-Command -ComputerName NODE1,NODE2,NODE3 {
    Test-ADServiceAccount -Identity "SQLgMSA"
}
```

If a security group authorizes the gMSA, add the possible owner nodes to that group instead of replacing the existing gMSA principals.

```powershell
Add-ADGroupMember -Identity "SQL-FCI-gMSA-Nodes" `
    -Members "NODE1$","NODE2$","NODE3$"
```

For more information, see the following articles:

- [Get-ADServiceAccount](/powershell/module/activedirectory/get-adserviceaccount)
- [Set-ADServiceAccount](/powershell/module/activedirectory/set-adserviceaccount)
- [Test-ADServiceAccount](/powershell/module/activedirectory/test-adserviceaccount)
- [Add-ADGroupMember](/powershell/module/activedirectory/add-adgroupmember)
- [Manage group managed service accounts](/windows-server/identity/ad-ds/manage/group-managed-service-accounts/group-managed-service-accounts/manage-group-managed-service-accounts)

### Correct node-specific rights, startup parameters, or incomplete Setup state

Correct confirmed node-specific rights, startup parameters, or incomplete Setup state. Run the following commands on each node and compare the results. Replace `<InstanceID>` with the instance ID, such as `MSSQL16.MSSQLSERVER`.

```powershell
# Verify the SQL Server service account on each node
Get-CimInstance Win32_Service -Filter "Name='MSSQLSERVER'" |
    Select-Object Name, StartName, State, StartMode

# Compare SQL Server startup parameters on each node
reg query "HKLM\SOFTWARE\Microsoft\Microsoft SQL Server\<InstanceID>\MSSQLServer\Parameters"

# Check the SQL Server Windows service configuration
sc.exe qc MSSQLSERVER
```

Use SQL Server Configuration Manager to correct startup-parameter differences instead of editing the registry manually. For more information, see the following articles:

- [Configure Windows service accounts and permissions](/sql/database-engine/configure-windows/configure-windows-service-accounts-and-permissions)
- [SQL Server Configuration Manager](/sql/tools/configuration-manager/sql-server-configuration-manager)
- [Configure server startup options](/sql/database-engine/configure-windows/scm-services-configure-server-startup-options)

### Troubleshoot cluster resource failures that aren't related to the service account

If the cluster resource failure isn't related to the service account, use the following commands to review the clustered roles, cluster resources, and cluster log.

```powershell
# List clustered roles and their current owner/state
Get-ClusterGroup

# List cluster resources and their current state
Get-ClusterResource |
    Format-Table Name, ResourceType, State, OwnerGroup -AutoSize

# Identify SQL Server-related cluster resources
Get-ClusterResource |
    Where-Object { $_.ResourceType -like "*SQL*" } |
    Format-Table Name, ResourceType, State, OwnerGroup -AutoSize

# Generate cluster logs
New-Item -ItemType Directory -Path "C:\ClusterLogs" -Force
Get-ClusterLog -UseLocalTime -Destination "C:\ClusterLogs"
```

The `FailoverClusters` PowerShell module provides the `Get-ClusterGroup`, `Get-ClusterResource`, and `Get-ClusterLog` cmdlets. For more information about these cmdlets, see the following articles:

- [Get-ClusterGroup](/powershell/module/failoverclusters/get-clustergroup)
- [Get-ClusterResource](/powershell/module/failoverclusters/get-clusterresource)
- [Get-ClusterLog](/powershell/module/failoverclusters/get-clusterlog)
- [FailoverClusters PowerShell module](/powershell/module/failoverclusters/)

For SQL Server-specific failures, see the following articles:

- [Failover cluster troubleshooting](/sql/sql-server/failover-clusters/windows/failover-cluster-troubleshooting)
- [A SQL Server cluster resource goes to a "failed" state](../failover-clusters/cluster-resource-goes-failed-state.md)

### Re-create missing resource-specific registry keys

To re-create missing resource-specific registry keys, follow the steps in [Manually re-create resource-specific registry keys](../failover-clusters/manually-re-create-resource-specific-registry-keys.md). Before you make the documented registry changes, identify the SQL Server cluster resources and back up the cluster registry.

```powershell
# Identify the SQL Server cluster resources
Get-ClusterResource |
    Where-Object { $_.ResourceType -like "*SQL*" } |
    Format-Table Name, ResourceType, State, OwnerGroup

# Back up the cluster registry before making documented registry changes
New-Item -ItemType Directory -Path "C:\Temp" -Force
reg export "HKLM\Cluster" "C:\Temp\ClusterRegistryBackup.reg" /y
```

> [!CAUTION]
> Don't copy registry values between unrelated instances. Verify the instance ID, shared-storage paths, clustered role, and node before you make a change.

## Collect diagnostic data

If the failure persists after you complete these steps, collect diagnostic data from every possible owner node, including the cluster log for the same resource transition. For the gMSA-specific evidence and standard SQL Server logs to gather, see [Collect diagnostic data](sql-server-setup-startup-authentication-issues-with-gmsas.md#collect-diagnostic-data) in the gMSA troubleshooting overview. Use that data to continue the investigation or to open a support case.

## Related content

- [Troubleshoot SQL Server setup, startup, and authentication failures with gMSAs](sql-server-setup-startup-authentication-issues-with-gmsas.md)
- [SQL Server Setup fails with error 0x84BB0001 when you use a gMSA](gmsa-setup-error-0x84bb0001.md)
- [Troubleshoot SQL Server service startup failures with gMSAs](gmsa-service-startup-failures.md)
- [Failover cluster troubleshooting](/sql/sql-server/failover-clusters/windows/failover-cluster-troubleshooting)
