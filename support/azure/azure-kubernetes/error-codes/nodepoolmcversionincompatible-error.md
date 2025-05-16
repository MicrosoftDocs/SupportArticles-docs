---
title: NodePoolMcVersionIncompatible - Node pool version 1.x and control plane version 1.y are incompatible
description: This article discusses how to resolve a version incompatibility error that occurs when you upgrade a node pool in an Azure Kubernetes Service (AKS) cluster.
ms.date: 10/23/2024
editor: v-jsitser
ms.reviewer: axelg, chiragpa, cssakscic, v-leedennis
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Can't upgrade AKS cluster because of NodePoolMcVersionIncompatible error

This article discusses how to resolve the "NodePoolMcVersionIncompatible - Node pool version 1.x.y and control plane version 1.a.b are incompatible" error that occurs when you upgrade a node pool in a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli)

## Symptoms

When you upgrade a node pool in an AKS cluster, you receive one of the following error messages:

> **BadRequest - NodePoolMcVersionIncompatible**
>
> Error: Node pool version 1.x.y and control plane version 1.a.b are incompatible. Minor version of node pool cannot be more than 2 versions less than control plane's version. Minor version of node pool is x and control plane is a. For more information, please check <https://aka.ms/version-skew-policy>.
>
> Resource ID: /subscriptions/\<subscription_id>/resourcegroups/\<aks_cluster_resource_group>/providers/Microsoft.ContainerService/managedClusters/\<aks_cluster_name>.

> **BadRequest - NodePoolMcVersionIncompatible**
>
> Error: Node pool version 1.x.y and control plane version 1.a.b are incompatible. Minor version of node pool version x is bigger than control plane version a. For more information, please check <https://aka.ms/version-skew-policy>.
>
> Resource ID: /subscriptions/\<subscription_id>/resourcegroups/\<aks_cluster_resource_group>/providers/Microsoft.ContainerService/managedClusters/\<aks_cluster_name>.

## Cause

These issues occur if you try to upgrade a node pool that's more than two versions behind the AKS control plane version, or if you try to add a node pool that's at a more recent version than the control plane version.

You must meet the following conditions when you upgrade a node pool:

- The node pool version can't be greater than the control *\<major>.\<minor>.\<patch>* version.

- The node pool version must be within two *minor* versions of the control plane version.

For more information, see the [AKS validation rules for upgrade](/azure/aks/use-multiple-node-pools#validation-rules-for-upgrades).

## Solution 1: Make sure that the node pool version is within two minor versions of the control plane version

1. [Get the control plane version](/azure/aks/tutorial-kubernetes-upgrade-cluster#get-available-cluster-versions) by running the [az aks get-upgrades](/cli/azure/aks#az-aks-get-upgrades) command in Azure CLI.

    Here's an example use of the command. The `MasterVersion` output column contains the control plane version.

    ```azurecli
    az aks get-upgrades --resource-group aksrg --name testcluster1 --output table  
    ```

    ```output
    Name     ResourceGroup    MasterVersion    Upgrades
    -------  ---------------  ---------------  -----------------------
    default  aksrg            1.23.12          1.23.15, 1.24.6, 1.24.9
    ```

2. [Upgrade the node pool](/azure/aks/use-multiple-node-pools#upgrade-a-node-pool) by running the [az aks nodepool upgrade](/cli/azure/aks/nodepool#az-aks-nodepool-upgrade) Azure CLI command, and provide a Kubernetes version that's within two minor versions of the control plane version.

    For example, if the control plane version is `1.23.12`, you can specify the Kubernetes version of the node pool as `1.23.8` or `1.23.12`.

    Here's an example use of the command:

    ```azurecli
    az aks nodepool upgrade \
        --resource-group aksrg \
        --cluster-name testcluster1 \
        --name mynodepool \
        --kubernetes-version 1.23.8 \
        --no-wait
    ```

## Solution 2: Make sure that the node pool version isn't greater than the control plane version

1. [Get the control plane version](/azure/aks/tutorial-kubernetes-upgrade-cluster#get-available-cluster-versions) by running the [az aks get-upgrades](/cli/azure/aks#az-aks-get-upgrades) command in Azure CLI.

    Here's an example use of the command. The `MasterVersion` output column contains the control plane version.

    ```azurecli
    az aks get-upgrades --resource-group aksrg --name testcluster1 --output table  
    ```

    ```output
    Name     ResourceGroup    MasterVersion    Upgrades
    -------  ---------------  ---------------  -----------------------
    default  aksrg            1.23.12          1.23.15, 1.24.6, 1.24.9
    ```

2. [Upgrade the node pool](/azure/aks/use-multiple-node-pools#upgrade-a-node-pool) by running the [az aks nodepool upgrade](/cli/azure/aks/nodepool#az-aks-nodepool-upgrade) Azure CLI command, and provide a Kubernetes version that's less than or equal to the control plane version.

    Here's an example use of the command:

    ```azurecli
    az aks nodepool upgrade \
        --resource-group aksrg \
        --cluster-name testcluster1 \
        --name mynodepool \
        --kubernetes-version 1.23.12 \
        --no-wait
    ```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
