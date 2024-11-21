---
title: Quota exceeded error during creation or upgrade
description: Troubleshoot the Quota exceeded error during creation or upgrade of an Azure Kubernetes Service (AKS) cluster.
ms.date: 11/21/2024
ms.reviewer: chiragpa, nickoman, v-weizhu
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to avoid exceeding a "Quota exceeded" error for virtual CPU (vCPU) usage so that I can create or upgrade an Azure Kubernetes Service (AKS) cluster successfully.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# "Quota exceeded" error during creation or upgrade

This article provides a solution to a "Quota exceeded" error that occurs during an Azure Kubernetes Service (AKS) creation or upgrade operation.

## Symptoms

When you try to scale up your node pools in an AKS cluster, deploy a new cluster, or deploy a new node pool, you receive an error message that resembles the following text:

- Family quota errors
  
 > Code: QuotaExceeded  
 > Message: Operation could not be completed as it results in exceeding approved standardDSv3Family Cores quota. Additional details - Deployment Model: Resource Manager, Location: eastus2, Current Limit: 1500, Current Usage: 1500, Additional Required: 16, (Minimum) New Limit Required: 1516. 

 Or
 
 > code: "ErrCode_InsufficientVCPUQuota"
 > message: Insufficient vcpu quota requested 48, remaining 32 for family standardDSv5Family for region qatarcentral

- Regional quota errors

 > Code: QuotaExceeded
 > Message: Operation could not be completed as it results in exceeding approved Total Regional Cores quota. Additional details - Deployment Model: Resource Manager, Location: eastus, Current Limit: 350, Current Usage: 348, Additional Required: 4, (Minimum) New Limit Required: 352.
 
 Or 
 
 > code: "ErrCode_InsufficientVCPUQuota"
 > message: "Insufficient regional vcpu quota left for location eastus. left regional vcpu quota 0, requested quota 4"


## Cause

This error occurs because the operation that you try to perform results in exceeding the current quota limits.

## Solution

To resolve family quota errors, request a quota increase for your subscription. This can be done from the [Azure portal](https://portal.azure.com) by navigating to your subscription's **Quotas** page, selecting **Compute** and then submitting a request for a quota increase in the **My quotas** page.

There are three methods to submit a request for a quota increase:

- Select **New Quota Request** in the **My quotas** page.

- Select the pen icon in the **Adjustable** column in the **My quotas** page.

- For some specific quotas, create a new support request by selecting the support icon in the **Adjustable** column in the **My quotas** page.

 :::image type="content" source="media/quota-exceeded-during-creation-upgrade/my-quotas.png" alt-text="Screenshot that shows the 'My quotas' page." lightbox="media/quota-exceeded-during-creation-upgrade/my-quotas.png" :::

To resolve regional quota errors, select a different region or [increase a regional vCPU quota](/azure/azure-portal/supportability/regional-quota-requests#increase-a-regional-vcpu-quota).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
