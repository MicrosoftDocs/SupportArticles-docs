---
title: Troubleshoot the SubnetIsFull error code
description: Learn how to troubleshoot the SubnetIsFull error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 3/10/2022
author: DennisLee-DennisLee
ms.author: v-dele
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi
ms.service: container-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the SubnetIsFull error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot the SubnetIsFull error code

This article describes how to identify and resolve the `SubnetIsFull` error, which might occur if you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli) (version 2.0.59 or higher).

## Symptoms

When you try to deploy the cluster, you receive the following error message:

> **"code": "SubnetIsFull"**
>
> "message": "Subnet /subscriptions/\<subscription-id>/resourceGroups/vnettest/providers/Microsoft.Network/virtualNetworks/cvnet/subnets/ses-vnet2 with address prefix 10.59.248.128/25 is already full."

## Cause

The cluster is set up using advanced networking. The Azure Container Networking Interface (CNI) preallocates an IP address for each pod in the cluster. The specific number of IP addresses that are reserved per node can vary, based on the maximum number of pods per node (**maxPod**) specified at the time of cluster creation. For more information about this setting, see [Configure Azure CNI networking in AKS](/azure/aks/configure-azure-cni).

Every node allocates the maximum number of IP addresses per pod specified. The default is 30 addresses from the specified subnet.

> [!NOTE]
> Azure reserves five IP addresses per subnet. The first address in the subnet is for the network ID, followed by three addresses that are used by Azure internally. The last address in the subnet is reserved for broadcast packets. For more information, see [Are there any restrictions on using IP addresses within these subnets?
](/azure/virtual-network/virtual-networks-faq#are-there-any-restrictions-on-using-ip-addresses-within-these-subnets).

If there's IP address exhaustion, check whether you're using virtual machine scale sets or availability sets in your cluster. Also review the following limitations and capabilities, which may change how you address this issue:

- You can't modify a subnet if it has any resources that use the subnet.

- You can't scale the cluster down if an upgrade causes the cluster to be in a failed state.

- You can't change the subnet of an existing cluster.

- You can change the subnet of a node.

- You can move your nodes to another subnet in the same virtual network while maintaining connectivity.

- You can delete a node and not affect the running pods, if there's enough space for the pods on the nodes that remain.

## Solution 1: Delete the cluster and redeploy into a subnet with more capacity

The easiest way to solve this issue is to delete the cluster and redeploy into a subnet that has enough capacity for your workload. In many cases, however, this solution isn't feasible, so you might need to consider other solutions.

## Solution 2: Free up IP addresses in your cluster's availability set

To mitigate the issue, free up some IP addresses for your availability set cluster. Follow these general steps:

1. Create a new subnet in the same virtual network that the cluster is currently in.

1. Move one or two of the nodes to the new subnet.

1. Rerun the upgrade in Azure CLI by using the [az aks upgrade](/cli/azure/aks#az-aks-upgrade) command.

1. Move the nodes back to the original subnet.

    > [!WARNING]
    > Moving the nodes to a new subnet will restart the systems that are being moved.
    
Note that this method is more of a short-term fix.

## Solution 3: Shrink your cluster's virtual machine scale set

To scale down your virtual machine scale set, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Virtual machine scale sets**.

1. In the list of virtual machine scale sets, select your scale set.

1. Select **Scaling**.

1. Scale down the virtual machine scale set by at least one instance.

This change updates the node count in the node pool, and it reduces the number of IP addresses that are used, so the upgrade can be completed. However, this method is more of a short-term fix.

## Solution 4: Expand the subnet in your availability set

Make the subnet bigger in your availability set, so that there's capacity for extra nodes. But don't maximize an expanded subnet, because that strategy can lead to a recurrence of this issue. Follow these general steps:

1. Free up the subnet by migrating all the nodes and any internal load balancers to a temporary subnet.

1. After the subnet is empty, modify it to allow more IP addresses.

1. Move the nodes back to the enlarged subnet.

## Solution 5: Expand the subnet in your virtual machine scale set

Follow these general steps to make the subnet bigger in your virtual machine scale set:

1. Free up the subnet by deleting the virtual machine scale set and removing any internal load balancers.

1. Expand the subnet.

1. Modify the subnet and reconcile the cluster to re-create the deleted resources, using the [az resource update](/cli/azure/resource#az-resource-update) command:

    ```azurecli-interactive
    az resource update --resource-group <resource-group-name> \
        --name <cluster-name> \
        --namespace Microsoft.ContainerService \
        --resource-type ManagedClusters
    ```

## Solution 6: Create a larger subnet and a new node pool in your virtual machine scale set

Instead of expanding the subnet in your virtual machine scale set, you can create a new, larger subnet and create a new node pool. Follow these general steps:

1. Create a new subnet in the same virtual network, but with larger capacity than the current subnet.

1. Create a new node pool by using the [az aks nodepool add](/cli/azure/aks/nodepool#az-aks-nodepool-add) command. Specify the `--vnet-subnet-id` parameter, and set the `--mode` parameter to `System`. (For more information about system node pools, see [Manage system node pools in AKS](/azure/aks/use-system-pools).)

1. Delete the original node pool.

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)
