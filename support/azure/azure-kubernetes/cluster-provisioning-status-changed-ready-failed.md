---
title: Cluster provisioning status changed from Ready to Failed
description: Troubleshoot why the provisioning status of my Azure Kubernetes Service (AKS) cluster changed from Ready to Failed, even if I didn't do an operation.
ms.date: 5/25/2022
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: chiragpa, nickoman
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why the provisioning status of my cluster changed from Ready to Failed, even if I didn't do an operation, so that I can successfully use my Azure Kubernetes Service (AKS) cluster.
---
# Change in cluster provisioning status from Ready to Failed

If the provisioning status of your Microsoft Azure Kubernetes Service (AKS) cluster changed from **Ready** to **Failed**, even if you didn't do an operation, AKS may resolve the provisioning status automatically if your cluster applications continue to run. Your running applications shouldn't be affected by the provisioning status change.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
