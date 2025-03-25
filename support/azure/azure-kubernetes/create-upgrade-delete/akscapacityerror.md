---
title: Troubleshoot the AKSCapacityError error code
description: Discusses how to troubleshoot the AKSCapacityError error when you create or start a Kubernetes cluster.
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

When you try to create an AKS cluster, you receive the following error messages:

> **Code:** AksCapacityHeavyUsage
>
> **Message:** AKS is experiencing heavy usage in region <Region>. We are working on adding new capacity. In the meantime, please consider creating new AKS clusters in a different region. For a list of all the Azure regions, visit https://aka.ms/aks/regions. For more details on this error, visit https://aka.ms/akscapacityheavyusage.

## Cause

You're trying to create a cluster in a region that has limited capacity.

When you create an AKS cluster, Microsoft Azure allocates compute resources to your subscription. You might occasionally experience the `AksCapacityHeavyUsage` error because of significant growth in demand for Azure Kubernetes Service in specific regions.

The `KubernetesAPICallFailed` error message indicates that the AKS cluster didn't start and doesn't have an associated control plane. Therefore, calls to the API server are failing. In this case, you have to retry the Start operation.

## Resolution

### Solution 1: Select a different region

The easiest and quickest solution is to try to deploy to a different region (for example, NorthEurope instead of WestEurope or UAENorth instead of QatarCentral). To find nearby regions, visit the [Azure Geographies page](https://azure.microsoft.com/explore/global-infrastructure/geographies/#overview).

This approach might not be feasible if you already have existing resources in the requested region, but it's the preferred solution in a dev/test scenario.

### Solution 2: Try deploying a cluster that has different settings

The infrastructure that hosts AKS managed clusters have different allocation reservations. Therefore, AKS might have more capacity for public clusters than for private clusters. If you encounter the `AksCapacityHeavyUsage` error when you try to create a private cluster, try to create a public cluster instead or vice versa.

### Solution 3: Use an Azure Enterprise subscription

When capacity is running low, we limit AKS cluster creates for customers who don't have an Enterprise Agreement (EA) subscription first in order to reserve resources for real production scenarios. Make sure that you use an EA subscription to create your AKS cluster.

### Solution 4: Retry the operation

Capacity is often reclaimed when other users stop or delete their AKS clusters. Therefore, the operation might succeed if you retry it later.

## More information

- Ensuring capacity for users is a top priority for Microsoft, and we're working around the clock to reach this goal. The increasing popularity of Azure services emphasizes the need for us to scale up our infrastructure even more rapidly. With that in mind, we're expediting expansions and improving our resource deployment process to respond to strong customer demand. We're also adding a large amount of compute infrastructure monthly.

   We have identified several methods to improve how we load-balance under a high-resource-usage situation, and how to trigger the timely deployment of needed resources. Additionally, we're significantly increasing our capacity, and will continue to plan for strong demand across all regions. [This September 2021 Azure Blog article](https://azure.microsoft.com/blog/advancing-reliability-through-a-resilient-cloud-supply-chain/) discusses improvements that we're making toward delivering a resilient cloud supply chain.

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
