---
title: Azure VM resource move fails - Encryption athost requirements arent supported at destination
description: Troubleshoot Azure VM move failures caused by encryption at host limitations in a destination region. Use these steps to restore move readiness.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/04/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine resource move fails because encryption at host requirements aren't supported at destination

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains how to troubleshoot Azure virtual machine (VM) move operations that fail because the destination doesn't support encryption at host. It provides steps to verify the VM's encryption at host settings, validate destination support, and choose a supported mitigation strategy.

## Symptoms

Move validation or post-move deployment fails for a VM that requires encryption at host and generates policy errors that resemble the following examples.

```output
OperationNotAllowed
```

```output
The selected configuration isn't supported in the destination for encryption at host.
```

## Cause

Encryption at host depends on regional support, VM size compatibility, and subscription-level feature availability. A destination that lacks any of these factors can block the move.

## Resolution

### Step 1: Verify encryption at host is enabled

Use Azure PowerShell, Azure CLI, or the [Azure portal](https://portal.azure.com) to check whether encryption at host is enabled for the VM.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>"
$vm.SecurityProfile
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm show --resource-group "<rg-name>" --name "<vm-name>" \
  --query "securityProfile"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Virtual machines**, and then select the VM.
1. In the menu, select **Disks**.
1. Check whether **Encryption at host** is displayed as enabled on the **Disks** pane.

---

For more information, see [Use the Azure portal to enable end-to-end encryption using encryption at host](/azure/virtual-machines/disks-enable-host-based-encryption-portal).

### Step 2: Verify destination support

Use Azure PowerShell or Azure CLI to check whether the destination region supports encryption at host for the VM size.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
# Check if the VM size supports encryption at host in the destination region
Get-AzComputeResourceSku -Location "<destination-region>" |
  Where-Object { $_.Name -eq "<vm-size>" } |
  Select-Object Name, @{N='EncryptionAtHost';E={($_.Capabilities | Where-Object { $_.Name -eq 'EncryptionAtHostSupported' }).Value}}
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm list-skus --location "<destination-region>" --size "<vm-size>" \
  --query "[].{Name:name, EncryptionAtHost:capabilities[?name=='EncryptionAtHostSupported'].value | [0]}" --output table
```

# [Azure portal](#tab/portal)

Checking subscription feature registration status and VM size capability flags for encryption at host isn't available in the Azure portal. To verify feature support, use Azure PowerShell or Azure CLI.

---

### Step 3: Choose supported mitigation

If the destination can't support the requirement, do one of the following:

- Select a different destination.
- Rebuild the VM on a supported target.
- Adjust security design only if approved by policy.

## References

- [Move blocked by Disk Encryption Set access issues for CMK disks](move-resources-cmk-disk-encryption-set-access-denied.md)
- [Move blocked by availability set and zone constraints](move-resources-availability-set-zonal-constraint.md)
- [Encryption at host for Azure VMs](/azure/virtual-machines/disks-enable-host-based-encryption-portal)

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
