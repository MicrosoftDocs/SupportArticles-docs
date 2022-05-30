---
title: Can't access the cluster API server using authorized IP ranges
description: Troubleshoot problems accessing the cluster API server when you use authorized IP address ranges in Azure Kubernetes Service (AKS).
ms.date: 5/25/2022
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: chiragpa, nickoman
ms.service: container-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot access issues to the cluster API server when I use authorized IP address ranges so that I can work with my Azure Kubernetes Service (AKS) cluster successfully.
---
# Can't access the cluster API server when using authorized IP ranges

If you create or manage a Microsoft Azure Kubernetes Service (AKS) cluster, you might not be able to use authorized IP address ranges to access the cluster API server. To resolve this issue, make sure that when you run the [az aks create](/cli/azure/aks#az-aks-create) or [az aks update](/cli/azure/aks#az-aks-update) command in [Azure CLI](/cli/azure/install-azure-cli), the `--api-server-authorized-ip-ranges` parameter includes the IP addresses or IP address ranges of the automation, development, or tooling systems that are being used.

For more information, see [How to find my IP to include in--api-server-authorized-ip-ranges?](/azure/aks/api-server-authorized-ip-ranges#how-to-find-my-ip-to-include-in---api-server-authorized-ip-ranges).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
