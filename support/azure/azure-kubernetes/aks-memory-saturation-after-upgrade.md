---
title: Memory saturation occurs after upgrade to Kubernetes 1.25
description: Resolve pod failures caused by memory saturation and out-of-memory errors after you upgrade an Azure Kubernetes Service (AKS) cluster to Kubernetes 1.25.x.
ms.date: 06/14/2023
editor: v-jsitser
ms.reviewer: aritraghosh, cssakscic, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
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

In addition, to enable pods to use more resources, increase their memory requests and limits.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
