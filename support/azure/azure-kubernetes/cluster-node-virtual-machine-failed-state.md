---
title: Azure Kubernetes Service cluster/node is in a failed state
description: Troubleshoot an issue where an Azure Kubernetes Service (AKS) cluster/node is in a failed state.
ms.date: 07/28/2023
ms.reviewer: chiragpa, nickoman, v-weizhu
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why attach my node virtual machine is in a failed state so that I can successfully use my Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot Azure Kubernetes Service cluster/node in a failed state

This article discusses how to troubleshoot a Microsoft Azure Kubernetes Service (AKS) cluster/node that's entered a failed state.

## Cluster creation failed
If you created a cluster recently and is in failed state, you need to use the [Activity Log]([/troubleshoot/azure/azure-kubernetes/troubleshoot-aks-cluster-creation-issues#view-error-details-in-the-azure-portal)) to get to root cause of the failure


## Cluster upgrade failed
The cause of cluster upgrade failure can be found in the Activity Logs. More information on the specific errors can be found under the [Troubleshoot upgrade operations](troubleshoot-aks-cluster-creation-issues.md)

## Cluster is in a failed state

You may encounter an issue where the provisioning status of your Microsoft Azure Kubernetes Service (AKS) cluster has changed from **Ready** to **Failed**. In this case, if your cluster applications continue to run, AKS may resolve the provisioning status automatically even if you didn't do an operation. Your running applications shouldn't be affected by the provisioning status change.

Alternatively, you can also manually bring back the cluster from a **Failed** to a **Succeeded** state by running the following [az resource update](/cli/azure/resource#az-resource-update) command:

```azurecli
az resource update --name <cluster_name> --namespace Microsoft.ContainerService --resource-group <resource_group_of_cluster> --resource-type ManagedClusters --subscription <subscription_of_cluster>
```
Replace cluster_name , resource_group_of_cluster,  subscription_of_cluster with appropriate cluster information
## Node is in a failed state

In some rare cases, an Azure Disk detach operation may partially fail, which leaves the node virtual machine (VM) in a failed state.

To resolve this issue, manually update the VM status by using one of the following methods:

- For a cluster that's based on an availability set, run the following [az vm update](/cli/azure/vm#az-vm-update) command:

  ```azurecli
  az vm update --resource-group <resource-group-name> --name <vm-name>
  ```

- For a cluster that's based on a virtual machine scale set, run the following [az vmss update-instances](/cli/azure/vmss#az-vmss-update-instances) command:

  ```azurecli
  az vmss update-instances --resource-group <resource-group-name> \
      --name <scale-set-name> \
      --instance-id <vm-or-scale-set-id>
  ```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
