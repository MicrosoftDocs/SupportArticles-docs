---
title: Troubleshoot Cluster autoscaler fails to scale with "Cannot scale cluster autoscaler enabled node pool" error.
description: Learn how to troubleshoot errors that occur when your autoscaler isn't scaling up or down.
author: sgeannina
ms.author: ninasegares
ms.topic: troubleshooting-general #Required; leave this attribute/value as-is.
ms.date: 06/28/2023
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-scale-operations
---


# Troubleshoot Cluster autoscaler fails to scale with "Cannot scale cluster autoscaler enabled node pool" error

This article discusses how to resolve the "cannot scale cluster autoscaler enabled node pool" error that appears on the cluster autoscaler logs when you're creating or managing AKS clusters.

## Symptoms

You receive an error message that resembles the following

* `kubectl get nodes` outputs "No resources found"
* All pods state is `Pending`
* Scale operations are failing with "Cannot scale cluster autoscaler enabled node pool" error

## Troubleshooting check list

AKS uses VMSS based agent pools, which contain the cluster nodes and give the cluster auto-scaling capabilities if enabled. See [https://docs.microsoft.com/azure/aks/cluster-autoscaler#about-the-cluster-autoscaler](https://docs.microsoft.com/azure/aks/cluster-autoscaler#about-the-cluster-autoscaler) for detailed information about cluster auto-scaler.

### Step 1: Check that the cluster VMSS exists

* Go to [Azure Portal](https://portal.azure.com)
* Find the node resource group: search using the default name `MC_{AksResourceGroupName}_{YourAksClusterName}_{AksResourceLocation}` or the custom name if it was provided at creation.
  > **INFO:** When you create a new cluster, AKS automatically creates a second resource group to store the AKS resources. For more information, see [Why are two resource groups created with AKS?](https://learn.microsoft.com/en-us/azure/aks/faq#why-are-two-resource-groups-created-with-aks)
* Check the list of resources and make sure that there is a Virtual machine scale set.

## Cause 1: The cluster VMSS was deleted

Deleting the VMSS attached to the cluster will cause the cluster autoscaler to fail. It will also cause issues provisioning resources like nodes and pods.

## Cause 2: Tags or any other properties were modified from the node resource group

You can get scaling errors if you modify or delete Azure-created tags and other resource properties in the node resource group. See [Can I modify tags and other properties of the AKS resources in the node resource group?](https://learn.microsoft.com/en-us/azure/aks/faq#can-i-modify-tags-and-other-properties-of-the-aks-resources-in-the-node-resource-group) for more information.

## Solution: Update the cluster to its goal state without changing the current configuration

If you run into this issue you can recover the deleted vmss or any missing/modified tags running this command

```azurecli
az aks update --resource-group <resource-group-name> --name <aks-cluster-name>
```

Wait until the operation completes. This might take a few minutes.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
