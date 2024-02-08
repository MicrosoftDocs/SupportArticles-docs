---
title: Cluster autoscaler fails to scale with failed to fix group sizes error
description: Learn how to troubleshoot the failed to fix group sizes error that occurs when your autoscaler isn't scaling up or down.
ms.date: 05/17/2022
editor: v-jsitser
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-scale-operations
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the failed to fix group sizes error so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
---

# Cluster autoscaler fails to scale with "failed to fix node group sizes" error

This article discusses how to resolve the "failed to fix node group sizes" error that appears on the cluster autoscaler logs when you're creating or managing AKS clusters.

## Symptoms

Your cluster autoscaler isn't scaling up or down, and you see an error similar to the following error on the [cluster autoscaler logs](/azure/aks/monitor-aks-reference#resource-logs).

```output
E1114 09:58:55.367731 1 static_autoscaler.go:239] Failed to fix node group sizes: failed to decrease aks-default-35246781-vmss: attempt to delete existing nodes
```

## Cause

This error is caused by an upstream cluster autoscaler race condition. In such a case, cluster autoscaler ends with a different value than the one that's actually in the cluster.  

## Solution

To get out of this state, disable and re-enable the [cluster autoscaler](/azure/aks/cluster-autoscaler).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)] 
