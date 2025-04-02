---
title: Increased memory usage reported in Kubernetes 1.25 or later versions
description: Resolve an increase in memory usage that's reported after you upgrade an Azure Kubernetes Service (AKS) cluster to Kubernetes 1.25.x.
ms.date: 03/03/2025
editor: momajed
ms.reviewer: aritraghosh, cssakscic, v-leedennis
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Increased memory usage reported in Kubernetes 1.25 or later versions

This article discusses how to resolve an *increased reported memory usage* issue in Microsoft Azure Kubernetes 1.25 or a later version.

## Symptoms

You experience one or more of the following symptoms:

- Pods report increased memory usage after you upgrade a Microsoft Azure Kubernetes Service (AKS) cluster to Kubernetes 1.25 or a later version.

- A node reports memory usage that's greater than in earlier versions of Kubernetes when you run the [kubectl top node](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-node-em-) command.

- Increased pod evictions and memory pressure occur within a node.

## Cause

This increase is caused by a change in memory accounting within version 2 of the Linux control group (`cgroup`) API. [Cgroup v2](https://kubernetes.io/docs/concepts/architecture/cgroups/) is now the default `cgroup` version for Kubernetes 1.25 on AKS.

> [!NOTE]  
> This issue is distinct from the memory saturation in nodes that's caused by applications or frameworks that aren't aware of `cgroup` v2. For more information, see [Memory saturation occurs in pods after cluster upgrade to Kubernetes 1.25](./aks-memory-saturation-after-upgrade.md).

## Solution

- If you observe frequent memory pressure on the nodes, upgrade your subscription to increase the amount of memory that's available to your virtual machines (VMs).

- If you see a higher eviction rate on the pods, [use higher limits and requests for pods](/azure/aks/developer-best-practices-resource-management#define-pod-resource-requests-and-limits).

- `cgroup` v2 uses a different API than `cgroup` v1. If there are any applications that directly access the `cgroup` file system, update them to later versions that support `cgroup` v2. For example:

  - **Third-party monitoring and security agents**:

     Some monitoring and security agents depend on the `cgroup` file system. Update these agents to versions that support `cgroup` v2.

  - **Java applications**:

     Use versions that fully support `cgroup` v2:
    - OpenJDK/HotSpot: `jdk8u372`, `11.0.16`, `15`, and later versions.
    - IBM Semeru Runtimes: `8.0.382.0`, `11.0.20.0`, `17.0.8.0`, and later versions.
    - IBM Java: `8.0.8.6` and later versions.

  - **uber-go/automaxprocs**:  
    If you're using the `uber-go/automaxprocs` package, ensure the version is `v1.5.1` or later.

- An alternative temporary solution is to revert the `cgroup` version on your nodes by using the DaemonSet. For more information, see [Revert to cgroup v1 DaemonSet](https://github.com/Azure/AKS/blob/master/examples/cgroups/revert-cgroup-v1.yaml).

> [!IMPORTANT]
> - Use the DaemonSet cautiously. Test it in a lower environment before applying to production to ensure compatibility and prevent disruptions.
> - By default, the DaemonSet applies to all nodes in the cluster and reboots them to implement the `cgroup` change.  
> - To control how the DaemonSet is applied, configure a `nodeSelector` to target specific nodes.


> [!NOTE]  
> If you experience only an increase in memory use without any of the other symptoms that are mentioned in the "Symptoms" section, you don't have to take any action.

## Status

We're actively working with the Kubernetes community to resolve the underlying issue. Progress on this effort can be tracked at [Azure/AKS Issue #3443](https://github.com/kubernetes/kubernetes/issues/118916). 

As part of the resolution, we plan to adjust the eviction thresholds or update [resource reservations](/azure/aks/concepts-clusters-workloads#resource-reservations), depending on the outcome of the fix.

## Reference

- [Node memory usage on cgroupv2 reported higher than cgroupv1](https://github.com/kubernetes/kubernetes/issues/118916) (GitHub issue)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
