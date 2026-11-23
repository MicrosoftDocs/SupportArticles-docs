---
title: Azure VM resource move fails because disk encryption set access is missing for Azure Customer-Managed Keys
description: Troubleshoot an Azure VM resource move that fails when a Disk Encryption Set can't access Azure Customer-Managed Keys. Restore access and complete the move.
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

# Azure VM resource move fails because disk encryption set access is missing for Azure Customer-Managed Keys

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains how to troubleshoot Azure virtual machine (VM) resource move operations that fail because of missing disk encryption set (DES) access for Azure Customer-Managed Keys (CMK). It provides guidance to identify the DES and Azure Key Vault dependencies, validating permissions, and resolving access issues to ensure successful move operations.

## Symptoms

Move validation or post-move disk operations fail for VMs that use CMK encryption. The error message matches one of the following examples.

**Authorization failure**

```output
AuthorizationFailed
```

**Disk Encryption Set access denied**

```output
DiskEncryptionSet access denied to Key Vault key.
```

These errors indicate that the DES can't access the Key Vault key that is required for disk operations after the move.

## Cause

CMK-protected managed disks depend on DES identity permissions and Key Vault access policies or role-based access control (RBAC). If the destination scope doesn't preserve the required access, move operations fail.

## Resolution

### Step 1: Identify DES and key dependencies

Determine which DES and Key Vault key the virtual machine uses.

Use Azure PowerShell, Azure CLI, or the [Azure portal](https://portal.azure.com) to identify the DES and Key Vault key associated with the VM's OS and data disks.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>"
$vm.StorageProfile.OsDisk.ManagedDisk
$vm.StorageProfile.DataDisks | Select-Object Name, ManagedDisk
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm show --resource-group "<rg-name>" --name "<vm-name>" \
  --query "{OsDisk:storageProfile.osDisk.managedDisk, DataDisks:storageProfile.dataDisks[].{Name:name, DiskId:managedDisk.id}}"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Virtual machines**, and then select the VM.
1. In the menu, select **Disks**.
1. For each disk (OS and data), note the **Encryption** column. If it shows **SSE with CMK**, select the disk to view its **Disk Encryption Set** name.
1. Search for **Disk Encryption Sets** in the portal. Select the DES to view its associated **Key Vault** and **Key** on the **Overview** page.

---

For more information, see [Azure Disk Encryption overview](/azure/virtual-machines/disk-encryption-overview).

Note the DES resource ID that's associated with each disk. You need to have this value to complete the following steps.

### Step 2: Verify DES identity permissions

DES uses a managed identity to access the Key Vault key. Use Azure PowerShell or Azure CLI to verify that this managed identity has the required permissions (`Get`, `Wrap Key`, `Unwrap Key`) on the Key Vault in the destination scope.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
# Get the DES identity
$des = Get-AzDiskEncryptionSet -ResourceGroupName "<rg-name>" -Name "<des-name>"
$desPrincipalId = $des.Identity.PrincipalId

# Check role assignments on the Key Vault
Get-AzRoleAssignment -ObjectId $desPrincipalId -Scope "<key-vault-resource-id>" |
  Select-Object RoleDefinitionName, Scope
```

Run the following command if you use Key Vault access policies instead of RBAC.

```azurepowershell
$kv = Get-AzKeyVault -VaultName "<key-vault-name>"
$kv.AccessPolicies | Where-Object { $_.ObjectId -eq $desPrincipalId } |
  Select-Object ObjectId, PermissionsToKeys
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
# Get DES identity
az disk-encryption-set show --resource-group "<rg-name>" --name "<des-name>" \
  --query "identity.principalId" --output tsv

# Check role assignments
az role assignment list --assignee "<des-principal-id>" \
  --scope "<key-vault-resource-id>" --output table
```

# [Azure portal](#tab/portal)

Querying managed identity role assignments on a Key Vault for DES access programmatically isn't available in the Azure portal. To verify identity permissions, use Azure PowerShell or Azure CLI.

---

If the Key Vault uses Azure RBAC, verify that the DES identity has the **Key Vault Crypto Service Encryption User** role assigned.

### Step 3: Verify Key Vault network and access configuration

Verify that the Key Vault firewall rules, private endpoint configuration, and access policies allow the DES to perform key operations from the destination scope.

Use Azure PowerShell, Azure CLI, or the Azure portal to check the Key Vault network and access configuration.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$kv = Get-AzKeyVault -VaultName "<key-vault-name>"

# Check network rules
$kv.NetworkAcls | Format-List
Write-Host "Default Action: $($kv.NetworkAcls.DefaultAction)"
Write-Host "Allowed IPs: $($kv.NetworkAcls.IpAddressRanges -join ', ')"
Write-Host "Allowed VNets: $($kv.NetworkAcls.VirtualNetworkResourceIds -join ', ')"
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az keyvault show --name "<key-vault-name>" \
  --query "properties.networkAcls.{DefaultAction:defaultAction, IpRules:ipRules[].value, VnetRules:virtualNetworkRules[].id}"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, search for **Key vaults**, and then select the key vault used by DES.
1. In the menu, select **Networking** to review the firewall rules and virtual network access.
1. Check whether the **Firewall** setting is set to **Allow public access from all networks** or restricted to specific networks.
1. If network access is restricted, verify that the destination virtual network or subnet is included in the allow list.
1. To check access policies, select **Access policies** (or **Access control (IAM)** if the vault uses Azure RBAC) and verify that the DES managed identity has the required key permissions.

---

For more information, see [Assign a Key Vault access policy](/azure/key-vault/general/assign-access-policy).

If the Key Vault restricts network access, add the destination virtual network or subnet to the allow list.

### Step 4: Retry move validation

After you restore the required permissions and network access, rerun the move validation to verify that DES can access the key. Then complete the move operation.

### Prevention

Ensure that you take the following preventative measures:

- Include customer-managed key and DES permission checks in your pre-move readiness gates. 
- Verify Key Vault access before you start the move operation.

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Move resources blocked by destination Azure Policy](move-resources-destination-policy-deny.md)
- [Server-side encryption of Azure Disk Storage](/azure/virtual-machines/disk-encryption)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
