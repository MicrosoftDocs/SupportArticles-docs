---
title: Troubleshoot cluster upgrading and scaling errors
description: Troubleshoot errors that occur when you try to upgrade or scale an Azure Kubernetes Service (AKS) cluster.
ms.date: 07/06/2022
editor: v-jsitser
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot errors so that I can successfully upgrade or scale an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot cluster upgrading and scaling errors

This article discusses how to troubleshoot errors that occur when you try to upgrade or scale a Microsoft Azure Kubernetes Service (AKS) cluster.

Some causes of failure when you try to upgrade or scale an AKS cluster are as follows.

## Cause 1: Cluster is in a failed state

If a cluster is in a `failed` state, `upgrade` or `scale` operations won't succeed. A cluster can enter a failed state for many reasons. The following reasons are the most common:

- Scaling while having an insufficient computer (CRP) quota

- Scaling a cluster that uses advanced networking but has insufficient subnet (networking) resources

### Solution: Increase your resource quota before you scale

To resolve these scenarios, follow these steps:

1. Scale your cluster back to a stable goal state within the quota.

1. [Request an increase in your resource quota](/azure/azure-resource-manager/troubleshooting/error-resource-quota#solution).

1. Try to scale up again beyond the initial quota limits.

1. Retry the original operation. This second operation should bring your cluster to a successful state.

## Cause 2: You're trying to upgrade and scale at the same time

A cluster or node pool can't simultaneously upgrade and scale. Instead, each operation type must finish on the target resource before the next request runs on that same resource. Therefore, operations are limited when active upgrade or scale operations are occurring or attempted.

### Solution: Determine the current status of your cluster before you try an operation

To help diagnose the issue, run the following [az aks show](/cli/azure/aks#az-aks-show) command to retrieve detailed status about your cluster.

```azurepowershell
az aks show --resource-group myResourceGroup --name myAKSCluster --output table
```

Then, use the following table to take the appropriate action based on the command results.

| Command result                | Action                                                                                  |
|-------------------------------|-----------------------------------------------------------------------------------------|
| Cluster is actively upgrading | Wait until the operation finishes.                                                      |
| Cluster upgrade failed        | Follow the steps that are outlined in [Cause 1](#cause-1-cluster-is-in-a-failed-state). |
| Cluster upgrade succeeded     | Retry the scale or other previously failed operation.                                   |

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
