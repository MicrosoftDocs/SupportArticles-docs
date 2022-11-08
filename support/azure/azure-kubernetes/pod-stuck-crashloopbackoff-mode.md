---
title: Pod is stuck in CrashLoopBackOff mode
description: Troubleshoot a scenario in which a pod is stuck in CrashLoopBackOff mode on an Azure Kubernetes Service (AKS) cluster.
ms.date: 7/8/2022
author: DennisLee-DennisLee
ms.author: v-dele
editor: v-jsitser
ms.reviewer: chiragpa, nickoman
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why my pod is stuck in CrashLoopBackOff mode so that I can continue to use applications that are deployed to my Azure Kubernetes Service (AKS) cluster successfully.
---
# Pod is stuck in CrashLoopBackOff mode

There are several possible reasons why your pod is stuck in `CrashLoopBackOff` mode. Consider the following options and their associated [kubectl](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands) commands.

| Option                                                                                                               | kubectl command                   |
|----------------------------------------------------------------------------------------------------------------------|-----------------------------------|
| [Debug the pod](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application/#debugging-pods) itself | `kubectl describe pod <pod-name>` |
| Examine the logs                                                                                                     | `kubectl logs <pod-name>`         |

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
