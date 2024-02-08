---
title: Deletion of Virtual Machine Scale Set isn't allowed as it contains one or more VMs
description: Learn how to resolve the OperationNotAllowed error when you deploy a Virtual Machine Scale Set by using Flexible orchestration mode.
ms.date: 01/31/2023
ms.service: virtual-machine-scale-sets
ms.subservice: # troubleshoot-deletion-errors
ms.reviewer: mimckitt, v-leedennis
---
# "OperationNotAllowed. Deletion of Virtual Machine Scale Set isn't allowed"

This article explains how to resolve the `OperationNotAllowed` error that occurs when you deploy a Microsoft Azure Virtual Machine Scale Set by using Flexible orchestration mode. 

## Symptoms

When you deploy a [Virtual Machine Scale Set by using Flexible orchestration mode](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-orchestration-modes#scale-sets-with-flexible-orchestration), you receive the following error message:

> OperationNotAllowed. Deletion of Virtual Machine Scale Set isn't allowed as it contains one or more VMs. Please delete or detach the VM(s) before deleting the Virtual Machine Scale Set.

## Cause

You tried to delete a Virtual Machine Scale Set in Flexible orchestration mode, but the scale set is associated with one or more virtual machines (VMs).

## Solution

Delete all the VMs that are associated with the scale set in Flexible orchestration mode. After you delete all the associated VMs, you can delete the scale set successfully.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
