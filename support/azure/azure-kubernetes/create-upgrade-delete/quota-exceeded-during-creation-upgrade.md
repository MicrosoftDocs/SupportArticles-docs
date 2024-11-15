---
title: Quota exceeded error during creation or upgrade
description: Troubleshoot the Quota exceeded error during creation or upgrade of an Azure Kubernetes Service (AKS) cluster.
ms.date: 11/15/2024
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to avoid exceeding a "Quota exceeded" error for virtual CPU (vCPU) usage so that I can create or upgrade an Azure Kubernetes Service (AKS) cluster successfully.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# "Quota exceeded" error during creation or upgrade

You can request a standard virtual CPU (vCPU) quota increase per virtual machine (VM) family in the Microsoft [Azure portal](https://portal.azure.com):

1. Navigate to **Subscriptions**, select your Azure subscription.
2. Under **Settings**, select **Usage + quotas**. Set the provider to **Compute**, and optionally filter by the region of your AKS cluster.
    
    :::image type="content" source="media/quota-exceeded-during-creation-upgrade/request-quotas-vcpu.png" alt-text="Screenshot of the Usage quotas page in the Azure portal." lightbox="media/quota-exceeded-during-creation-upgrade/request-quotas-vcpu.png":::
3. Select the vCPU family that you want to request a quota increase, then choose **New quota request**.

After your subscription's vCPU quota is increased, you can create or upgrade an Azure Kubernetes Service (AKS) cluster successfully.

For more information about how to request regional vCPU quota increases for all VMs in a given region, see [Increase a regional vCPU quota](/azure/azure-portal/supportability/regional-quota-requests#increase-a-regional-vcpu-quota).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
