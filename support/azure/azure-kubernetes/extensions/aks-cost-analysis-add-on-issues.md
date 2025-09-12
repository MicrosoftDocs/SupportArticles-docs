---
title: Azure Kubernetes Service Cost Analysis add-on issues
description: Learn how to resolve issues that occur when you try to enable the Azure Kubernetes Service (AKS) Cost Analysis add-on.
ms.date: 06/25/2024
author: kaysieyu
ms.author: kaysieyu
ms.reviewer: pram, chiragpa, joharder, cssakscic, dafell, v-leedennis, v-weizhu
editor: v-jsitser
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, Policies and Add-Ons, references_regions, innovation-engine
---

# AKS Cost Analysis add-on issues

This article discusses how to troubleshoot problems that you might experience when you enable the Microsoft Azure Kubernetes Service (AKS) Cost Analysis add-on during cluster creation or a cluster update.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli)

## Symptoms

After you create or update an AKS cluster, you receive an error message in the following format:

| Error code | Cause |
|--|--|
| `InvalidDiskCSISettingForCostAnalysis` | [Cause 1: Azure Disk CSI driver is disabled](#cause-1-azure-disk-csi-driver-is-disabled) |
| `InvalidManagedIdentitySettingForCostAnalysis` | [Cause 2: Managed identity is disabled](#cause-2-managed-identity-is-disabled) |
| `CostAnalysisNotEnabledInRegion` | [Cause 3: The add-on is unavailable in your region](#cause-3-the-add-on-is-unavailable-in-your-region) |
| `InvalidManagedClusterSKUForFeature` | [Cause 4: The add-on is unavailable on the free pricing tier](#cause-4-the-add-on-is-unavailable-on-the-free-pricing-tier) |
| Pod `OOMKilled` | [Cause 5: The cost-analysis-agent pod gets the OOMKilled error](#cause-5-the-cost-analysis-agent-pod-gets-the-oomkilled-error) |
| Pod `Pending` | [Cause 6:The cost-analysis-agent pod is stuck in the Pending state](#cause-6-the-cost-analysis-agent-pod-is-stuck-in-the-pending-state) |

## Cause 1: Azure Disk CSI driver is disabled

You can't enable the Cost Analysis add-on on a cluster in which the [Azure Disk Container Storage Interface (CSI) driver](/azure/aks/azure-disk-csi) is disabled.

### Solution: Update the cluster to enable the Azure Disk CSI driver

Run the [az aks update][aks-update] command, and specify the `--enable-disk-driver` parameter. This parameter enables the Azure Disk CSI driver in AKS.

First, define the environment variables for your resource group and AKS cluster, using unique values for repeated runs:

```azurecli
export RANDOM_SUFFIX=$(head -c 3 /dev/urandom | xxd -p)
export RESOURCE_GROUP="my-aks-resource-group$RANDOM_SUFFIX"
export AKS_CLUSTER="my-aks-cluster$RANDOM_SUFFIX"
az aks update --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER --enable-disk-driver
```

For more information, see [CSI drivers on AKS](/azure/aks/csi-storage-drivers).

## Cause 2: Managed identity is disabled

You can enable the Cost Analysis add-on only on a cluster that has a system-assigned or user-assigned managed identity.

### Solution: Update the cluster to enable managed identity

Run the [az aks update][aks-update] command, and specify the `--enable-managed-identity` parameter:

```azurecli
export RANDOM_SUFFIX=$(head -c 3 /dev/urandom | xxd -p)
export RESOURCE_GROUP="my-aks-resource-group$RANDOM_SUFFIX"
export AKS_CLUSTER="my-aks-cluster$RANDOM_SUFFIX"
az aks update --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER --enable-managed-identity
```

For more information, see [Use a managed identity in AKS](/azure/aks/use-managed-identity).

## Cause 3: The add-on is unavailable in your region

The Cost Analysis add-on isn't currently enabled in your region.

> [!NOTE]  
> The AKS Cost Analysis add-on is currently unavailable in the following regions:
>
> - `usnateast`
> - `usnatwest`
> - `usseceast`
> - `ussecwest`


## Cause 4: The add-on is unavailable on the free pricing tier

You can't enable the Cost Analysis add-on on AKS clusters that are on the free pricing tier.

### Solution: Update the cluster to use the Standard or Premium pricing tier

Upgrade the AKS cluster to the Standard or Premium pricing tier. To do this, run the below [az aks update][aks-update] command that specify the `--tier` parameter. The `--tier` parameter can be set to either `standard` or `premium` (example below shows `standard`): 

```azurecli
export RANDOM_SUFFIX=$(head -c 3 /dev/urandom | xxd -p)
export RESOURCE_GROUP="my-aks-resource-group$RANDOM_SUFFIX"
export AKS_CLUSTER="my-aks-cluster$RANDOM_SUFFIX"
az aks update --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER --tier standard
```

For more information, see [Free and Standard pricing tiers for AKS cluster management](/azure/aks/free-standard-pricing-tiers).

## Cause 5: The cost-analysis-agent pod gets the OOMKilled error

The current memory limit for the cost-analysis-agent pod is set to 4 GB.

The pod's usage depends on the number of deployed containers, which can be roughly 200 MB + 0.5 MB per container. The current memory limit supports approximately 7000 containers per cluster.

When the pod's usage exceeds the allocated 4 GB limit, large clusters may experience the `OOMKill` error.

### Solution: Disable the add-on

Currently, customizing or manually increasing memory limits for the add-on isn't supported. To resolve this issue, disable the add-on.

## Cause 6: The cost-analysis-agent pod is stuck in the Pending state

If the pod is stuck in the Pending state with the FailedScheduling error, the nodes in the cluster have exhausted memory capacity.

### Solution: Ensure there's sufficient allocatable memory

The current memory request of the cost-analysis-agent pod is set to 500 MB. Ensure that there's sufficient allocatable memory for the pod to be scheduled

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[aks-update]: /cli/azure/aks#az-aks-update