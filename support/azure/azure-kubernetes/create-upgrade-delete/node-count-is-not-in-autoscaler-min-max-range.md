---
title: Troubleshoot current node count outside autoscaler minimum and maximum range in AKS
description: Troubleshoot why the current node count falls outside the autoscaler minimum and maximum range after you resume an AKS cluster. Learn why it happens and what to expect.
ms.date: 11/17/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, nickoman, albarqaw, v-leedennis, wonkilee, kaushika
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why the current node count isn't in the autoscaler "min" and "max" range so that I can successfully resume my Azure Kubernetes Service (AKS) cluster after a stop operation.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---
# Troubleshoot a current node count outside the autoscaler minimum and maximum range in Azure Kubernetes Service

## Summary

This article helps you troubleshoot a node count that falls outside the autoscaler minimum and maximum range when you resume an Azure Kubernetes Service (AKS) cluster after a stop operation. It explains why this behavior is expected and when the node count returns to the configured range.

## Symptoms

You're using the autoscaler for an AKS cluster. When you restart your cluster, your current node count doesn't fall within the minimum and maximum range of values that you set.

## Cause

This behavior is expected. The cluster starts by setting the number of nodes that it needs to run its workloads. Your autoscaler settings don't affect these values. When your cluster does scaling operations, the minimum and maximum values affect your current node count.

Your cluster will eventually enter and remain in the desired range until you stop the cluster.

## References

- [My cluster is below minimum / above maximum number of nodes, but CA did not fix that! Why?](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#my-cluster-is-below-minimum--above-maximum-number-of-nodes-but-ca-did-not-fix-that-why)
