---
title: Virtual machine move fails with invalid storage account
description: Troubleshoot MoveResourcesHaveInvalidState errors if a VMs boot diagnostics storage account is deleted or invalid. Learn how to resolve this issue quickly.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/10/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:Cannot create a VM
ai-usage: ai-assisted
---

# Virtual machine move fails with invalid storage account

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article helps you troubleshoot the `MoveResourcesHaveInvalidState` error if a virtual machine (VM) move fails because of an invalid or deleted storage account. When you move a VM that has boot diagnostics configured to a deleted or invalid storage account, Azure Resource Manager (ARM) blocks the operation. To resolve the issue, reconfigure the VM's boot diagnostics to either disable it or point it to a valid storage account.

## Symptoms

When you try to move a VM and its associated resources to another resource group or subscription, the operation fails and returns an error message that resembles the following message.

```json
{
  "code": "ResourceMoveProviderValidationFailed",
  "message": "Resource move validation failed.",
  "details": [
    {
      "code": "MoveResourcesHaveInvalidState",
      "target": "Microsoft.Compute/virtualMachines",
      "message": "The Move Resources request contains VMs which are associated with invalid storage accounts. Please check details for these resource ids and referenced storage account names.",
      "details": [
        {
          "code": "MoveResourcesHaveInvalidState",
          "target": "/subscriptions/<sub-id>/resourceGroups/<rg-name>/providers/Microsoft.Compute/virtualMachines/<vm-name>",
          "message": "Storage Account '<storage-account-name>' either does not exist or is in an invalid state."
        }
      ]
    }
  ]
}
```

## Cause

The VM has a boot diagnostics storage account configured. This account has either of the following conditions:

- You deleted it from the subscription.
- It's in an **invalid** or **failed** state.

Even though the storage account no longer exists, the VM configuration still references it. ARM validates all referenced resources before it starts the move operation. This action causes the move to fail at the validation step.

## Resolution

Reconfigure the VM's boot diagnostics to either disable it or point it to a valid storage account.

### Option 1: Disable boot diagnostics (quickest)

Use the [Azure portal](https://portal.azure.com), Azure CLI, or Azure PowerShell to disable boot diagnostics.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the VM.
1. Under **Settings**, select **Boot diagnostics**.
1. Select **Disable**.
1. Select **Apply**.
1. Retry the move operation.

For more information, see [Boot diagnostics for VMs](/azure/virtual-machines/boot-diagnostics).

# [Azure CLI](#tab/cli)

Run this command.

```azurecli
az vm boot-diagnostics disable --resource-group "<rg-name>" --name "<vm-name>"
```

# [Azure PowerShell](#tab/powershell)

Run this command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>"
Set-AzVMBootDiagnostic -VM $vm -Disable
Update-AzVM -ResourceGroupName "<rg-name>" -VM $vm
```

---

### Option 2: Update boot diagnostics to a valid storage account

Use the Azure portal, Azure CLI, or Azure PowerShell to update the VM's boot diagnostics to a valid storage account.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to the VM.
1. In **Settings**, select **Boot diagnostics**.
1. Select **Enable with custom storage account**.
1. Select an existing, valid storage account in the same region as the VM.
1. Select **Apply**.
1. Retry the move operation.

For more information, see [Boot diagnostics for VMs](/azure/virtual-machines/boot-diagnostics).

# [Azure CLI](#tab/cli)

Run this command.

```azurecli
az vm boot-diagnostics enable \
  --resource-group "<rg-name>" \
  --name "<vm-name>" \
  --storage "<storage-account-uri>"
```

# [Azure PowerShell](#tab/powershell)

Run this command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>"
Set-AzVMBootDiagnostic `
  -VM $vm `
  -Enable `
  -ResourceGroupName "<rg-name>" `
  -StorageUri "<storage-account-uri>"
Update-AzVM -ResourceGroupName "<rg-name>" -VM $vm
```

---

### Verify the storage account reference

Use Azure PowerShell or Azure CLI to determine which storage account the VM references and whether it still exists.

# [Azure portal](#tab/portal)

The Azure portal doesn't support querying VM boot diagnostics storage account configuration programmatically. To check the storage Uniform Resource Identifier (URI), use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run this command.

```azurepowershell
(Get-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>").DiagnosticsProfile.BootDiagnostics |
  ConvertTo-Json -Depth 10
```

# [Azure CLI](#tab/cli)

Run this command.

```azurecli
az vm show --resource-group "<rg-name>" --name "<vm-name>" \
  --query "diagnosticsProfile.bootDiagnostics" --output json
```

---

If the `storageUri` field points to a storage account that no longer exists, use one of the resolution options in this article before you retry the move.

## References

- [Azure boot diagnostics](/azure/virtual-machines/boot-diagnostics)
- [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Move fails with MissingMoveDependentResources](move-resources-missing-dependencies.md)
