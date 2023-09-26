---
title: Current node count isn't in the autoscaler min and max range
description: Troubleshoot why the current node count isn't in the autoscaler minimum and maximum range when you resume an Azure Kubernetes Service cluster after a stop operation.
ms.date: 07/06/2022
editor: v-jsitser
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why the current node count isn't in the autoscaler "min" and "max" range so that I can successfully resume my Azure Kubernetes Service (AKS) cluster after a stop operation.
---
# Current node count is outside the autoscaler min and max range

## Symptoms

You're using the autoscaler for a Microsoft Azure Kubernetes Service (AKS) cluster. When you restart your cluster, your current node count doesn't fall within the minimum and maximum range of values that you set.

## Cause

This behavior is expected. The cluster starts by setting the number of nodes that it needs to run its workloads. These values aren't affected by your autoscaler settings. When your cluster does scaling operations, the minimum and maximum values will affect your current node count.

## More information

Your cluster will eventually enter and remain in the desired range until you stop the cluster.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
