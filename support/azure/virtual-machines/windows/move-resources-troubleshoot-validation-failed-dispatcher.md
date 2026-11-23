---
title: Troubleshoot ResourceValidationFailed error message during Azure VM moves
description: Troubleshoot ResourceValidationFailed errors during Azure VM moves by identifying the resource incompatibility, then use these steps to fix and retry.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/18/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Troubleshoot ResourceValidationFailed error message during Azure VM moves

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article provides a diagnostic guide to help you identify which specific resource incompatibility is causing `ResourceValidationFailed` errors during Azure virtual machine (VM) moves. It covers common causes, symptoms, and step-by-step troubleshooting instructions to help you resolve the issue and successfully move your VM.

## Symptoms

A move operation fails and returns an error message that resembles the following example:

```
ResourceOperationFailure: The resource operation completed with terminal provisioning state 'Failed'.
Details: ResourceValidationFailed
```

The validation error message doesn't specify which resource property or constraint failed. Therefore, it can be difficult to identify the root cause.

## Cause

`ResourceValidationFailed` is a generic error message that indicates Azure Resource Manager (ARM) validation rejected the resource configuration for the destination scope. The underlying cause can be any of the following conditions:

- Resource type not supported in destination region
- VM size unavailable in destination
- Disk type (Azure Standard SSD, Azure Premium SSD, or Azure Ultra Disk) not supported
- VM feature (accelerated networking, ephemeral OS disk) not available
- Network interface configuration incompatible
- Marketplace image plan not accepted in destination subscription
- Extension requirements not met in destination

`ResourceValidationFailed` appears when ARM validates the resource configuration for the destination scope. Use the diagnostic steps in this article to identify the specific blocker.

`ResourceMoveProviderValidationFailed` appears when a specific resource provider (like Microsoft.Compute, Microsoft.Network, and others) rejects the move. For detailed provider-level diagnostics, see [Troubleshoot provider-specific validation errors](move-resources-provider-validation-failed.md).

### Diagnostic steps

#### Step 1: Check destination region support

Use Azure PowerShell or Azure CLI to verify that the destination supports the source resource type and VM size.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$sourceVm = Get-AzVM -ResourceGroupName "<source-rg>" -Name "<vm-name>"
$sourceSize = $sourceVm.HardwareProfile.VmSize

# Check if size exists in destination
Get-AzComputeResourceSku -Location "<destination-region>" |
  Where-Object { $_.ResourceType -eq "virtualMachines" -and $_.Name -eq $sourceSize }
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
# Get the source VM size
vmSize=$(az vm show --resource-group "<source-rg>" --name "<vm-name>" --query "hardwareProfile.vmSize" -o tsv)

# Check if it exists in destination
az vm list-skus --location "<destination-region>" --size "$vmSize" \
  --query "[].{Name:name, Zones:locationInfo[].zones}" --output table
```

# [Azure portal](#tab/portal)

Querying compute resource SKU availability by region isn't available in the [Azure portal](https://portal.azure.com). To check whether a specific VM size is available at the destination, use Azure PowerShell or Azure CLI.

---

> [!NOTE]
> If the destination isn't found, see [Move blocked by unavailable virtual machine size at destination](move-resources-resize-blocked-disk-constraints.md).

#### Step 2: Check attached disk support

Use Azure PowerShell or Azure CLI to verify that the destination supports all attached disk types.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<source-rg>" -Name "<vm-name>"
$disks = $vm.StorageProfile.OsDisk, $vm.StorageProfile.DataDisks | ForEach-Object {
  Get-AzDisk -ResourceGroupName $_.ManagedDisk.ResourceGroupName -DiskName $_.ManagedDisk.Id.Split('/')[-1]
}
$disks | ForEach-Object { Write-Host "Disk: $($_.Name), Type: $($_.Sku.Name)" }
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm show --resource-group "<source-rg>" --name "<vm-name>" \
  --query "{OsDisk:storageProfile.osDisk.{Name:name,SKU:managedDisk.storageAccountType}, DataDisks:storageProfile.dataDisks[].{Name:name,Size:diskSizeGb}}"
```

# [Azure portal](#tab/portal)

The Azure portal doesn't support querying disk SKU types and storage account types programmatically. To check attached disk compatibility, use Azure PowerShell or Azure CLI.

---

For Ultra Disk issues, see [Move blocked by Ultra Disk or Premium SSD v2 not available at destination](move-resources-ultra-disk-premium-ssd-v2-destination-not-supported.md).

For ephemeral OS disk issues, see [Move blocked by ephemeral OS disk not supported at destination](move-resources-ephemeral-os-disk-not-supported.md).

#### Step 3: Check network interface configuration

Use Azure PowerShell or Azure CLI to verify that network adapter settings are compatible with the destination.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<source-rg>" -Name "<vm-name>"
$nic = Get-AzNetworkInterface -ResourceId $vm.NetworkProfile.NetworkInterfaces[0].Id
Write-Host "Accelerated Networking: $($nic.EnableAcceleratedNetworking)"
Write-Host "IP Forwarding: $($nic.EnableIPForwarding)"
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
# Get NIC ID from VM
nicId=$(az vm show --resource-group "<source-rg>" --name "<vm-name>" --query "networkProfile.networkInterfaces[0].id" -o tsv)

az network nic show --ids $nicId \
  --query "{AccNet:enableAcceleratedNetworking, IPFwd:enableIPForwarding, IpConfigs:ipConfigurations[].privateIpAddressVersion}"
```

# [Azure portal](#tab/portal)

The Azure portal doesn't support querying network adapter properties, such as accelerated networking, IP forwarding, and IP configuration versions. To check these network interface card (NIC) settings, use Azure PowerShell or Azure CLI.

---

For accelerated networking issues, see [Move blocked by accelerated networking capability mismatch](move-resources-accelerated-networking-capability-mismatch.md).

For NIC IP configuration issues, see [Move blocked by NIC IP configuration dependency conflicts](move-resources-network-interface-ip-config-conflict.md).

#### Step 4: Check VM features

Use Azure PowerShell or Azure CLI to verify that the destination subscription supports the source VM features.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<source-rg>" -Name "<vm-name>"
if ($vm.SecurityProfile.EncryptionAtHost -eq $true) { Write-Host "Warning: Encryption at Host enabled." }
if ($vm.ProximityPlacementGroup.Id) { Write-Host "Warning: VM in PPG." }
if ($vm.Host.Id) { Write-Host "Warning: VM on dedicated host." }
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm show --resource-group "<source-rg>" --name "<vm-name>" \
  --query "{EncryptionAtHost:securityProfile.encryptionAtHost, PPG:proximityPlacementGroup.id, DedicatedHost:host.id}"
```

# [Azure portal](#tab/portal)

You can't query multiple VM feature flags (encryption at host, proximity placement group, and dedicated host) in a single check in the Azure portal. To inspect these properties together, use Azure PowerShell or Azure CLI.

---

For encryption at host issues, see [Move blocked by encryption at host not available at destination](move-resources-encryption-at-host-destination-constraint.md).

For proximity placement group issues, see [Move blocked by proximity placement group constraints](move-resources-proximity-placement-group-constraint.md).

For dedicated host issues, see [Move blocked by dedicated host or host group dependency](move-resources-dedicated-host-host-group-dependency.md).

#### Step 5: Check Azure Marketplace image

If you're using an Azure Marketplace image, use Azure PowerShell or Azure CLI to verify that you accept the terms in the destination.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<source-rg>" -Name "<vm-name>"
if ($vm.Plan) {
  Write-Host "Publisher: $($vm.Plan.Publisher), Product: $($vm.Plan.Product), Name: $($vm.Plan.Name)"
  $terms = Get-AzMarketplaceTerms -Publisher $vm.Plan.Publisher -Product $vm.Plan.Product -Name $vm.Plan.Name -ErrorAction SilentlyContinue
  if (-not $terms.Accepted) { Write-Host "ERROR: Terms not accepted in destination." }
}
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
az vm show --resource-group "<source-rg>" --name "<vm-name>" --query "plan"

# If plan exists, check terms
az vm image terms show --publisher "<publisher>" --offer "<product>" --plan "<name>"
```

# [Azure portal](#tab/portal)

Querying VM Marketplace plan metadata and checking term acceptance status isn't available in the Azure portal. To verify plan details and accept terms, use Azure PowerShell or Azure CLI.

---

For Marketplace image issues, see [Move blocked by Marketplace image terms not accepted in destination](move-resources-marketplace-terms-not-accepted-destination-subscription.md).

#### Step 6: Check VM extensions

Use Azure PowerShell or Azure CLI to verify that all installed extensions are compatible and check their provisioning states.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<source-rg>" -Name "<vm-name>"
$vm.Extensions | ForEach-Object { Write-Host "$($_.Name): $($_.ProvisioningState)" }
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm extension list --resource-group "<source-rg>" --vm-name "<vm-name>" \
  --query "[].{Name:name, State:provisioningState}" --output table
```

# [Azure portal](#tab/portal)

The Azure portal doesn't list all VM extensions with their provisioning states in a single programmatic query. To check extension compatibility across all installed extensions, use Azure PowerShell or Azure CLI.

---

For extension problems, see [Move blocked by VM extension in failed provisioning state](move-resources-extension-failed-state.md).

#### Step 7: Check disk encryption

Use Azure PowerShell or Azure CLI to verify that the encryption configuration is supported in the destination.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<source-rg>" -Name "<vm-name>"
$disk = Get-AzDisk -ResourceGroupName "<source-rg>" -DiskName $vm.StorageProfile.OsDisk.ManagedDisk.Id.Split('/')[-1]
Write-Host "Encryption: $($disk.Encryption.Type)"
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az disk show --resource-group "<source-rg>" --name "<os-disk-name>" \
  --query "{Encryption:encryption.type, DES:encryption.diskEncryptionSetId}"
```

# [Azure portal](#tab/portal)

The Azure portal doesn't support querying the disk encryption type and disk encryption set association programmatically. To check the encryption configuration, use Azure PowerShell or Azure CLI.

---

For Azure Disk Encryption problems, see [Move blocked by Azure Disk Encryption configuration](move-resources-azure-disk-encryption-blocked.md).

For customer‑managed keys (CMK) encryption problems, see [Move blocked by CMK Disk Encryption Set access denied](move-resources-cmk-disk-encryption-set-access-denied.md).

## Next steps

After you identify the specific validation failure, follow these steps:

1. Review the linked article for that specific blocker.
1. Follow the resolution steps to fix the incompatibility.
1. Retry the move after remediation.

## References

- [All move resource troubleshooting articles](move-resources-error-signature-triage-map.md)
- [Move resource limitations by service type](/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)
- [Check Azure resource availability by region](/azure/virtual-machines/regions)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
