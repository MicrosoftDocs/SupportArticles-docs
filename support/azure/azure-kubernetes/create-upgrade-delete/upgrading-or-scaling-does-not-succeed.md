---
title: Troubleshoot cluster upgrading and scaling errors
description: Troubleshoot errors that occur when you try to upgrade or scale an Azure Kubernetes Service (AKS) cluster.
ms.date: 09/19/2024
editor: v-jsitser
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot errors so that I can successfully upgrade or scale an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool), innovation-engine
---

# Troubleshoot cluster upgrading and scaling errors

This article discusses how to troubleshoot errors that occur when you try to upgrade or scale a Microsoft Azure Kubernetes Service (AKS) cluster.

Some causes of failure when you try to upgrade or scale an AKS cluster are as follows.

## Cause 1: Cluster is in a failed state

If a cluster is in a `failed` state, `upgrade` or `scale` operations won't succeed. A cluster can enter a failed state for many reasons.

Here are the most common reasons and corresponding solutions:

- Scaling while having an insufficient Compute Resource Provider (CRP) quota.

    To resolve this issue, increase your resource quota before you scale by following these steps:

    1. Scale your cluster back to a stable goal state within the quota.

    2. [Request an increase in your resource quota](/azure/azure-resource-manager/troubleshooting/error-resource-quota#solution).

    3. Try to scale up again beyond the initial quota limits.

    4. Retry the original operation. This second operation should bring your cluster to a successful state.

- Scaling a cluster that uses advanced networking such as Azure Container Networking Interface (CNI), Azure CNI for dynamic IP allocation but has insufficient subnet (networking) resources.

    To resolve this issue, see [Troubleshoot the SubnetIsFull error code](error-code-subnetisfull.md).

- Upgrading a cluster that has Pod Disruption Budgets (PDBs) which may cause eviction failures.

    To resolve this issue, remove or adjust the PDB so that the pod can be drained. For more information, see [Troubleshoot UpgradeFailed errors due to eviction failures caused by PDBs](error-code-poddrainfailure.md).

- Upgrading a cluster that uses deprecated APIs.

    For Kubernetes versions upgrading to 1.26 or later, AKS checks whether deprecated APIs are used before starting the cluster upgrade. To resolve this issue and start to upgrade, see [How to mitigate stopped upgrade operations due to deprecated APIs](/azure/aks/stop-cluster-upgrade-api-breaking-changes#mitigate-stopped-upgrade-operations).

## Cause 2: You're trying to upgrade and scale at the same time

A cluster or node pool can't simultaneously upgrade and scale. Instead, each operation type must finish on the target resource before the next request runs on that same resource. Therefore, operations are limited when active upgrade or scale operations are occurring or attempted.

To resolve this issue, follow these steps:

1. Determine the current status of your cluster before you try an operation. 

    To retrieve detailed status about your cluster, run the following [az aks show](/cli/azure/aks#az-aks-show) command:

    ```azurecli
    az aks show --resource-group $RESOURCE_GROUP_NAME --name $CLUSTER_NAME --output table
    ```

    Results: 

    <!-- expected_similarity=0.3 -->

    ```output
    Name          Location    ResourceGroup       KubernetesVersion    ProvisioningState    Fqdn
    ------------- ----------- ------------------- ------------------- ------------------- ---------------
    myAKSClusterx eastus2     myResourceGroupx    1.27.x              Succeeded            xxxxx.xxxxxx.x
    ```

2. Refer to the following table to take the appropriate action based on the cluster's status:

    | ProvisioningState                | Action                                                                                  |
    |-------------------------------|-----------------------------------------------------------------------------------------|
    | Upgrading | Wait until the operation finishes.                                                      |
    | Failed        | Follow the solutions that are outlined in [Cause 1](#cause-1-cluster-is-in-a-failed-state). |
    | Succeeded     | Retry the scale or other previously failed operation.                                   |

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
