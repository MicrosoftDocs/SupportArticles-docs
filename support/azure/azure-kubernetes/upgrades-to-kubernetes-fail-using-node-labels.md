---
title: Upgrades to Kubernetes 1.16 fail when using node labels with a kubernetes.io prefix
description: Learn how to troubleshoot when you can't upgrade to Kubernetes 1.16 when you're using node labels with a kubernetes.io prefix.
ms.date: 05/18/2022
editor: v-jsitser
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-upgrade-operations
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to troubleshoot the failed Kubernetes 1.16 upgrade when I'm using node labels with a kubernetes.io prefix so I can successfully upgrade to Kubernetes 1.16.
---

# Upgrades to Kubernetes 1.16 fail when node labels have a kubernetes.io prefix

This article discusses how to troubleshoot a failed upgrade to Kubernetes 1.16 when you're using node labels that have a ```kubernetes.io``` prefix.

## Symptoms

Your attempts to upgrade to Kubernetes 1.16 have failed, and you're using labels that have a ```kubernetes.io``` prefix.

## Cause

As of Kubernetes 1.16, the kubelet can only apply [a defined subset of labels with the kubernets.io prefix](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/) to nodes. Microsoft Azure Kubernetes Service (AKS) can't remove active labels on your behalf without your consent, as it might cause downtime to impacted workloads.

## Solution

To mitigate this issue:

1. Upgrade your cluster control plane to 1.16 or later.
1. Add a new node pool on 1.16 or higher without the unsupported ```kubernetes.io``` labels.
1. Delete the older node pool.

AKS is investigating the capability to mutate active labels on a node pool to improve this mitigation.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
