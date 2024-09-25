---
title: A storage migration fails with error 12711
description: Fixes an issue in which you receive error 12711 when you perform a storage migration from one LUN to another within a cluster.
ms.date: 04/09/2024
ms.reviewer: wenca, jonjor
---
# Performing a storage migration from one LUN to another in Virtual Machine Manager fails with error 12711

This article helps you fix an issue in which you receive error 12711 when you perform a storage migration from one LUN to another in a cluster.

_Original product version:_ &nbsp; Microsoft System Center Virtual Machine Manager  
_Original KB number:_ &nbsp; 2819202

## Symptoms

When using System Center Virtual Machine Manager and performing a storage migration from one LUN to another within a cluster, the job fails at 99% with the following error:

> 12711 The cluster resource could not be found (0x138F)

This error can also appear when modifying properties of any virtual machine (VM) on a cluster.

## Cause

It can occur if the cluster LUNs have been removed and represented and the cluster configuration of each VM hasn't been updated.

## Resolution

To resolve this issue, update the virtual machine configuration for each VM in the cluster.

On each cluster node, open an administrative PowerShell console and run the following commands. These commands update the virtual machine configuration for each VM in the cluster.

```powershell
Import-Module FailoverClusters  
Get-ClusterResource -c CLUSTERNAME | where {$_.resourcetype.name -eq 'virtual machine configuration'} | Update-ClusterVirtualMachineConfiguration
```

## More information

It has been verified to occur in System Center Virtual Machine Manager 2008 R2 SP1 but may manifest itself in other versions of VMM.

If VMs are already in a failed state in VMM and cannot be repaired, see [How to remove a missing virtual machine from the Virtual Machine Manager console](remove-missing-virtual-machines.md) on how to remove VMs manually from the database.

Open the `WLC_VObjects` table in the VirtualManagerDB (VMM database) and find the status code of the VM. The VM name will be in the **Name** field and the status code will be in the **ObjectState** field. Once located, replace **220** on the fourth line of the [script](remove-missing-virtual-machines.md#sql-server-script) with the object state found for the VM in question in the `WLC_VObject` table.
