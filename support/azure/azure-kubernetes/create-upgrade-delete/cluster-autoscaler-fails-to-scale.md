---
title: Cluster autoscaler fails to scale with failed to fix group sizes error in AKS
description: Learn how to resolve the cluster autoscaler "failed to fix node group sizes" error in AKS when scaling stops working. Follow these steps to restore scaling.
ms.date: 11/11/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, nickoman, albarqaw, v-leedennis, v-weizhu, kaushika
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the failed to fix group sizes error so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---

# Cluster autoscaler fails to scale with "failed to fix node group sizes" error in Azure Kubernetes Service

## Summary

This article explains how to resolve the cluster autoscaler "failed to fix node group sizes" error in Azure Kubernetes Service (AKS). Use the solution to restore scaling up and down when the autoscaler is stuck.

## Symptoms

Your cluster autoscaler isn't scaling up or down, and you see an error similar to the following error in the [cluster autoscaler logs](/azure/aks/monitor-aks-reference#resource-logs).

```output
E1114 09:58:55.367731 1 static_autoscaler.go:239] Failed to fix node group sizes: failed to decrease aks-default-35246781-vmss: attempt to delete existing nodes
```

## Cause

This error is caused by an upstream cluster autoscaler race condition. In this case, cluster autoscaler gets stuck in a deadlock. For more information, see [cluster-autoscaler gets stuck with "Failed to fix node group sizes" error](https://github.com/kubernetes/autoscaler/issues/6128).

## Solution

To get out of this state, disable and re-enable the [cluster autoscaler](/azure/aks/cluster-autoscaler).