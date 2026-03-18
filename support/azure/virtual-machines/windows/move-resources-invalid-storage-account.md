---
title: Move fails because VM is associated with an invalid or deleted storage account
description: Troubleshoot the MoveResourcesHaveInvalidState error when a virtual machine's boot diagnostics storage account no longer exists.
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

# Move fails because VM is associated with an invalid or deleted storage account

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Symptoms

When you try to move a virtual machine (and its associated resources) to another resource group or subscription, the operation fails with an error similar to:

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

The virtual machine has a **Boot Diagnostics** storage account configured that either:

- Has been **deleted** from the subscription
- Is in an **invalid or failed state**

Even though the storage account no longer exists, the VM's configuration still references it. Azure Resource Manager validates all referenced resources before starting the move operation, causing the move to fail at the validation step.

## Resolution

Reconfigure the VM's boot diagnostics to either disable it or point it to a valid storage account.

### Option 1: Disable boot diagnostics (quickest)

1. In the [Azure portal](https://portal.azure.com), navigate to the VM.
2. Under **Settings**, select **Boot diagnostics**.
3. Select **Disable**.
4. Select **Apply**.
5. Retry the move operation.

### Option 2: Update boot diagnostics to a valid storage account

1. In the [Azure portal](https://portal.azure.com), navigate to the VM.
2. Under **Settings**, select **Boot diagnostics**.
3. Select **Enable with custom storage account**.
4. Select an existing, valid storage account in the same region as the VM.
5. Select **Apply**.
6. Retry the move operation.

### Option 3: Use Azure CLI or PowerShell

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

## Verify the storage account reference

To confirm which storage account is referenced and whether it still exists, run:

```azurecli
az vm show --resource-group <rg-name> --name <vm-name> \
  --query "diagnosticsProfile.bootDiagnostics" \
  --output json
```

If the `storageUri` field points to a storage account that no longer exists, use one of the resolution options above before retrying the move.

## Next steps

- [Azure boot diagnostics](/azure/virtual-machines/boot-diagnostics)
- [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Move fails with MissingMoveDependentResources](move-resources-missing-dependencies.md)
