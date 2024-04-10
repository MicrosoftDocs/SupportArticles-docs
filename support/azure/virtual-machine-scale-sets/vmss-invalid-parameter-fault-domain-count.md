---
title: The specified fault domain count 3 must fall in the range 1 to 2
description: Learn how to resolve the InvalidParameter (Fault Domain error) when deploying a scale set by using Flexible orchestration mode.
ms.date: 01/31/2023
ms.service: virtual-machine-scale-sets
ms.subservice: troubleshoot-deployment-errors
ms.reviewer: mimckitt, v-leedennis
---
# "InvalidParameter. The specified fault domain count 3 must fall in the range 1 to 2"

This article discusses how to resolve the `InvalidParameter` (fault domain) error that occurs when you deploy a Microsoft Azure Virtual Machine Scale Set by using Flexible orchestration mode. 

## Symptoms

When you deploy a [Virtual Machine Scale Set by using Flexible orchestration mode](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-orchestration-modes#scale-sets-with-flexible-orchestration), you receive the following error message:

> InvalidParameter. The specified fault domain count 3 must fall in the range 1 to 2.

## Cause

The `platformFaultDomainCount` parameter is invalid for the region or zone that's selected.

## Solution

You must select a valid `platformFaultDomainCount` value. For zonal deployments, the maximum `platformFaultDomainCount` value is **1**. For regional deployments for which no zone is specified, the maximum `platformFaultDomainCount` value varies depending on the region. To determine the maximum fault domain count per region, see [Choosing the right number of fault domains for Virtual Machine Scale Set](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-manage-fault-domains).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
