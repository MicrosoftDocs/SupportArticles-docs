---
title: Slow attach and detach operations for an Azure disk
description: Troubleshoot why attach and detach operations are slow when you use an Azure disk for storage on your Azure Kubernetes Service (AKS) clusters.
ms.date: 03/24/2025
ms.reviewer: jopalhei, chiragpa, nickoman, v-leedennis, mariusbutuc
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why attach and detach operations are slow so that I can successfully use an Azure disk for storage on my AKS clusters.
ms.custom: sap:Storage
---
# Slow attach and detach operations for an Azure disk

This article discusses how to troubleshoot slow attach and detach operations when you use an Azure disk for storage on your Microsoft Azure Kubernetes Service (AKS) clusters.

## Symptoms

Attaching and detaching Azure disks takes more time than expected if there are many operations, as outlined in the following table.

| Target of attach and detach operations | Number of attach and detach operations |
|----------------------------------------|----------------------------------------|
| Single-node virtual machine            | More than 10                           |
| Single virtual machine scale set pool  | More than 3                            |

## Cause

This limitation is a known issue that affects the in-tree Azure disk driver (`kubernetes.io/azure-disk`) that performs the operations sequentially.

To verify that you're using the in-tree Azure Disk driver, check the storage class that's defined on the persistent volume claim. If the `provisioner` is `kubernetes.io/azure-disk`, then you're using the in-tree driver. This means that you're exposed to the referred limitation in which operations are done sequentially.

Usage of the in-tree driver was deprecated in AKS 1.21. We now use the Container Storage Interface (CSI) driver as the standard driver. 

## Workaround

We recommend that you [migrate your in-tree volumes to CSI Drivers by using this documentation](/azure/aks/csi-migrate-in-tree-volumes).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
