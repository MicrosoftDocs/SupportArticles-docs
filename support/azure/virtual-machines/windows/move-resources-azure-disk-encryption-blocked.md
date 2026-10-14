---
title: Azure VM move is blocked by Azure Disk Encryption requirements
description: Learn how to fix VM move failures caused by Azure Disk Encryption requirements. Disable Azure Disk Encryption or deallocate your VM to process the move.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/03/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine move blocked by Azure Disk Encryption requirements

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains how to resolve an Azure virtual machine (VM) move blocked by Azure Disk Encryption requirements. Learn when to deallocate the VM or disable Azure Disk Encryption so that you can complete a move across subscriptions or resource groups.

## Symptoms

A move fails for an Azure VM that's protected by Azure Disk Encryption. This problem frequently occurs when you move a VM across subscriptions.

Common patterns include the following error messages.

```output
Move isn't supported while Azure Disk Encryption is enabled.
```

```output
The virtual machine must be deallocated or disk encryption must be disabled before the move.
```

## Cause

Azure Disk Encryption relies on Key Vault integration and encryption metadata that aren't preserved in every move scenario. Cross-subscription moves usually require decryption first.

## Resolution

### Step 1: Check whether Azure Disk Encryption is enabled

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to check whether Azure Disk Encryption is enabled for the VM.

For more information, see [Azure Disk Encryption overview](/azure/virtual-machines/disk-encryption-overview).

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Virtual machines** and select your VM.
1. Select **Disks**.
1. Check the **Encryption** column for each disk. If it shows **SSE with CMK** or **ADE**, encryption is enabled.
1. Select **Extensions + applications**, and then look for `AzureDiskEncryption` or `AzureDiskEncryptionForLinux`.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzVMDiskEncryptionStatus -ResourceGroupName "<rg-name>" -VMName "<vm-name>"
```

If `OsVolumeEncrypted` or `DataVolumesEncrypted` shows `Encrypted`, you must disable encryption before the move.

Check the VM extension list for Azure Disk Encryption-related extensions by running the following command.

```azurepowershell
Get-AzVMExtension -ResourceGroupName "<rg-name>" -VMName "<vm-name>" |
  Where-Object { $_.ExtensionType -match "AzureDiskEncryption" } |
  Select-Object Name, ProvisioningState
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm encryption show --resource-group "<rg-name>" --name "<vm-name>"
```

---

### Step 2: Deallocate the VM if necessary

Use Azure PowerShell, Azure CLI, or the Azure portal to deallocate the VM if the move path requires it.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Stop-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>" -Force
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm deallocate --resource-group "<rg-name>" --name "<vm-name>"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to **Virtual machines**, and then select the VM.
1. Select **Stop** to deallocate the VM.
1. Wait for the **Status** to show **Stopped (deallocated)**.

---

For more information, see [Azure Disk Encryption overview](/azure/virtual-machines/disk-encryption-overview).

### Step 3: Disable Azure Disk Encryption if the move path requires it

Use Azure PowerShell or Azure CLI to disable Azure Disk Encryption if the move path requires it.

# [Azure portal](#tab/portal)

You can't disable Azure Disk Encryption directly in the Azure portal. Use Azure PowerShell or Azure CLI to run the disable command.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Disable-AzVMDiskEncryption -ResourceGroupName "<rg-name>" -VMName "<vm-name>" -VolumeType all
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm encryption disable --resource-group "<rg-name>" --name "<vm-name>" --volume-type all
```

---

### Step 4: Complete the move and re-enable encryption

After the move finishes, use the Azure portal, Azure PowerShell, or Azure CLI to re-enable Azure Disk Encryption at the destination.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to **Virtual machines** and select the VM in the destination resource group.
1. Select **Disks** > **Additional settings**.
1. Under **Encryption**, select the disk encryption set and key vault to use.
1. Select **Save**.

For more information, see [Azure Disk Encryption for Windows VMs](/azure/virtual-machines/windows/disk-encryption-overview).

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Set-AzVMDiskEncryptionExtension `
  -ResourceGroupName "<destination-rg>" `
  -VMName "<vm-name>" `
  -DiskEncryptionKeyVaultUrl "<key-vault-url>" `
  -DiskEncryptionKeyVaultId "<key-vault-resource-id>" `
  -VolumeType All
```

Verify encryption status, by running the following command.

```azurepowershell
Get-AzVMDiskEncryptionStatus -ResourceGroupName "<destination-rg>" -VMName "<vm-name>"
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm encryption enable \
  --resource-group "<destination-rg>" \
  --name "<vm-name>" \
  --disk-encryption-keyvault "<key-vault-name>" \
  --volume-type All
```

Verify encryption status by running the following command.

```azurecli
az vm encryption show --resource-group "<destination-rg>" --name "<vm-name>"
```

---

## References

- [Move blocked by Disk Encryption Set access issues for CMK disks](move-resources-cmk-disk-encryption-set-access-denied.md)
- [Special cases to move Azure VMs to new subscription or resource group](/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)
- [Azure Disk Encryption overview](/azure/virtual-machines/windows/disk-encryption-overview)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
