---
title: Current node count isn't in the autoscaler min and max range
description: Troubleshoot why the current node count isn't in the autoscaler min and max range when you resume an Azure Kubernetes Service cluster after a stop operation.
ms.date: 5/25/2022
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: chiragpa, nickoman
ms.service: container-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why the current node count isn't in the autoscaler min and max range so that I can successfully resume my Azure Kubernetes Service (AKS) cluster after a stop operation.
---
# Troubleshoot current node count being outside the autoscaler min and max range

If you're using the autoscaler for a Microsoft Azure Kubernetes Service (AKS) cluster, when you start your cluster back up, your current node count might not be between the minimum and maximum range of values that you set. This behavior is expected. The cluster starts with the number of nodes that it needs to run its workloads, which isn't impacted by your autoscaler settings. When your cluster does scaling operations, the minimum and maximum values will impact your current node count. Your cluster will eventually enter and remain in that desired range until you stop your cluster.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
