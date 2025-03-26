---
title: QuotaExceeded or InsufficientVCPUQuota error during creation or upgrade
description: Resolves a QuotaExceeded or InsufficientVCPUQuota error during a creation or upgrade operation in an Azure Kubernetes Service (AKS) cluster.
ms.date: 03/07/2025
ms.reviewer: chiragpa, nickoman, v-weizhu, mariusbutuc
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to avoid the "QuotaExceeded" or "InsufficientVCPUQuota" error for virtual CPU (vCPU) usage so that I can create or upgrade an AKS cluster successfully.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# "QuotaExceeded" or "InsufficientVCPUQuota" error during AKS creation or upgrade

This article provides a solution to a "QuotaExceeded" or "InsufficientVCPUQuota" error that occurs during an Azure Kubernetes Service (AKS) creation or upgrade operation.

## Symptoms

When you try to scale up your node pools in an AKS cluster, deploy a new cluster, or deploy a new node pool, you receive an error message that resembles the following text:

- Family quota errors
  
   > Code: QuotaExceeded  
   > Message: Operation could not be completed as it results in exceeding approved standardDSv3Family Cores quota. Additional details - Deployment Model: Resource Manager, Location: eastus2, Current Limit: 1500, Current Usage: 1500, Additional Required: 16, (Minimum) New Limit Required: 1516. 
  
   Or
   
   > Code: ErrCode_InsufficientVCPUQuota   
   > Message: Insufficient vcpu quota requested 48, remaining 32 for family standardDSv5Family for region qatarcentral

- Regional quota errors

   > Code: QuotaExceeded  
   > Message: Operation could not be completed as it results in exceeding approved Total Regional Cores quota. Additional details - Deployment Model: Resource Manager, Location: eastus, Current Limit: 350, Current Usage: 348, Additional Required: 4, (Minimum) New Limit Required: 352.
   
   Or 
   
   > Code: ErrCode_InsufficientVCPUQuota   
   > Message: "Insufficient regional vcpu quota left for location eastus. left regional vcpu quota 0, requested quota 4"


## Cause

This error occurs because the operation that you try to perform exceeds the current quota limits.

## Solution

To resolve family quota errors, [increase VM-family vCPU quotas](/azure/quotas/per-vm-quota-requests).

To resolve regional quota errors, select a different region or [increase a regional vCPU quota](/azure/azure-portal/supportability/regional-quota-requests#increase-a-regional-vcpu-quota).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
