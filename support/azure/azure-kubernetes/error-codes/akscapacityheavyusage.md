---
title: Troubleshoot the AksCapacityHeavyUsage error code
description: Discusses how to troubleshoot the AksCapacityHeavyUsage error when you create or start a Kubernetes cluster.
ms.date: 05/29/2024
author: axelgMS
ms.author: axelg
editor: v-jsitser
ms.reviewer: chiragpa, anbubin, v-leedennis
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-problem-resolution
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the AksCapacityHeavyUsage error code

This article discusses how to identify and resolve the `AksCapacityHeavyUsage` error that might occur when you create a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to create an AKS cluster, you receive the following error message:

> **Code:** AksCapacityHeavyUsage
>
> **Message:** AKS is experiencing heavy usage in region \<Region>. We are working on adding new capacity. In the meantime, please consider creating new AKS clusters in a different region. For a list of all the Azure regions, visit https://aka.ms/aks/regions. For more details on this error, visit https://aka.ms/akscapacityheavyusage.

## Cause

You're trying to create a cluster in a region that has limited capacity.

When you create an AKS cluster, Microsoft Azure allocates compute resources to your subscription. You might occasionally experience the `AksCapacityHeavyUsage` error because of significant growth in demand for Azure Kubernetes Service in specific regions.

The `KubernetesAPICallFailed` error message indicates that the AKS cluster didn't start and doesn't have an associated control plane. Therefore, calls to the API server are failing. In this case, you have to retry the Start operation.

## Resolution

### Solution 1: Select a different region

The easiest and quickest solution is to try to deploy to a different region (for example, NorthEurope instead of WestEurope or UAENorth instead of QatarCentral). To find nearby regions, visit the [Azure Geographies page](https://azure.microsoft.com/explore/global-infrastructure/geographies/#overview).

This approach might not be feasible if you already have existing resources in the requested region, but it's the preferred solution in a dev/test scenario.

### Solution 2: Deploy a cluster that has different settings

The infrastructure that hosts AKS-managed clusters have different allocation reservations. Therefore, AKS might have more capacity for public clusters than it has for private clusters. If you experience the `AksCapacityHeavyUsage` error when you try to create a private cluster, try to create a public cluster instead (or vice versa).

### Solution 3: Use an Azure Enterprise subscription

When capacity is running low, non-Enterprise Agreement (EA) subscriptions are limited first in AKS cluster creation to reserve resources for real production scenarios. If you have an EA subscription, make sure that you use the EA subscription to create the AKS cluster.

### Solution 4: Retry the operation

Capacity is often reclaimed when other users stop or delete their AKS clusters. Therefore, the operation might succeed if you retry it later.

## More information

- Ensuring capacity for users is a top priority for Microsoft, and we're working to scale up our infrastructure to accommodate the increasing popularity of Azure services.

    For more information about improvements that we're making toward delivering a resilient cloud supply chain, see [this September 2021 Azure Blog article](https://azure.microsoft.com/blog/advancing-reliability-through-a-resilient-cloud-supply-chain/).

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
