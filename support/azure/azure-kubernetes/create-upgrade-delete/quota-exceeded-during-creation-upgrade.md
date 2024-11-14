---
title: Quota exceeded error during creation or upgrade
description: Troubleshoot the Quota exceeded error during creation or upgrade of an Azure Kubernetes Service (AKS) cluster.
ms.date: 11/14/2024
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

> Code: QuotaExceeded  
> Message: Operation results in exceeding quota limits of Core. Maximum allowed: 450, Current in use: 449, Additional requested: 8.

Or

> Insufficient vcpu quota requested 6, remaining 4 for family standardDCSv2Family for region westeurope.

## Cause

This error occurs because the operation that you try to perform results in exceeding the current quota limits.

## Solution

To resolve this error, request a quota increase for your subscription. This can be done from the [Azure portal](https://portal.azure.com) by navigating to your subscription's **Quotas** page, selecting **Compute** and then submitting a request for a quota increase in the **My quotas** page.

There are three methods to submit a request for a quota increase:

- Select **New Quota Request** in the **My quotas** page.

- Select the pen icon in the **Adjustable** column in the **My quotas** page.

- For some specific quotas, create a new support request by selecting the support icon in the **Adjustable** column in the **My quotas** page.

 :::image type="content" source="media/quota-exceeded-during-creation-upgrade/my-quotas.png" alt-text="Screenshot that shows the 'My quotas' page.":::

For more information about how to request regional vCPU quota increases for all VMs in a given region, see [Increase a regional vCPU quota](/azure/azure-portal/supportability/regional-quota-requests#increase-a-regional-vcpu-quota).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
