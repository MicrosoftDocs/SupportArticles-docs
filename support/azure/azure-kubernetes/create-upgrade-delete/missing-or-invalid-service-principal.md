---
title: Missing or invalid service principal when creating an AKS cluster
description: Troubleshoot a missing or invalid service principal when you try to create an Azure Kubernetes Service (AKS) cluster.
ms.date: 04/17/2025
editor: v-jsitser,momajed
ms.reviewer: chiragpa, nickoman, v-leedennis, momajed
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot a missing or invalid service principal so that I can successfully create an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Missing or invalid service principal when creating an AKS cluster

This article discusses how to troubleshoot a service principal that isn't found or is invalid when you try to create a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

<!-- Added: Note on Azure CLI version -->
Ensure you are using Azure CLI version 2.0.81 or later to run the commands in this article.

## Cause

When you create an AKS cluster, AKS requires a service principal or managed identity to manage resources on your behalf. By default, AKS uses a System-assigned managed identity. If you prefer to use a service principal instead, be aware that AKS does not automatically create one for you. You’ll have to provide your own service principal and reference it during cluster creation by [these instructions](https://learn.microsoft.com/en-us/azure/aks/kubernetes-service-principal?tabs=azure-cli). 
<!-- Added: Recommendation for managed identities -->
While service principals are supported for AKS authentication, consider using system-assigned managed identities, which simplify credential management and are the default for new clusters.

Additionally, when you create a service principal, make sure that it's propagated across all regions by Microsoft Entra ID. If this propagation takes too long, the cluster might fail validation because AKS can't locate the service principal.

## Solution

Make sure that there's a valid, findable service principal. To do this, use one of the following methods:

- When you create an AKS cluster, consider using an existing service principal that has already propagated across regions. Although there’s no direct way to verify the propagation status, you can verify functionality by using a previously deployed service principal. Alternatively, if you're using a new principal, allow 5-10 minutes for the principal to propagate before you start the cluster creation.
<!-- Added: Command to verify service principal status -->
- To confirm the service principal is ready, run `az ad sp show --id <appId>` and verify the output before creating the AKS cluster.

- If you use automation scripts, add time delays between service principal creation and AKS cluster creation. We recommend a delay of 5 to 10 minutes.

- If you use the [Azure portal](https://portal.azure.com), return to the cluster settings after you try to create the cluster, and then retry the validation page after a few minutes.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
