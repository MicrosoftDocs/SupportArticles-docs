---
title: Azure VM move fails with resource validation errors
description: Troubleshoot Azure VM move failures caused by resource validation errors. Learn how to resolve disk, network adapter, and extension conflicts.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/21/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure vritual machine move fails with resource validation errors

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article helps you troubleshoot Azure virtual machine (VM) move failures that resource validation errors cause. These errors occur if the VM or its associated resources don't meet the requirements of the destination region or subscription.

## Symptoms

A move operation fails and returns an error message that resembles the following examples.

```
ResourceOperationFailure: The resource operation completed with terminal provisioning state 'Failed'.
Details: ResourceValidationFailed
```

```
ResourceSettingsValidationFailed: Resource settings validation failed.
```

The validation error prevents the move from proceeding, but the error message doesn't clearly document the specific validation rule that failed.

## Cause

Resource validation can fail for several of the following reasons during move operations:

- **Disk constraints** - Managed or unmanaged disk configuration create conflicts between source and destination.
- **VM size incompatibility** - The destination region or subscription doesn't support the source VM size.
- **Network adapter configuration** - Network adapter cards have unsupported configurations, like IP forwarding or primary or secondary network interface card (NIC) mismatch.
- **Extension conflicts** - VM extensions aren't compatible with destination region or VM size.
- **Feature flag mismatch** - Subscription-level features (for example, Azure Accelerated Networking or Azure Ultra Disk) aren't enabled in the destination.
- **SKU restrictions** - Destination subscription has SKU restrictions that block the resource type.
- **Azure Marketplace image** - Image terms not accepted in destination subscription.

## Resolution

### Step 1: Retrieve the detailed validation error

Use Azure PowerShell or Azure CLI to enable verbose logging so you can see the specific validation rule that failed.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$moveOp = Get-AzResourceMoverMoveCollection -Name "<collection>" -ResourceGroupName "<rg>"
$failedResources = $moveOp.Resources | Where-Object { $_.ProvisioningState -eq "Failed" }

foreach ($resource in $failedResources) {
  Write-Host "Resource: $($resource.Id)"
  Write-Host "Error: $($resource.ErrorDetails)"
}
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az monitor activity-log list \
  --correlation-id "<correlation-id-from-error>" \
  --query "[?status.value=='Failed'].{Resource:resourceId, Error:properties.statusMessage}" \
  --output table
```

# [Azure portal](#tab/portal)

Retrieving detailed move validation error messages with structured status codes isn't available in the [Azure portal](https://portal.azure.com). The portal shows only summary errors. To get full error details, use Azure PowerShell or Azure CLI.

---

### Step 2: Check disk and VM size compatibility

Use Azure PowerShell or Azure CLI to verify that the destination region supports the source VM configuration.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzComputeResourceSku -Location "<destination-region>" |
  Where-Object { $_.ResourceType -eq "virtualMachines" -and $_.Name -like "*<source-vm-size>*" } |
  Select-Object Name, Locations
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm list-skus --location "<destination-region>" --size "<source-vm-size>" \
  --query "[].{Name:name, Zones:locationInfo[].zones}" --output table
```

# [Azure portal](#tab/portal)

The Azure portal doesn't support querying VM size availability or capability details by region. To check whether a specific size is available at the destination, use Azure PowerShell or Azure CLI.

---

### Step 3: Resolve network adapter configuration issues

Network interface validation failures often involve IP configuration mismatches.

Use Azure PowerShell or Azure CLI to inspect and modify network interface configurations.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$nic = Get-AzNetworkInterface -ResourceGroupName "<rg>" -Name "<nic-name>"
$nic | Select-Object Name, EnableIPForwarding, EnableAcceleratedNetworking

# Disable IP forwarding if misconfigured
$nic.EnableIPForwarding = $false
Set-AzNetworkInterface -NetworkInterface $nic
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
az network nic show --resource-group "<rg>" --name "<nic-name>" \
  --query "{Name:name, IPForwarding:enableIPForwarding, AccNet:enableAcceleratedNetworking}"

# Disable IP forwarding
az network nic update --resource-group "<rg>" --name "<nic-name>" --ip-forwarding false
```

# [Azure portal](#tab/portal)

Querying and updating NIC configuration properties such as IP forwarding and accelerated networking in a single diagnostic pass isn't available in the Azure portal. To inspect and fix these settings, use Azure PowerShell or Azure CLI.

---

### Step 4: Verify extension compatibility

Use Azure PowerShell or Azure CLI to remove or update extensions that might not be supported in the destination.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<rg>" -Name "<vm-name>"
$vm.Extensions | Select-Object Name, Type, ProvisioningState
Remove-AzVMExtension -ResourceGroupName "<rg>" -VMName "<vm-name>" -Name "<extension-name>" -Force
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
az vm extension list --resource-group "<rg>" --vm-name "<vm-name>" \
  --query "[].{Name:name, State:provisioningState}" --output table

az vm extension delete --resource-group "<rg>" --vm-name "<vm-name>" --name "<extension-name>"
```

# [Azure portal](#tab/portal)

Listing all VM extensions with provisioning states and force-removing incompatible extensions in a single workflow isn't available in the Azure portal. To audit and remove extensions programmatically, use Azure PowerShell or Azure CLI.

---

### Step 5: Enable destination subscription features

If the destination subscription lacks required features, use Azure PowerShell or Azure CLI to enable them. 

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Register-AzProviderFeature -FeatureName "AcceleratedNetworkingForAllVMs" -ProviderNamespace "Microsoft.Network"
Register-AzResourceProvider -ProviderNamespace "Microsoft.Compute"
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az feature register --namespace "Microsoft.Network" --name "AcceleratedNetworkingForAllVMs"
az provider register --namespace "Microsoft.Compute"
```

# [Azure portal](#tab/portal)

The Azure portal doesn't support programmatically registering subscription feature flags and resource providers. To enable the required features in the destination subscription, use Azure PowerShell or Azure CLI.

---

### Step 6: Accept Marketplace terms in destination subscription

If the VM uses a Marketplace image, use Azure PowerShell or Azure CLI to accept the image plan.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<rg>" -Name "<vm-name>"
if ($vm.Plan) {
  Set-AzMarketplaceTerms -Accept -Publisher $vm.Plan.Publisher -Product $vm.Plan.Product -Name $vm.Plan.Name
}
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm show --resource-group "<rg>" --name "<vm-name>" --query "plan"
# If plan exists:
az vm image terms accept --publisher "<publisher>" --offer "<product>" --plan "<name>"
```

# [Azure portal](#tab/portal)

The Azure portal doesn't support accepting Marketplace image terms in a destination subscription. To accept terms programmatically, use Azure PowerShell or Azure CLI.

---

### Step 7: Retry the move

After you resolve validation issues, use Azure PowerShell or Azure CLI to restart the move.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Move-AzResource -DestinationResourceGroupName "<destination-rg>" `
  -ResourceId "/subscriptions/<sub-id>/resourceGroups/<source-rg>/providers/<resource-type>/<resource-name>"
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource move --destination-group "<destination-rg>" \
  --ids "/subscriptions/<sub-id>/resourceGroups/<source-rg>/providers/<resource-type>/<resource-name>"
```

# [Azure portal](#tab/portal)

You can't retry a move operation by specifying the full resource ID in the Azure portal. To retry the move after resolving validation issues, use Azure PowerShell or Azure CLI.

---

### Prevention

Ensure that you take the following preventative measures:

- **Pre-flight validation** - Always test move operations in a non-production environment first.
- **Feature parity** - Make sure that the destination subscription has the same feature flags as the source.
- **Extension eligibility** - Audit and remove unnecessary extensions before you process a move.
- **Size availability** - Verify that the destination region supports target VM sizes before you plan the move.

## References

- [Troubleshoot VM extension deployment failures](/azure/virtual-machines/extensions/troubleshoot)
- [Check resource SKU availability by region](/azure/virtual-machines/regions)
- [Resolve virtual machine sizing constraints during move](move-resources-resize-blocked-disk-constraints.md)
- [Move fails because VM extensions are in failed state](move-resources-extension-failed-state.md)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
