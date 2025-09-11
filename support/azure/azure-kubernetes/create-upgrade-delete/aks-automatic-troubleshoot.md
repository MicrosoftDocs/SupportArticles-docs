---
title: Troubleshoot errors when creating or switching to an AKS Automatic cluster 
description: Learn how to resolve errors when creating or switching to an AKS Automatic cluster.
ms.date: 9/9/2025
ms.author: wangamanda
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot errors when creating or switching to an AKS Automatic cluster 

This article provides guidance for resolving errors that occur when you create or switch to an Azure Kubernetes Service (AKS) Automatic cluster. 

## Error 1: AKS Automatic could not find a suitable VM size.

### Symptoms
When you try to create an AKS Automatic cluster, you receive the following error message: 

>  AKS Automatic could not find a suitable VM size. The subscription may not have the required quota of '16' vCPUs, may have restrictions, or location $location may not support three availability zones for the following VM sizes: 'standard_d4lds_v5,standard_d4ads_v5,standard_d4ds_v5,standard_d4d_v5,standard_d4d_v4,standard_ds3_v2,standard_ds12_v2,standard_d4alds_v6,standard_d4lds_v6,standard_d4alds_v5'. Please request some quota for one of these candidate vm sizes in the target region or explicitly specify a vm-size with sufficient quota via --node-vm-size.

### Cause
This error message indicates that any of several problems exists: The subscription doesn't provide a sufficiently large quota of vCPUs assigned to virtual machines (VMs) or the location where the cluster is being created does not support three availability zones. Without a sufficient quota, the system pool for the AKS Automatic cluster can't be created.

### Solution 
To resolve this error, try one of the following fixes:
- [Increase the regional vCPU quota](/azure/quotas/regional-quota-requests#increase-a-regional-vcpu-quota) for one of the listed vm sizes.
- Deploy the cluster in a different region that has an existing quota that accommodates one of these VM sizes.
- If you're using Azure CLI, specify the VM size by using `--vm-sizes`.

## Error 2: Automatic SKU is not supported in this region.

### Symptoms
When you try to create an AKS Automatic cluster, you receive the following error message: 

> Automatic SKU is not supported in this region.

### Cause
This error indicates that you can't create AKS Automatic clusters in regions where [API Server VNet Integration](/azure/aks/api-server-vnet-integration#limited-availability) isn't generally available. 

### Solution
Create the clusters in regions where [API Server VNet Integration](/azure/aks/api-server-vnet-integration#limited-availability) is generally available. 

## Error 3: Managed cluster 'Automatic' SKU should set taint 'CriticalAddonsOnlyNoSchedule' for the system node pool.

### Symptoms
When you remove the 'CriticalAddonsOnlyNoSchedule' taint from the system node pool of an AKS Automatic cluster, you receive the following error message: 

> Managed cluster 'Automatic' SKU should set taint 'CriticalAddonsOnlyNoSchedule' for the system node pool.

### Cause
Removing the 'CriticalAddonsOnlyNoSchedule' taint from the system node pool of an AKS Automatic cluster is not allowed. 

### Solution
This behavior is by design. 'CriticalAddonsOnlyNoSchedule' keeps system add-ons running on the system node pool instead of on the user node pool. 

## Error 4 - Managed cluster 'Automatic' SKU should enable $feature_name feature with recommended values.

### Symptoms
When you try to update an existing AKS cluster from the "Base" SKU to the "Automatic" SKU, you receive the following error message: 

> Managed cluster 'Automatic' SKU should enable $feature_name feature with recommended values. The feature name will vary based on the feature that has not been enabled. 

### Cause
When you update an existing AKS cluster from "Base" to "Automatic," [all AKS Automatic features](/azure/aks/intro-aks-automatic) must first be enabled on the Base cluster. 

### Solution
Enable the specific feature that's mentioned in the error message before you update the cluster to "Automatic." Some of the required features include, but aren't limited to, the following features:

- [Azure Linux OS](/azure/azure-linux/intro-azure-linux)
- [Availability zones](/azure/reliability/regions-list): AKS Automatic clusters require deployment in Azure regions that support at least three availability zones.
- [Node auto provisioning](/azure/aks/node-autoprovision)

## Error 5 - Managed cluster 'Automatic' SKU should use Standard tier.

### Symptoms
When you try to update an existing AKS cluster from the "Base" SKU to the "Automatic" SKU, you receive the following error message: 

> Managed cluster 'Automatic' SKU should use Standard tier.

### Cause
AKS Automatic offers only one tier: Standard.

### Solution
Before you update an existing AKS cluster from "Base" to "Automatic," make sure that it's [set to the "Standard" tier](/azure/aks/free-standard-pricing-tiers#update-an-existing-cluster-from-the-free-tier-to-the-standard-tier). 

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
