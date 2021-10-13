---
title: Virtual machine stuck in failed state
description: This article provides steps to resolve issues where the virtual machine (VM) is stuck in a failed state. 
services: virtual-machines
author: mimckitt
manager: dcscontentpm
tags: azure-resource-manager
ms.service: virtual-machines
ms.topic: troubleshooting
ms.date: 10/4/2021
ms.author: mimckitt
---

# Virtual machine stuck in a failed state

This article provides steps to resolve issues where the virtual machine (VM) is stuck in a failed state.

## Symptom
Virtual Machine (VM) status in the Azure portal is marked as “Failed”. 
## Cause
Last operation against the Virtual Machine (VM) failed after the input was accepted.
## Solution

### [Portal](#tab/portal)
Update the VM objects and properties by running the reapply command in the Azure portal
1. Navigate to the VM that is stuck in the failed state.
1. Under **Support + troubleshooting**, select **Redeploy + reapply**.
1. Select the **Reapply** option.
:::image type="content" source="./media/troubleshoot-vm-reapply/vm-reapply-portal.png" alt-text="Screenshot of the region options with the difference in pricing and eviction rates as a table.":::

### [CLI](#tab/cli)
Update the VM objects and properties by running the [az vm update](https://docs.microsoft.com/cli/azure/vm?view=azure-cli-latest#az_vm_update) command.
```cli
az vm update -n <VMName> -g <ResourceGroupname>
```

### [PowerShell](#tab/powershell)
Update the VM objects and properties by running the [update-AzVM](https://docs.microsoft.com/powershell/module/az.compute/update-azvm?view=azps-6.5.0) command.

```powershell
Update-AzVM  -ResourceGroupName <ResourceGroupName> -VM <VMName>
```

### [REST](#tab/rest)

Update the VM objects and properties by running the [reapply](https://docs.microsoft.com/rest/api/compute/virtual-machines/reapply) command.
 
```rest
POST https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/reapply?api-version=2021-07-01
```
---


## Next steps
If using the [Reapply](https://docs.microsoft.com/rest/api/compute/virtual-machines/reapply) API was not able to clear the VM failed state, try [redploying to a new host node](redeploy-to-new-node-linux.md).
