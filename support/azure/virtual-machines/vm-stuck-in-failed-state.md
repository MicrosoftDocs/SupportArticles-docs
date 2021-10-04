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

Using the [Reapply](https://docs.microsoft.com/rest/api/compute/virtual-machines/reapply) REST API, you can push the latest goal state of Virtual Machine (VM) to correct the inconsistent state. 

```HTTP
POST https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/reapply?api-version=2021-07-01
```

### Example

```HTTPS
POST https://management.azure.com/subscriptions/1234567-1234-1234-1234-1232456789abc/resourceGroups/ResourceGroup/providers/Microsoft.Compute/virtualMachines/VMName/reapply?api-version=2021-07-01
```

### Responses

| Name | Type | Description | 
|---|---|---|
| 200 OK | | OK |
| 202 Accepted | Accepted | 
| Other Status Codes | [CloudError](https://docs.microsoft.com/rest/api/compute/virtual-machines/reapply#clouderror) | Error response describing why the operation failed. | 

## Next steps
If using the [Reapply](https://docs.microsoft.com/rest/api/compute/virtual-machines/reapply) API was not able to clear the VM failed state, try [redploying to a new host node](redeploy-to-new-node-linux.md).