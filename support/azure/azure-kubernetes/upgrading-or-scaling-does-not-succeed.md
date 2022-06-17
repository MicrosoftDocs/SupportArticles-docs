---
title: Troubleshoot cluster upgrading and scaling errors
description: Troubleshoot errors that occur when you try to upgrade or scale an Azure Kubernetes Service (AKS) cluster.
ms.date: 6/1/2022
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: chiragpa, nickoman
ms.service: container-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot errors so that I can successfully upgrade or scale an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot cluster upgrading and scaling errors

This article discusses how to troubleshoot errors that occur when you try to upgrade or scale a Microsoft Azure Kubernetes Service (AKS) cluster.

## Cause 1: Cluster is in a failed state

A cluster can enter a failed state because of many reasons. Until the cluster is out of `failed` state, `upgrade` or `scale` operations won't succeed. Common issues include the following scenarios:

- Scaling with an insufficient computer (CRP) quota

- Scaling a cluster with advanced networking but insufficient subnet (networking) resources

### Solution: Increase your resource quota before scaling

To resolve these scenarios, follow these steps:

1. Scale your cluster back to a stable goal state within the quota.

1. [Request an increase in your resource quota](/azure/azure-resource-manager/troubleshooting/error-resource-quota#solution).

1. Try to scale up again beyond the initial quota limits.

1. Retry the original operation. This retry operation should bring your cluster to the succeeded state.

## Cause 2: You're trying to upgrade and scale at the same time

You can't have a cluster or node pool simultaneously upgrade and scale. Instead, each operation type must complete on the target resource before the next request on that same resource. As a result, operations are limited when active upgrade or scale operations are occurring or tried.

### Solution: Find out the current status of your cluster before trying an operation

To help diagnose the issue, run the following [az aks show](/cli/azure/aks#az-aks-show) command to retrieve detailed status on your cluster.

```azurepowershell
az aks show --resource-group myResourceGroup --name myAKSCluster --output table
```

Then, use the following table to take the appropriate action based on the command results:

| Command result                | Action                                                                                  |
|-------------------------------|-----------------------------------------------------------------------------------------|
| Cluster is actively upgrading | Wait until the operation finishes.                                                      |
| Cluster upgrade failed        | Follow the steps that are outlined in [Cause 1](#cause-1-cluster-is-in-a-failed-state). |
| Cluster upgrade succeeded     | Retry the scale or other previously failed operation again.                             |

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
