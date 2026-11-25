---
title: Troubleshoot the AksCapacityHeavyUsage error code in AKS
description: Learn how to troubleshoot the AksCapacityHeavyUsage error when you create or start an AKS cluster. Apply the recommended fixes to deploy successfully today.
ms.date: 11/23/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, anbubin, v-leedennis, axelg, kaushika
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---
# Troubleshoot the AksCapacityHeavyUsage error code in Azure Kubernetes Service

## Summary

This article explains how to resolve the `AksCapacityHeavyUsage` error code when you create an Azure Kubernetes Service (AKS) cluster, so that you can complete your deployment successfully.

## Symptoms

When you try to create an AKS cluster, you receive the following error message.

> **Code:** AksCapacityHeavyUsage
>
> **Message:** AKS is experiencing heavy usage in region \<Region>. We are working on adding new capacity. In the meantime, please consider creating new AKS clusters in a different region. For a list of all the Azure regions, visit https://aka.ms/aks/regions. For more details on this error, visit https://aka.ms/akscapacityheavyusage.

## Cause

You're trying to create a cluster in a region that has limited capacity.

When you create an AKS cluster, Microsoft Azure allocates compute resources to your subscription. You might occasionally experience the `AksCapacityHeavyUsage` error because of significant growth in demand for AKS in specific regions.

If you're creating an AKS Automatic cluster with managed system node pools preconfigured, Azure allocates compute resources for the system node pools in Azure subscriptions instead of your subscriptions. You might occasionally experience the `AksCapacityHeavyUsage` error because of significant growth in demand for AKS in specific regions. 

## Resolution

### Solution 1: Select a different Azure region

The easiest and quickest solution is to try to deploy to a different region (for example, North Europe instead of West Europe or UAE North instead of Qatar Central). To find nearby regions, visit the [Azure Geographies page](https://azure.microsoft.com/explore/global-infrastructure/geographies/#overview).

For AKS Automatic clusters, you can try to deploy to [one of the GA regions](/azure/aks/automatic/aks-automatic-managed-system-node-pools-about#limitations). 

This approach might not be feasible if you already have existing resources in the requested region, but it's the preferred solution in a dev/test scenario.

### Solution 2: Deploy a cluster that has different settings

The infrastructure that hosts AKS-managed clusters uses different allocation reservations. Therefore, AKS might have more capacity for public clusters than it has for private clusters. If you experience the `AksCapacityHeavyUsage` error when you try to create a private cluster, try to create a public cluster instead (or vice versa).

### Solution 3: Use an Azure Enterprise Agreement subscription

When capacity is running low, non-Enterprise Agreement (EA) subscriptions are limited first in AKS cluster creation to reserve resources for real production scenarios. If you have an EA subscription, make sure that you use the EA subscription to create the AKS cluster.

### Solution 4: Retry the operation

Capacity is often reclaimed when other users stop or delete their AKS clusters. Therefore, the operation might succeed if you retry it later.

## References

- Ensuring capacity for users is a top priority for Microsoft, and the company is working to scale up its infrastructure to accommodate the increasing popularity of Azure services. For more information about improvements that Microsoft is making toward delivering a resilient cloud supply chain, see [this September 2021 Azure Blog article](https://azure.microsoft.com/blog/advancing-reliability-through-a-resilient-cloud-supply-chain/).
- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)