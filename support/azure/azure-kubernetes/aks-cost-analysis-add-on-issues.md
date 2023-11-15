---
title: Azure Kubernetes Service Cost Analysis add-on issues
description: Learn how to resolve issues that occur when you try to enable the Azure Kubernetes Service (AKS) Cost Analysis add-on.
ms.date: 11/14/2023
author: kaysieyu
ms.author: kaysieyu
ms.reviewer: pram, chiragpa, joharder, cssakscic, v-leedennis
editor: v-jsitser
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-extensions-add-ons
ms.custom: references_regions
---

# AKS Cost Analysis add-on issues

This article discusses how to troubleshoot problems that you might experience when you enable the Microsoft Azure Kubernetes Service (AKS) Cost Analysis add-on during cluster creation or a cluster update.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli)

## Symptoms

After you create or update an AKS cluster, you receive an error message in the following format:

> OperationNotAllowed with \<error-code> id

The following table displays the possible error codes and their corresponding causes.

| Error code | Cause |
|--|--|
| `InvalidDiskCSISettingForCostAnalysis` | [Cause 1: Azure Disk CSI driver is disabled](#cause-1-azure-disk-csi-driver-is-disabled) |
| `InvalidManagedIdentitySettingForCostAnalysis` | [Cause 2: Managed identity is disabled](#cause-2-managed-identity-is-disabled) |
| `CostAnalysisNotEnabledInRegion` | [Cause 3: The add-on is unavailable in your region](#cause-3-the-add-on-is-unavailable-in-your-region) |
| `InvalidManagedClusterSKUForFeature` | [Cause 4: The add-on is unavailable on the free pricing tier](#cause-4-the-add-on-is-unavailable-on-the-free-pricing-tier) |

## Cause 1: Azure Disk CSI driver is disabled

You can't enable the Cost Analysis add-on on a cluster in which the [Azure Disk Container Storage Interface (CSI) driver](/azure/aks/azure-disk-csi) is disabled.

### Solution 1: Update the cluster to enable the Azure Disk CSI driver

Run the [az aks update][aks-update] command, and specify the `--enable-disk-driver` parameter. This parameter enables the Azure Disk CSI driver in AKS.

```azurecli
az aks update --resource-group <my-resource-group> --name <my-aks-cluster> --enable-disk-driver
```

For more information, see [CSI drivers on AKS](/azure/aks/csi-storage-drivers).

## Cause 2: Managed identity is disabled

You can enable the Cost Analysis add-on only on a cluster that has a system-assigned or user-assigned managed identity.

### Solution 2: Update the cluster to enable managed identity

Run the [az aks update][aks-update] command, and specify the `--enable-managed-identity` parameter:

```azurecli
az aks update --resource-group <my-resource-group> --name <my-aks-cluster> --enable-managed-identity
```

For more information, see [Use a managed identity in AKS](/azure/aks/use-managed-identity).

## Cause 3: The add-on is unavailable in your region

The Cost Analysis add-on isn't currently enabled in your region.

> [!NOTE]  
> The AKS Cost Analysis add-on is currently unavailable in the following regions:
>
> - chinaeast3
> - chinanorth2
> - chinanorth3
> - usgovarizona
> - usgovtexas
> - usgovvirginia
> - usnateast
> - usnatwest
> - usseceast
> - ussecwest

> [!NOTE]  
> The support plan is under review. This article will be updated as new information becomes available.

### Workaround 3: Choose another region

Deploy in a different region that's available for the Cost Analysis add-on.

## Cause 4: The add-on is unavailable on the free pricing tier

You can't enable the Cost Analysis add-on on AKS clusters that are on the free pricing tier.

### Solution 4: Update the cluster to use the Standard or Premium pricing tier

Upgrade the AKS cluster to the Standard or Premium pricing tier. To do this, run one of the following [az aks update][aks-update] commands that specify the `--tier` parameter:

```azurecli
az aks update --resource-group <my-resource-group> --name <my-aks-cluster> --tier standard
az aks update --resource-group <my-resource-group> --name <my-aks-cluster> --tier premium
```

For more information, see [Free and Standard pricing tiers for AKS cluster management](/azure/aks/free-standard-pricing-tiers).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

[aks-update]: /cli/azure/aks#az-aks-update
