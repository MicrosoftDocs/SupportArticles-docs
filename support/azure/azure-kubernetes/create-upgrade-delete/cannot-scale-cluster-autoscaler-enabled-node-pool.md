---
title: Cluster autoscaler fails to scale with cannot scale cluster autoscaler enabled node pool error
description: Learn how to troubleshoot the cannot scale cluster autoscaler enabled node pool error when your autoscaler isn't scaling up or down.
author: sgeannina
ms.author: ninasegares
ms.date: 04/17/2025
ms.reviewer: aritraghosh, chiragpa.momajed
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Cluster autoscaler fails to scale with "cannot scale cluster autoscaler enabled node pool" error

This article discusses how to resolve the "cannot scale cluster autoscaler enabled node pool" error that appears when scaling a cluster with an autoscaler enabled node pool.

## Symptoms

You receive an error message that resembles the following message:

> `kubectl get nodes` outputs "No resources found"  
> All pods state is `Pending`  
> Scale operations are failing with "Cannot scale cluster autoscaler enabled node pool" error

## Troubleshooting checklist

Azure Kubernetes Service (AKS) uses virtual machine scale sets-based agent pools, which contain cluster nodes and [cluster autoscaling capabilities](/azure/aks/cluster-autoscaler) if enabled.

### Check that the cluster virtual machine scale set exists

1. Sign in to [Azure portal](https://portal.azure.com).
1. Find the node resource group by searching the following names:

   - The default name `MC_{AksResourceGroupName}_{YourAksClusterName}_{AksResourceLocation}`.
   - The custom name (if it was provided at creation).

   > [!NOTE]
   > When you create a new cluster, AKS automatically creates a second resource group to store the AKS resources. For more information, see [Why are two resource groups created with AKS?](/azure/aks/faq#why-are-two-resource-groups-created-with-aks)

1. Check the list of resources and make sure that there's a virtual machine scale set.

## Cause 1: The cluster virtual machine scale set was deleted

Deleting the virtual machine scale set attached to the cluster causes the cluster autoscaler to fail. It also causes issues when provisioning resources such as nodes and pods.

> [!NOTE]
> Modifying any resource under the node resource group in the AKS cluster is an unsupported action and will cause cluster operation failures. You can prevent changes from being made to the node resource group by [blocking users from modifying resources](/azure/aks/cluster-configuration#fully-managed-resource-group-preview) managed by the AKS cluster.

### Reconcile Node Pool

If the cluster virtual machine scale set is accidentally deleted, you can reconcile the node pool using `az aks nodepool update`:

```bash
# Update Node Pool Configuration
az aks nodepool update --resource-group <resource-group-name> --cluster-name <cluster-name> --name <nodepool-name> --tags <tags> --node-taints <taints> --labels <labels>

# Verify the Update
az aks nodepool show --resource-group <resource-group-name> --cluster-name <cluster-name> --name <nodepool-name>
```
Monitor the node pool to ensure it is functioning as expected and that all nodes are operational.

## Cause 2: Tags or any other properties were modified from the node resource group

You may receive scaling errors if you modify or delete Azure-created tags and other resource properties in the node resource group. For more information, see [Can I modify tags and other properties of the AKS resources in the node resource group?](/azure/aks/faq#can-i-modify-tags-and-other-properties-of-the-aks-resources-in-the-node-resource-group)

### Reconcile Node Resource Group Tags

Ensure the node resource group has the correct tags for AKS name and AKS group name using the Azure CLI:

```bash
# Add or update tags for AKS name and AKS group name
az group update --name <node-resource-group-name> --set tags.AKS-Managed-Cluster-Name=<aks-managed-cluster-name> tags.AKS-Managed-Cluster-RG=<aks-managed-cluster-rg>

# Verify the tags
az group show --name <node-resource-group-name> --query "tags"
```
Monitor the resource group to ensure the tags are correctly applied and that the resource group is functioning as expected.

## Cause 3: The cluster node resource group was deleted

Deleting the cluster node resource group causes issues when provisioning the infrastructure resources required by the cluster, which causes the cluster autoscaler to fail.

## Solution: Update the cluster to the goal state without changing the configuration

To resolve this issue, you can run the following command to recover the deleted virtual machine scale set or any tags (missing or modified):

> [!NOTE]
> It might take a few minutes until the operation completes.

```azurecli
az aks update --resource-group <resource-group-name> --name <aks-cluster-name>
```

### Additional Troubleshooting Tips

- Check the Azure Activity Log for any recent changes or deletions.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
