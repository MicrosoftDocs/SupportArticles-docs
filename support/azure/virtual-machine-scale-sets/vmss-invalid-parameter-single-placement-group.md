---
title: The value True of parameter singlePlacementGroup is not allowed
description: Learn how to resolve the InvalidParameter (SinglePlacementGroup error) when you deploy a Virtual Machine Scale Set by using Flexible orchestration mode.
ms.date: 01/31/2023
ms.service: virtual-machine-scale-sets
ms.subservice: troubleshoot-deployment-errors
ms.reviewer: mimckitt, v-leedennis
---
# "InvalidParameter. The value 'True' of parameter 'singlePlacementGroup' is not allowed. Allowed values are: False"

This article discusses how to resolve the `InvalidParameter` (SinglePlacementGroup) error that occurs when you deploy a Microsoft Azure Virtual Machine Scale Set by using Flexible orchestration mode. 

## Symptoms

When you deploy a [Virtual Machine Scale Set by using Flexible orchestration mode](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-orchestration-modes#scale-sets-with-flexible-orchestration), you receive the following error message:

> InvalidParameter. The value 'True' of parameter 'singlePlacementGroup' is not allowed. Allowed values are: False.

## Cause

The `singlePlacementGroup` parameter is set to `True`.

## Solution

Set the `singlePlacementGroup` parameter to `False`.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
