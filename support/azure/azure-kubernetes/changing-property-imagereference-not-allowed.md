---
title: Changing property imageReference is not allowed
description: Troubleshoot the Changing property imageReference is not allowed error message that occurs when you upgrade or scale an Azure Kubernetes Service (AKS) cluster.
ms.date: 06/01/2022
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the "Changing property 'imageReference' is not allowed" error message so that I can upgrade or scale my Azure Kubernetes Service (AKS) cluster successfully.
---
# "Changing property 'imageReference' is not allowed" error message while upgrading or scaling an AKS cluster

When you try to upgrade or scale a Microsoft Azure Kubernetes Service (AKS) cluster, you might receive the "Changing property 'imageReference' is not allowed" error message if you modified the tags in the agent nodes within the cluster. Unexpected results might occur if you modify or delete tags and other properties of resources within the *MC_** resource group. Also, altering the resources within the *MC_** group in the AKS cluster will break the service-level objective (SLO).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
