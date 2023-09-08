---
title: Increased memory usage reported in Kubernetes 1.25 or later versions
description: Resolve an increase in memory usage that's reported after you upgrade an Azure Kubernetes Service (AKS) cluster to Kubernetes 1.25.x.
ms.date: 07/13/2023
editor: v-jsitser
ms.reviewer: aritraghosh, cssakscic, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
---
# Increased memory usage reported in Kubernetes 1.25 or later versions

This article discusses how to resolve an *increased reported memory usage* issue in Microsoft Azure Kubernetes 1.25 or a later version.

## Symptoms

You experience one or more of the following symptoms:

- Pods report increased memory usage after you upgrade a Microsoft Azure Kubernetes Service (AKS) cluster to Kubernetes 1.25 or a later version.

- A node reports memory usage that's greater than in earlier versions of Kubernetes when you run the [kubectl top node](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-node-em-) command.

- Increased pod evictions and memory pressure occur within a node.

## Cause

This increase is caused by a change in memory accounting within version 2 of the Linux control group (cgroup) API. [Cgroup v2](https://kubernetes.io/docs/concepts/architecture/cgroups/) is now the default cgroup version for Kubernetes 1.25 on AKS.

> [!NOTE]  
> This issue is distinct from the memory saturation in nodes that's caused by applications or frameworks that aren't aware of cgroup v2. For more information, see [Memory saturation occurs in pods after cluster upgrade to Kubernetes 1.25](./aks-memory-saturation-after-upgrade.md).

## Solution

- If you observe frequent memory pressure on the nodes, upgrade your subscription to increase the amount of memory that's available to your virtual machines (VMs).

- If you see a higher eviction rate on the pods, [use higher limits and requests for pods](/azure/aks/developer-best-practices-resource-management#define-pod-resource-requests-and-limits).

> [!NOTE]  
> If you experience only an increase in memory use without any of the other symptoms that are mentioned in the "Symptoms" section, you don't have to take any action.

## Status

We're actively working with the Kubernetes community to fix the underlying issue, and we'll keep you updated on our progress. We also plan to change the eviction thresholds or [resource reservations](/azure/aks/concepts-clusters-workloads#resource-reservations), depending on the outcome of the fix.

## Reference

- [Node memory usage on cgroupv2 reported higher than cgroupv1](https://github.com/kubernetes/kubernetes/issues/118916) (GitHub issue)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
