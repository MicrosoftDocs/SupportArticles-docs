---
title: Virtual machine move fails with invalid storage account
description: Troubleshoot MoveResourcesHaveInvalidState errors when a VM's boot diagnostics storage account is deleted or invalid. Learn how to resolve this issue quickly.
services: virtual-machines
author: scotro
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 03/18/2026
ms.author: scotro
ms.reviewer: jarrettr
ms.custom: sap:Cannot create a VM
---

# Virtual machine move fails with invalid storage account

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article helps you troubleshoot the `MoveResourcesHaveInvalidState` error when a virtual machine (VM) move fails due to an invalid or deleted storage account. When moving a virtual machine with boot diagnostics configured to a deleted or invalid storage account, Azure Resource Manager blocks the operation. Reconfigure the VM's boot diagnostics to either disable it or point it to a valid storage account to resolve the issue.

## Symptoms

When you try to move a VM and its associated resources to another resource group or subscription, the operation fails with an error similar to:

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

The VM has a boot diagnostics storage account configured that either:

- You deleted from the subscription.
- Is in an **invalid** or **failed** state.

Even though the storage account no longer exists, the VM's configuration still references it. Azure Resource Manager validates all referenced resources before starting the move operation, causing the move to fail at the validation step.

## Resolution

Reconfigure the VM's boot diagnostics to either disable it or point it to a valid storage account.

### Option 1: Disable boot diagnostics (quickest)

1. In the [Azure portal](https://portal.azure.com), go to the VM.
1. Under **Settings**, select **Boot diagnostics**.
1. Select **Disable**.
1. Select **Apply**.
1. Retry the move operation.

### Option 2: Update boot diagnostics to a valid storage account

1. In the [Azure portal](https://portal.azure.com), go to the VM.
1. Under **Settings**, select **Boot diagnostics**.
1. Select **Enable with custom storage account**.
1. Select an existing, valid storage account in the same region as the VM.
1. Select **Apply**.
1. Retry the move operation.

### Option 3: Use Azure CLI or Azure PowerShell

**Azure CLI — disable boot diagnostics:**

```azurecli
az vm boot-diagnostics disable --resource-group <rg-name> --name <vm-name>
```

**Azure CLI — enable with a valid storage account:**

```azurecli
az vm boot-diagnostics enable \
  --resource-group <rg-name> \
  --name <vm-name> \
  --storage <storage-account-uri>
```

**Azure PowerShell — disable boot diagnostics:**

```powershell
$vm = Get-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>"
Set-AzVMBootDiagnostic -VM $vm -Disable
Update-AzVM -ResourceGroupName "<rg-name>" -VM $vm
```

**Azure PowerShell — enable with a valid storage account:**

```powershell
$vm = Get-AzVM `
  -ResourceGroupName <rg-name> `
  -Name <vm-name>
Set-AzVMBootDiagnostic `
  -VM $vm `
  -Enable `
  -ResourceGroupName <rg-name> `
  -StorageUri <storage-account-uri>
```

> [!NOTE]
> After running `Set-AzVMBootDiagnostic`, you must update the VM for the change to take effect.

**Azure PowerShell — update the VM:**

```powershell
Update-AzVM `
  -ResourceGroupName <rg-name> `
  -VM $vm
```

**Azure PowerShell — verify the storage account reference:**

```powershell
(Get-AzVM `
  -ResourceGroupName <rg-name> `
  -Name <vm-name>).DiagnosticsProfile.BootDiagnostics | ConvertTo-Json -Depth 10
```

## Verify the storage account reference

To confirm which storage account is referenced and whether it still exists, run:

```azurecli
az vm show --resource-group <rg-name> --name <vm-name> \
  --query "diagnosticsProfile.bootDiagnostics" \
  --output json
```

If the `storageUri` field points to a storage account that no longer exists, use one of the resolution options in this article before retrying the move.

## Next steps

- [Azure boot diagnostics](/azure/virtual-machines/boot-diagnostics)
- [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Move fails with MissingMoveDependentResources](move-resources-missing-dependencies.md)
