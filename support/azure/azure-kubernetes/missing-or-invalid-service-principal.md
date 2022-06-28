---
title: Missing or invalid service principal when creating an AKS cluster
description: Troubleshoot a missing or invalid service principal when you try to create an Azure Kubernetes Service (AKS) cluster.
ms.date: 6/1/2022
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: chiragpa, nickoman
ms.service: container-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot a missing or invalid service principal so that I can successfully create an Azure Kubernetes Service (AKS) cluster.
---
# Missing or invalid service principal when creating an AKS cluster

This article discusses how to troubleshoot a service principal that wasn't found or is invalid when you try to create a Microsoft Azure Kubernetes Service (AKS) cluster.

## Cause

If you create an AKS cluster, AKS requires a service principal or managed identity to create resources on your behalf. AKS can automatically create a new service principal at cluster creation time, or it can receive an existing service principal. If you choose to automatically create a service principal, Azure Active Directory (Azure AD) needs to propagate the service principal to every region to ensure the successful creation of the cluster. If the propagation takes too long, the cluster might fail validation, because AKS can't find an available service principal.

## Solution

Make sure there's a valid, findable service principal by using one of the following methods:

- At cluster creation time, use an existing service principal that has already propagated across regions to pass into AKS.

- If you use automation scripts, add time delays between service principal creation and AKS cluster creation.

- If you use the [Azure portal](https://portal.azure.com), return to the cluster settings after you tried to create the cluster, and then retry the validation page after a few minutes.


[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
