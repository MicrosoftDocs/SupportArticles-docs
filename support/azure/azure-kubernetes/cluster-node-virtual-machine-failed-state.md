---
title: Azure Kubernetes Service cluster/node is in a failed state
description: Troubleshoot an issue where an Azure Kubernetes Service (AKS) cluster/node is in a failed state.
ms.date: 11/23/2023
ms.reviewer: chiragpa, nickoman, v-weizhu, v-six
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why attach my node virtual machine is in a failed state so that I can successfully use my Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot Azure Kubernetes Service cluster/node in a failed state

This article discusses how to troubleshoot a Microsoft Azure Kubernetes Service (AKS) cluster/node that's entered a failed state.

## Cluster is in a failed state

To resolve this issue, get the operation that caused the failure and figure out the error. The following are two common operations that can result in a failed cluster.

### Cluster creation failed

If a recently created cluster is in a failed state, examine the [activity logs](troubleshoot-aks-cluster-creation-issues.md#view-error-details-in-the-azure-portal) to identify the root cause of the failure.

### Cluster upgrade failed

The activity logs can be used to identify the cause of the upgrade failure. For more information about the specific errors, see the [basic troubleshooting methods](troubleshoot-aks-cluster-creation-issues.md).

The following list outlines some common errors:

- [OutboundConnFailVMExtensionError](error-code-outboundconnfailvmextensionerror.md)
- [Drain errors](error-code-poddrainfailure.md)
- [SubscriptionNotRegistered](/azure/azure-resource-manager/troubleshooting/error-register-resource-provider)
- [RequestDisallowedByPolicy](error-code-requestdisallowedbypolicy.md)
- [QuotaExceeded](error-code-quotaexceeded.md)
- [PublicIPCountLimitReached](error-code-publicipcountlimitreached.md)
- [OverconstrainedAllocationRequest](error-code-zonalallocationfailed-allocationfailed.md)
- ReadOnlyDisabledSubscription

  To fix this error, review and adjust the subscription permissions, as the subscription is currently disabled and set to read-only.

Alternatively, try to manually restore the cluster state from **Failed** to **Succeeded** by running the following [az resource update](/cli/azure/resource#az-resource-update) command:

```azurecli
az resource update --name <cluster-name> --namespace Microsoft.ContainerService --resource-group <resource-group-name> --resource-type ManagedClusters --subscription <subscription-name>
```

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
