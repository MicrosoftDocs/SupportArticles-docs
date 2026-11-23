---
title: Azure VM resource move fails because Azure Site Recovery replication is enabled
description: Resolve Azure VM move failures caused by Site Recovery replication and vault dependencies. Then, complete the move and re-enable protection.
services: virtual-machines
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/17/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine move fails because Azure Site Recovery replication is enabled

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains how to troubleshoot Azure virtual machine (VM) move failures that occur because Azure Site Recovery replication is enabled. The article provides steps to verify replication status, plan for replication shutdown or reprotection, complete the move, and re-enable protection at the destination.

## Symptoms

Move validation fails if a VM is protected by Site Recovery, or the move succeeds only after replication dependencies are broken.

The following examples illustrate the error messages you might encounter.

```output
The resource is currently protected by Site Recovery.
```

```output
Move validation failed because replication-protected resources are present.
```

## Cause

Site Recovery protection introduces dependencies on Recovery Services vault configuration, replication policies, and protected item mappings. Standard move flows don't automatically preserve these objects.

## Resolution

### Step 1: Verify replication status

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to verify the replication status of the VM.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Recovery Services vault** > **Replicated items**.
1. Check whether the VM is listed and note the **Replication Health** and **Protection State**.

For more information, see [About Site Recovery](/azure/site-recovery/site-recovery-overview).

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$vault = Get-AzRecoveryServicesVault -Name "<vault-name>" -ResourceGroupName "<rg-name>"
Set-AzRecoveryServicesAsrVaultContext -Vault $vault

$fabric = Get-AzRecoveryServicesAsrFabric
$container = Get-AzRecoveryServicesAsrProtectionContainer -Fabric $fabric[0]
Get-AzRecoveryServicesAsrReplicationProtectedItem -ProtectionContainer $container[0] |
  Where-Object { $_.FriendlyName -match "<vm-name>" } |
  Select-Object FriendlyName, ProtectionState, ReplicationHealth
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az site-recovery protected-item list \
  --resource-group "<rg-name>" \
  --vault-name "<vault-name>" \
  --fabric-name "<fabric-name>" \
  --protection-container "<container-name>" \
  --query "[?contains(friendlyName, '<vm-name>')].{Name:friendlyName, State:protectionState}" --output table
```

---

### Step 2: Disable replication before the move

Before you disable replication, document the recovery policy, target network, and test failover configuration so that you can re-create them after the move.

Use the Azure portal, Azure PowerShell, or Azure CLI to disable replication for the VM before moving it.

# [Azure portal](#tab/portal)

Follow these steps:

1. Go to **Recovery Services vault** > **Replicated items**.
1. Select the VM.
1. Select **Disable replication**.
1. Choose whether to clean up or retain recovery points.

For more information, see [About Site Recovery](/azure/site-recovery/site-recovery-overview).

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$protectedItem = Get-AzRecoveryServicesAsrReplicationProtectedItem -ProtectionContainer $container[0] |
  Where-Object { $_.FriendlyName -eq "<vm-name>" }

Remove-AzRecoveryServicesAsrReplicationProtectedItem -InputObject $protectedItem -Force
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az site-recovery protected-item remove \
  --resource-group "<rg-name>" \
  --vault-name "<vault-name>" \
  --fabric-name "<fabric-name>" \
  --protection-container "<container-name>" \
  --name "<protected-item-name>"
```

---

For more information, see [Disable protection for a VMware VM or physical server](/azure/site-recovery/site-recovery-manage-registration-and-protection#disable-protection-for-a-vmware-vm-or-physical-server-replicating-to-azure).

### Step 3: Complete the move

After you remove replication dependencies, rerun move validation and complete the move.

### Step 4: Re-enable protection at destination

After the VM is stable in the destination scope, use the Azure portal to re-enable Site Recovery protection.

#### Azure portal

Follow these steps:

1. Go to **Recovery Services vault** > **Replicated items** > **Replicate**.
1. Select **Azure virtual machines** as the source.
1. Select the moved VM and configure the replication settings.
1. Select **Enable replication**.

For more information, see [Set up disaster recovery for Azure VMs](/azure/site-recovery/azure-to-azure-tutorial-enable-replication).

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Move blocked by Azure Backup dependencies](move-resources-backup-lock-recovery-services-vault.md)
- [Azure Site Recovery documentation](/azure/site-recovery/)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
