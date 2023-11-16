---
title: Virtual machine stuck in failed state
description: Resolves issues in which a virtual machine (VM) is stuck in a failed state. 
services: virtual-machines
author: mimckitt
manager: dcscontentpm
tags: azure-resource-manager
ms.service: virtual-machines
ms.subservice: vm-common-errors-issues
ms.topic: troubleshooting
ms.date: 10/04/2021
ms.author: mimckitt
---

# Virtual machine stuck in a failed state

This article provides steps to resolve issues in which a Microsoft Azure virtual machine (VM) is stuck in a failed state.

## Symptoms

The VM status in the Azure portal is shown as **Failed**.

## Cause

The last operation that was run on the VM failed after the input was accepted.

## Resolution

> [!NOTE]
> This resolution is supported only for API version "2019-07-01" or a later version.

### [Portal](#tab/portal)

Update the VM objects and properties by running the `reapply` command in the Azure portal:

1. Navigate to the VM that's stuck in the **Failed** state.
1. Under **Support + troubleshooting**, select **Redeploy + reapply**.
1. Select the **Reapply** option.

:::image type="content" source="./media/troubleshoot-vm-reapply/vm-reapply-portal.png" alt-text="Screenshot of the region options that shows the difference in pricing and eviction rates as a table.":::

### [CLI](#tab/cli)

Update the VM objects and properties by running the [az vm reapply](/cli/azure/vm#az-vm-reapply) command:

```azurecli-interactive
az vm reapply -g MyResourceGroup -n MyVm
```

### [PowerShell](#tab/powershell)

Update the VM objects and properties by running the [Update-AzVM](/powershell/module/az.compute/update-azvm?view=azps-6.5.0#examples&preserve-view=true) command after you apply the reapply parameter:

```azurepowershell-interactive
Get-AzVM -ResourceGroupName <ResourceGroup> -Name <VMName>
Set-AzVM -ResourceGroupName <ResourceGroup> -Name <VMName> -Reapply
Update-AzVM -VM <VMName> -ResourceGroupName <ResourceGroupName>

```

### [REST](#tab/rest)

Update the VM objects and properties by running the [reapply](/rest/api/compute/virtual-machines/reapply) command:

```rest
POST https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/reapply?api-version=2021-07-01
```

---

## Next steps

If `reapply` doesn't clear the VM **Failed** state, try [redeploying to a new host node](redeploy-to-new-node-linux.md).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
