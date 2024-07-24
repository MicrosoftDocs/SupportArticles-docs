---
title: Custom/gallery/marketplace image allocation failures
description: Provides solutions to an allocation error when you deploy a custom/gallery/marketplace image.
ms.service: virtual-machines
ms.date: 06/04/2024
ms.custom: sap:Cannot create a VM, H1Hack27Feb2017
ms.reviewer: macla, scotro, glimoli, jarrettr, azurevmcptcic
---
# Allocation failures when deploying custom/gallery/marketplace images

**Applies to:** :heavy_check_mark: Windows VMs

An allocation error arises in situations when the new VM request is pinned to a cluster that either cannot support the VM size being requested, or does not have available free space to accommodate the request.

## Cause 1: The cluster cannot support the requested VM size

Retry the request using a smaller VM size. If the size of the requested VM cannot be changed, follow these steps:

1. Stop all the VMs in the availability set by selecting **Resource groups** > *your resource group* > **Resources** > *your availability set* > **Virtual Machines** > *your virtual machine* > **Stop**.
1. After all the VMs stop, create the new VM in the desired size.
1. Start the new VM first, and then select each of the stopped VMs and select **Start**.

## Cause 2: The cluster does not have free resources

Retry the request at a later time. If the new VM can be part of a different availability set, follow these steps:
1. Create a new VM in a different availability set (in the same region)
1. Add the new VM to the same virtual network.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
