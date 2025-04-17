---
title: Memory saturation occurs after upgrade to Kubernetes 1.25
description: Resolve pod failures caused by memory saturation and out-of-memory errors after you upgrade an Azure Kubernetes Service (AKS) cluster to Kubernetes 1.25.x.
ms.date: 04/17/2025
editor: v-jsitser,momajed
ms.reviewer: aritraghosh, cssakscic, v-leedennis,momajed
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Memory saturation occurs in pods after cluster upgrade to Kubernetes 1.25

This article discusses how to fix pods that stop working because of memory saturation or out-of-memory (OOM) errors that occur after you upgrade a Microsoft Azure Kubernetes Service (AKS) cluster to Kubernetes 1.25.*x*.

## Symptoms

One or more of the following issues occur:

- Memory pressure on nodes

- Increased memory usage for apps when compared to their memory usage before the upgrade

- CPU throttling on nodes

- Pod failure because of OOM errors

Performance degradation can occur in apps that run in the following environments:

- Java Runtime Environment (JRE) (for [JRE versions that are earlier than version 11.0.18 or version 1.8.0 372](https://bugs.java.com/bugdatabase/view_bug?bug_id=8230305))
- .NET versions that are earlier than version 5.0
- [Node.js](https://github.com/nodejs/node/issues/47259)

> [!NOTE]  
> This list of environments in which performance degradation can occur isn't a comprehensive list. There might be other environments that experience memory saturation or OOM issues.

## Solution

Beginning in the release of Kubernetes 1.25, the [cgroup version 2 API](https://kubernetes.io/blog/2022/08/31/cgroupv2-ga-1-25/) has reached general availability (GA). AKS now uses Ubuntu Linux version 22.04. By default, version 22.04 uses cgroup version 2 API. To make sure the cgroup version 2 API is available for use in other environments to prevent the memory saturation issue, follow this guidance:

- If you run Java applications, [upgrade to a Java version that supports cgroup version 2](https://kubernetes.io/blog/2022/08/31/cgroupv2-ga-1-25/#migrate-to-cgroup-v2) and follow the guidance in [Containerize your Java applications](/azure/developer/java/containers/overview). You might be able to update the base image in certain versions in which the fix has been backported. Use a version or framework that natively supports cgroup version 2. For Azure customers, Microsoft officially supports [Eclipse Temurin](https://adoptium.net/) binaries (Java 8) and [Microsoft Build of OpenJDK](https://www.microsoft.com/openjdk) binaries (Java 11+).

- Similarly, if you're using .NET, upgrade to [.NET version 5.0](https://devblogs.microsoft.com/dotnet/announcing-net-5-0/#containers) or a later version.

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

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
