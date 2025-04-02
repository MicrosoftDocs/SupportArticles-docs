---
title: Failed to create file share on storage account
description: Troubleshoot why you can't create a file share on a storage account for an Azure Kubernetes Service (AKS) cluster.
ms.date: 03/14/2025
ms.reviewer: chiragpa, nickoman, wonkilee, v-leedennis, mariusbutuc
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why I can't create a file share on a storage account so that I can do dynamic provisioning on my Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Storage
---
# Failed to create file share on storage account

This article discusses how to troubleshoot why you can't create a file share on a storage account that's used for dynamic provisioning on Azure Kubernetes Service (AKS).

## Symptoms

When you create a file share on a storage account that's used for dynamic provisioning, the PersistentVolumeClaim (PVC) is stuck in the Pending status. In this case, if you run the `kubectl describe pvc` command, you receive the following error: 

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

The Kubernetes `persistentvolume-controller` isn't on the network that was chosen when the **Allow access from** network setting was enabled for **Selected networks** on the storage account. Especially, when you specify `useDataPlaneAPI: "true"` on the storage class, the `persistentvolume-controller` uses the data plane API for file share creation/deletion/resizing. However, this will fail when a firewall or virtual network is set on the storage account.

## Workaround

Create a file share and set up your AKS cluster to use [static provisioning with Azure Files](/azure/aks/azure-files-volume).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
