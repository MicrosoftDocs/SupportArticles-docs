---
title: Troubleshoot errors when creating or switching to an AKS Automatic cluster 
description: Learn how to troubleshoot AKS Automatic cluster errors when you create or switch clusters, and use the fixes in this guide to resolve issues quickly.
ms.date: 06/15/2026
ms.author: wangamanda
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot errors when creating or switching to an AKS Automatic cluster 

## Summary

This article provides guidance for resolving errors that occur when you create or switch to an Azure Kubernetes Service (AKS) Automatic cluster. 

## Error 1: Automatic SKU is not supported in this region

### Symptoms

When you try to create an AKS Automatic cluster, you receive the following error message: 

> Automatic SKU is not supported in this region.

### Cause

This error indicates that you can't create AKS Automatic clusters in regions where they're not generally available. 

### Solution

Create the clusters in [GA regions](/azure/aks/automatic/aks-automatic-managed-system-node-pools-about#limitations). 

## Error 2: Managed cluster `Automatic` SKU should set taint `CriticalAddonsOnlyNoSchedule` for the system node pool

### Symptoms

When you remove the `CriticalAddonsOnlyNoSchedule` taint from the system node pool of an AKS Automatic cluster, you receive the following error message: 

> Managed cluster `Automatic` SKU should set taint `CriticalAddonsOnlyNoSchedule` for the system node pool.

### Cause

You can't remove the `CriticalAddonsOnlyNoSchedule` taint from the system node pool of an AKS Automatic cluster. 

### Solution

This behavior is by design. The `CriticalAddonsOnlyNoSchedule` taint keeps system add-ons running on the system node pool instead of on the user node pool. 

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]