---
title: Troubleshoot the SubnetIsFull error code
description: Learn how to troubleshoot the SubnetIsFull error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 03/22/2022
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-create-operations
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the SubnetIsFull error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot the SubnetIsFull error code

This article discusses how to identify and resolve the `SubnetIsFull` error that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli) (version 2.0.59 or a later version)

## Symptoms

When you try to deploy an AKS cluster, you receive the following error message:

> **"code": "SubnetIsFull"**
>
> "message": "Subnet /subscriptions/\<subscription-id>/resourceGroups/vnettest/providers/Microsoft.Network/virtualNetworks/cvnet/subnets/ses-vnet2 with address prefix 10.59.248.128/25 is already full."

## Cause

The cluster was set up by using advanced networking. The Azure Container Networking Interface (CNI) preallocates an IP address for each pod in the cluster. The specific number of IP addresses that are reserved per node can vary, based on the maximum number of pods per node (**maxPod**) that's specified during cluster creation. For more information about this setting, see [Configure Azure CNI networking in AKS](/azure/aks/configure-azure-cni).

Every node allocates the maximum number of IP addresses per specified pod. The default value is 30 addresses from the specified subnet.

> [!NOTE]
> Azure reserves five IP addresses per subnet. The first address in the subnet is for the network ID, followed by three addresses that are used by Azure internally. The last address in the subnet is reserved for broadcast packets. For more information, see [Are there any restrictions on using IP addresses within these subnets?
](/azure/virtual-network/virtual-networks-faq#are-there-any-restrictions-on-using-ip-addresses-within-these-subnets).

If IP address exhaustion has occurred, check whether you're using virtual machine (VM) scale sets or availability sets in your cluster. Also, review the following limitations and capabilities. This information could change the manner in which you address this issue:

- You can't modify a subnet if it has any resources that use the subnet.

- You can't scale down the cluster if an upgrade causes the cluster to be in a failed state.

- You can't change the subnet of an existing cluster.

- You can change the subnet of a node.

- You can move your nodes to another subnet in the same virtual network while maintaining connectivity.

- You can delete a node and not affect the running pods if there's enough space for the pods on the nodes that remain.

## Solution 1: Delete the cluster and redeploy into a subnet that has more capacity

The easiest way to solve this issue is to delete the cluster and redeploy into a subnet that has enough capacity for your workload. However, in many cases, this solution isn't feasible. Therefore, you might have to consider other solutions.

## Solution 2: Free up IP addresses in your cluster's availability set

To mitigate the issue, free up some IP addresses for your availability set cluster. Follow these general steps:

1. Create a new subnet in the same virtual network that the cluster is currently in.

1. Move one or two of the nodes to the new subnet.

1. Rerun the upgrade in Azure CLI by using the [az aks upgrade](/cli/azure/aks#az-aks-upgrade) command.

1. Restore the nodes to the original subnet.

    > [!WARNING]
    > Moving the nodes to a new subnet will restart the systems that are being moved.

> [!NOTE]
> This solution is actually a short-term workaround.

## Solution 3: Shrink your cluster's VM scale set

To scale down your VM scale set, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Virtual machine scale sets**.

1. In the list of VM scale sets, select your scale set.

1. Select **Scaling**.

1. Scale down the VM scale set by at least one instance.

This change updates the node count in the node pool. It also reduces the number of IP addresses that are used so that the upgrade can finish.

> [!NOTE]
> This method is actually a short-term workaround.

## Solution 4: Expand the subnet in your availability set

Make the subnet bigger in your availability set to create more capacity for extra nodes. However, don't maximize an expanded subnet because that strategy can cause this issue to recur. Follow these general steps:

1. Free up space in the subnet by migrating all the nodes and any internal load balancers to a temporary subnet.

1. After the subnet is empty, modify it to allow more IP addresses.

1. Restore the nodes to the enlarged subnet.

## Solution 5: Expand the subnet in your VM scale set

Follow these general steps to make the subnet bigger in your VM scale set:

1. Free up space in the subnet by deleting the VM scale set and removing any internal load balancers.

1. Expand the subnet.

1. Modify the subnet, and reconcile the cluster to re-create the deleted resources by running the [az resource update](/cli/azure/resource#az-resource-update) command:

    ```azurecli-interactive
    az resource update --resource-group <resource-group-name> \
        --name <cluster-name> \
        --namespace Microsoft.ContainerService \
        --resource-type ManagedClusters
    ```

## Solution 6: Create a larger subnet and a new node pool in your VM scale set

Instead of expanding the subnet in your VM scale set, you can create a new, larger subnet and a new node pool. Follow these general steps:

1. Create a new subnet in the same virtual network, but give it a larger capacity than the current subnet has.

1. Create a new node pool by using the [az aks nodepool add](/cli/azure/aks/nodepool#az-aks-nodepool-add) command. Specify the `--vnet-subnet-id` parameter, and set the `--mode` parameter to `System`. (For more information about system node pools, see [Manage system node pools in AKS](/azure/aks/use-system-pools).)

1. Delete the original node pool.

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
