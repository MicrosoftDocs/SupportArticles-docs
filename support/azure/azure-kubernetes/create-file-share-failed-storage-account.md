---
title: Failed to create file share on storage account
description: Troubleshoot why you can't create a file share on a storage account for an Azure Kubernetes Service (AKS) cluster.
ms.date: 05/25/2022
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-azure-storage-issues
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why I can't create a file share on a storage account so that I can do dynamic provisioning on my Azure Kubernetes Service (AKS) cluster.
---
# Failed to create file share on storage account

This article discusses how to troubleshoot why you can't create a file share on a storage account that's used for dynamic provisioning on Microsoft Azure Kubernetes Service (AKS).

## Symptoms

You receive the following error when AKS creates a file share:

> persistentvolume-controller (combined from similar events):
>
> Failed to provision volume with StorageClass "azurefile":
>
> failed to create share kubernetes-dynamic-pvc-xxx in account xxx:
>
> failed to create file share, err:
>
> storage: service returned error: StatusCode=403, ErrorCode=AuthorizationFailure,
>
> ErrorMessage=This request is not authorized to perform this operation.

## Cause

The Kubernetes `persistentvolume-controller` isn't on the network that was chosen when the **Allow access from** network setting was enabled for **Selected networks** on the storage account.

## Workaround

Set up your AKS cluster to use [static provisioning with Azure Files](/azure/aks/azure-files-volume).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
