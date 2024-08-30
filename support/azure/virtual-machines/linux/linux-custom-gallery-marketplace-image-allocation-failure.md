---
title: Custom/gallery/marketplace Linux image allocation failures
description: Provides solutions to an allocation error when you deploy a custom/gallery/marketplace Linux image.
ms.custom: sap:Cannot create a VM, linux-related-content
ms.service: azure-virtual-machines
ms.date: 06/27/2024
ms.reviewer: srijangupta, scotro, jarrettr
---
# Allocation failures when deploying custom/gallery/marketplace Linux images

**Applies to:** :heavy_check_mark: Linux VMs

An allocation error arises in situations when the new VM request is pinned to a cluster that either cannot support the VM size being requested, or does not have available free space to accommodate the request.

## Cause 1: The cluster cannot support the requested VM size

To resolve this issue, retry the request using a smaller VM size. If the size of the requested VM cannot be changed, follow these steps:

1. Stop all the VMs in the availability set by selecting **Resource groups** > *your resource group* > **Resources** > *your availability set* > **Virtual Machines** > *your virtual machine* > **Stop**.
2. After all the VMs stop, create the new VM in the desired size.
3. Start the new VM first, and then select each of the stopped VMs and select **Start**.

## Cause 2: The cluster does not have free resources

To resolve this issue, retry the request at a later time. If the new VM can be part of a different availability set, follow these steps:

1. Create a new VM in a different availability set (in the same region).
2. Add the new VM to the same virtual network.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
