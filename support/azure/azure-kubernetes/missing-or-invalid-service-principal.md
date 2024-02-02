---
title: Missing or invalid service principal when creating an AKS cluster
description: Troubleshoot a missing or invalid service principal when you try to create an Azure Kubernetes Service (AKS) cluster.
ms.date: 07/08/2022
editor: v-jsitser
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot a missing or invalid service principal so that I can successfully create an Azure Kubernetes Service (AKS) cluster.
---
# Missing or invalid service principal when creating an AKS cluster

## Symptoms

This article discusses how to troubleshoot a service principal that isn't found or is invalid when you try to create a Microsoft Azure Kubernetes Service (AKS) cluster.

## Cause

If you create an AKS cluster, AKS requires a service principal or managed identity to create resources on your behalf. AKS can automatically create a new service principal during cluster creation, or it can receive an existing service principal. If you choose to automatically create a service principal, Microsoft Entra ID has to propagate the service principal to every region to make sure that the cluster is successfully created. If the propagation takes too long, the cluster might fail validation. This is because AKS can't find an available service principal.

## Solution

Make sure that there's a valid, findable service principal. To do this, use one of the following methods:

- During cluster creation, use an existing service principal that has already propagated across regions to pass into AKS.

- If you use automation scripts, add time delays between service principal creation and AKS cluster creation.

- If you use the [Azure portal](https://portal.azure.com), return to the cluster settings after you try to create the cluster, and then retry the validation page after a few minutes.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
