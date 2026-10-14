---
title: Azure resource move fails with provider-specific validation error
description: Troubleshoot ResourceMoveProviderValidationFailed and provider-specific errors during Azure VM moves. Follow guided fixes to resolve the error and complete the move.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/14/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure resource move fails with provider-specific validation error

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs :heavy_check_mark: All resource types

## Summary

This article helps you troubleshoot the `ResourceMoveProviderValidationFailed` error and other provider-specific validation errors that can occur when you move Azure virtual machine (VM) resources. It provides guidance to identify the root cause and resolve the issue to successfully complete the move.

## Symptoms

A move operation fails and returns an error message that resembles the following example.

```
ResourceMoveProviderValidationFailed: Resource move validation failed. Please see details.
Diagnostic information: timestamp '20260410T201210Z', subscription id '<id>', tracking id '<tracking-id>'
```

The error message doesn't specify which provider or property failed validation. This lack of detail makes diagnosis difficult.

> [!NOTE]
> If you see `ResourceValidationFailed` mentioned instead of this error, see [Troubleshoot ResourceValidationFailed during virtual machine moves](move-resources-troubleshoot-validation-failed-dispatcher.md) for a guided diagnostic flowchart.

## Cause

`ResourceMoveProviderValidationFailed` is a generic error that occurs when a resource provider (such as Microsoft.Compute, Microsoft.Network, or Microsoft.Storage) rejects the resource configuration during move validation.

Common causes include the following items:

- **Compute provider** - Virtual machine size is incompatible, extensions are in a failed state, or managed disk constraints aren't met.
- **Network provider** - Network adapter configuration is invalid, public IP or load balancer mismatch exists, or network security group (NSG) rule conflicts exist.
- **Storage provider** - Disk type is unavailable, disk encryption settings are incompatible, or storage account quota is exceeded.
- **Web provider** - Web app binding conflicts or Secure Sockets Layer (SSL) certificate issues exist, or app service plan is incompatible.
- **Other providers** - Provider-specific constraints exist that aren't mentioned in the error message.

## High-volume signatures and where to start

Use the following table to go directly from detail code to first action.

| Error signature | Typical meaning | First action |
|---|---|---|
| `MoveResourcesNotSupported` | Resource type or topology doesn't support move | Verify move limitations for that resource type. If unsupported, use the redeploy path. |
| `MissingMoveDependentResources` | Required dependency not included in move set | Add dependent resources (for example, virtual network (vNet), network adapter, public IP, NSG, or disks) to the same move batch. |
| `CannotMoveResource` | Resource has provider-specific move constraint | Check provider limitations and unsupported properties, then retry. |
| `MoveResourcesHavePendingOperations` | Ongoing operation blocks move validation | Wait for pending operations to finish. Retry with backoff. |
| `MoveCannotProceedWithResourcesNotInSucceededState` | One or more dependencies aren't in `Succeeded` state | Fix failed or updating dependencies first, then rerun validation. |
| `MissingRegistrationsForTypes` | Destination subscription missing resource provider registration | Register required resource providers before a retry. |

## Resolution

### Step 1: Enable detailed logging

Use Azure PowerShell or Azure CLI to capture the full diagnostic context from the move operation.

# [Azure portal](#tab/portal)

Capturing and correlating move error diagnostics (tracking IDs, timestamps, and activity log queries) isn't available in the [Azure portal](https://portal.azure.com). To collect this information, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
# Capture detailed error information
$errorInfo = @{
  TrackingId = "<tracking-id-from-error>"
  Timestamp = "<timestamp-from-error>"
  SubscriptionId = "<subscription-id-from-error>"
}

Write-Host "Captured diagnostic info:"
$errorInfo | ConvertTo-Json
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
# Check activity log for the move failure
az monitor activity-log list \
  --correlation-id "<correlation-id-from-error>" \
  --query "[].{Time:eventTimestamp, Resource:resourceId, Status:status.value, Error:properties.statusMessage}" \
  --output table
```

---

### Step 2: Check activity log for the failed move

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to query the activity log for detailed error information:

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Resource groups** and then select the source resource group.
1. In the menu, select **Activity log**.
1. Set the **Timespan** filter to cover the time of the failed move.
1. In the **Operation** filter, search for **Move Resources** or filter by **Status** = **Failed**.
1. Select the failed entry to view the error code and error message in the details pane.

For more information, see [View and retrieve the activity log](/azure/azure-monitor/essentials/activity-log#view-and-retrieve-the-activity-log).

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$activityLogs = Get-AzActivityLog -StartTime (Get-Date).AddHours(-1) |
  Where-Object { $_.OperationName.Value -like "*moveResources*" -and $_.Status.Value -eq "Failed" }

$activityLogs | ForEach-Object {
  Write-Host "Operation: $($_.OperationName.Value)"
  Write-Host "Error Code: $($_.Error.Code)"
  Write-Host "Error Message: $($_.Error.Message)"
  Write-Host "Time: $($_.EventTimestamp)"
}
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az monitor activity-log list \
  --start-time $(date -u -d '1 hour ago' '+%Y-%m-%dT%H:%M:%SZ') \
  --query "[?contains(operationName.value, 'moveResources') && status.value=='Failed'].{Op:operationName.value, Error:properties.statusMessage, Time:eventTimestamp}" \
  --output table
```

---

### Step 3: Verify by resource provider

Use Azure PowerShell or Azure CLI to check each resource provider's constraints.

**For compute provider (VMs and disks)**

# [Azure portal](#tab/portal)

The portal doesn't offer a way to run compute-specific move validation queries, such as VM size support, extension states, and disk configurations. To validate compute resources, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<source-rg>" -Name "<vm-name>"
Get-AzComputeResourceSku -Location "<destination-region>" |
  Where-Object { $_.Name -eq $vm.HardwareProfile.VmSize }
$vm.Extensions | Where-Object { $_.ProvisioningState -ne "Succeeded" }
$vm.StorageProfile.OsDisk
$vm.StorageProfile.DataDisks | Select-Object VhsUri, ManagedDisk, DiskSizeGB
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
az vm show --resource-group "<source-rg>" --name "<vm-name>" \
  --query "{Size:hardwareProfile.vmSize, Extensions:resources[].{Name:name,State:provisioningState}, OsDisk:storageProfile.osDisk.managedDisk, DataDisks:storageProfile.dataDisks[].{Name:name,Size:diskSizeGb}}"

az vm list-skus --location "<destination-region>" --size "<vm-size>" --output table
```

---

**For network provider (network interface cards and IPs)**

# [Azure portal](#tab/portal)

The portal doesn't offer a way to run network-specific move validation queries, such as queries for network interface card (NIC) IP configurations, accelerated networking, and IP forwarding. To validate network resources, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$nic = Get-AzNetworkInterface -ResourceId $vm.NetworkProfile.NetworkInterfaces[0].Id
$nic.IpConfigurations | Select-Object Name, PrivateIpAddress, PublicIpAddress, Subnet
$nic | Select-Object EnableAcceleratedNetworking, EnableIPForwarding
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az network nic show --ids "<nic-resource-id>" \
  --query "{IpConfigs:ipConfigurations[].{Name:name,IP:privateIpAddress,Subnet:subnet.id}, AccNet:enableAcceleratedNetworking, IPFwd:enableIPForwarding}"
```

---

**For storage provider (disks)**

# [Azure portal](#tab/portal)

The Azure portal doesn't run storage-specific move validation queries (disk SKU type, encryption type, and size) programmatically. To validate disk resources, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$disk = Get-AzDisk -ResourceGroupName "<source-rg>" -DiskName "<disk-name>"
Write-Host "Type: $($disk.Sku.Name) | Encryption: $($disk.Encryption.Type) | Size: $($disk.DiskSizeGB)GB"
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az disk show --resource-group "<source-rg>" --name "<disk-name>" \
  --query "{SKU:sku.name, Encryption:encryption.type, SizeGB:diskSizeGb}"
```

---

### Step 4: Contact Microsoft Support to provide diagnostic information

If the root cause isn't clear, use the Azure portal, Azure PowerShell, or Azure CLI to gather diagnostic information for a Microsoft Support request.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to **Resource groups** > source resource group > **Activity log**.
1. Filter by the correlation ID from the error message.
1. Export the activity log entries to share with Microsoft Support.

For more information, see [Manage resource groups in the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$diagnostics = @{
  TrackingId = "<tracking-id>"
  SubscriptionId = "<sub-id>"
  SourceRG = "<source-rg>"
  DestinationRG = "<destination-rg>"
}
$diagnostics | ConvertTo-Json -Depth 5 | Set-Content -Path "c:\temp\move-diagnostics.json"
Write-Host "Diagnostics saved to c:\temp\move-diagnostics.json"
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az monitor activity-log list \
  --correlation-id "<correlation-id>" \
  --query "[].{Time:eventTimestamp, Op:operationName.value, Status:status.value, Error:properties.statusMessage}" \
  --output json > move-diagnostics.json
```

---

### Step 5: Mitigate and retry

Use Azure PowerShell or Azure CLI to apply the following common mitigations based on what you found in [Step 3](#step-3-verify-by-resource-provider).

# [Azure portal](#tab/portal)

Retrying a move operation with prevalidation mitigations (removing extensions, updating NIC settings) and diagnostic logging isn't available in the Azure portal. To apply mitigations and retry, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
# Remove problematic extensions
Remove-AzVMExtension -ResourceGroupName "<source-rg>" -VMName "<vm-name>" -Name "<ext-name>" -Force

# Disable accelerated networking if unsupported
$nic = Get-AzNetworkInterface -ResourceId $vm.NetworkProfile.NetworkInterfaces[0].Id
$nic.EnableAcceleratedNetworking = $false
Set-AzNetworkInterface -NetworkInterface $nic

# Retry the move
Move-AzResource -DestinationResourceGroupName "<destination-rg>" -ResourceId $vm.Id
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
# Remove problematic extensions
az vm extension delete --resource-group "<source-rg>" --vm-name "<vm-name>" --name "<ext-name>"

# Disable accelerated networking
az network nic update --resource-group "<source-rg>" --name "<nic-name>" --accelerated-networking false

# Retry the move
az resource move --destination-group "<destination-rg>" --ids "<vm-resource-id>"
```

---

### Step 6: Fix common detail-code blockers

Use the Azure portal, Azure PowerShell, or Azure CLI to register missing resource providers in the destination subscription, and verify that all dependency resources are healthy.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to **Subscriptions**, and then select the destination subscription.
1. In the menu, select **Resource providers**.
1. Search for the required providers, such as **Microsoft.Compute**, **Microsoft.Network**, or **Microsoft.Storage**.
1. Select each unregistered provider and then select **Register**.

To verify resource health, go to the source resource group, select **Resources**, and check that all resources show a provisioning state of **Succeeded**.

For more information, see [Register resource provider](/azure/azure-resource-manager/management/resource-providers-and-types#register-resource-provider-1).

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
Register-AzResourceProvider -ProviderNamespace "Microsoft.Compute"
Register-AzResourceProvider -ProviderNamespace "Microsoft.Network"
Register-AzResourceProvider -ProviderNamespace "Microsoft.Storage"

Get-AzResource -ResourceGroupName "<source-rg>" |
  Select-Object Name, ResourceType, ProvisioningState |
  Where-Object { $_.ProvisioningState -ne "Succeeded" }
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
az provider register --namespace "Microsoft.Compute"
az provider register --namespace "Microsoft.Network"
az provider register --namespace "Microsoft.Storage"

az resource list --resource-group "<source-rg>" \
  --query "[?provisioningState!='Succeeded'].{Name:name, Type:type, State:provisioningState}" --output table
```

---

If any dependency isn't listed as `Succeeded`, fix it before you rerun the move.

### Prevention

Ensure that you take the following preventative measures:

- **Pre-validate** - Always test moves in a nonproduction environment first.
- **Use Azure Resource Mover** - The Azure Resource Mover portal provides clearer validation messages.
- **Check provider documentation** - Review each resource provider's move limitations.
- **Monitor diagnostic logging** - Enable diagnostics to capture provider-specific errors.

## References

- [Troubleshoot resource provider validation failures](/azure/azure-resource-manager/troubleshooting)
- [Resource move limitations by resource type](/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)
- [Use Azure Resource Mover for complex operations](/azure/resource-mover/overview)
- [Move fails because dependencies must move together](move-resources-vnet-dependencies-must-move-together.md)
- [Move fails because resources aren't in succeeded state](move-resources-request-conflict-provisioning-state-not-terminal.md)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
