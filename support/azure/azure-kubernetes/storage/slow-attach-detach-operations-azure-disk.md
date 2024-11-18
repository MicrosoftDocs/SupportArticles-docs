---
title: Slow attach and detach operations for an Azure disk
description: Troubleshoot why attach and detach operations are slow when you use an Azure disk for storage on your Azure Kubernetes Service (AKS) clusters.
ms.date: 11/18/2024
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why attach and detach operations are slow so that I can successfully use an Azure disk for storage on my Azure Kubernetes Service (AKS) clusters.
ms.custom: sap:Storage
---
# Slow attach and detach operations for an Azure disk

This article discusses how to troubleshoot slow attach and detach operations when you use an Azure disk for storage on your Microsoft Azure Kubernetes Service (AKS) clusters.

## Symptoms

Attaching and detaching Azure disks takes more time than expected if there are a large number of operations, as outlined in the following table:

| Target of attach and detach operations | Number of attach and detach operations |
|----------------------------------------|----------------------------------------|
| Single-node virtual machine            | More than 10                           |
| Single virtual machine scale set pool  | More than 3                            |

## Cause

The operations are done sequentially. This limitation is a known issue with the in-tree Azure disk driver (`kubernetes.io/azure-disk`).The usage of in-tree driver was deprecated in since aks 1.21, we are using the CSI as the standard. You should migrate your data smoothly using this [migrate csi-in-tree-volumes](https://github.com/MicrosoftDocs/azure-aks-docs/blob/main/articles/aks/csi-migrate-in-tree-volumes.md)

## Workaround

Attach and detach Azure disks in batch operations by [using the Azure disk Container Storage Interface (CSI) driver](/azure/aks/azure-disk-csi).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
