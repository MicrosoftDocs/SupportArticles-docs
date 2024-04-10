---
title: Quota exceeded error during creation or upgrade
description: Troubleshoot the Quota exceeded error during creation or upgrade of an Azure Kubernetes Service (AKS) cluster.
ms.date: 06/01/2022
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to avoid exceeding a "Quota exceeded" error for virtual CPU (vCPU) usage so that I can create or upgrade an Azure Kubernetes Service (AKS) cluster successfully.
---
# "Quota exceeded" error during creation or upgrade

You can request a standard virtual CPU (vCPU) quota increase per virtual machine (VM) family in the Microsoft [Azure portal](https://portal.azure.com). Go to your Azure subscription's **Overview** page, and then select **Usage + quotas** to view your options. After your subscription's vCPU quota is increased, you can create or upgrade an Azure Kubernetes Service (AKS) cluster successfully.

For more information about how to request regional vCPU quota increases for all VMs in a given region, see [Increase a regional vCPU quota](/azure/azure-portal/supportability/regional-quota-requests#increase-a-regional-vcpu-quota).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
