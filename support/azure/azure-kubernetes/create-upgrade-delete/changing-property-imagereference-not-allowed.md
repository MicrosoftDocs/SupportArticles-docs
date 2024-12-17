---
title: Changing property imageReference is not allowed
description: Troubleshoot the Changing property imageReference is not allowed error message that occurs when you upgrade or scale an Azure Kubernetes Service (AKS) cluster.
ms.date: 10/10/2024
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the "Changing property 'imageReference' is not allowed" error message so that I can upgrade or scale my Azure Kubernetes Service (AKS) cluster successfully.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# "Changing property 'imageReference' is not allowed" error message while upgrading or scaling an AKS cluster


## Symptoms

When you try to upgrade or scale a Microsoft Azure Kubernetes Service (AKS) cluster, you might receive the "Changing property 'imageReference' is not allowed" error message.

## Cause

Unexpected results might occur if you modify or delete tags and other properties of resources within the *MC_** resource group. Also, altering the resources within the *MC_** group in the AKS cluster will break the service-level objective (SLO).

 
## Solution
Add another node pool, and then delete the affected node pool.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
