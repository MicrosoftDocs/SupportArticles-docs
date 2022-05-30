---
title: Can't view resources in Kubernetes resource viewer on Azure portal
description: Troubleshoot why you can't view resources in the Kubernetes resource viewer on the Azure portal for a cluster configured with API server-authorized IP ranges.
ms.date: 5/25/2022
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: chiragpa, nickoman
ms.service: container-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the inability to view resources in the Kubernetes resource viewer on the Azure portal so that I can use authorized IP address ranges to access my Azure Kubernetes Service (AKS) cluster configured with an API server.
---
# Can't view resources in Kubernetes resource viewer in Azure portal

If you configured your Microsoft Azure Kubernetes Service (AKS) cluster to access the cluster API server using authorized IP address ranges, you might be unable to view resources in the [Kubernetes resource viewer](/azure/aks/kubernetes-portal) on the Azure portal. To resolve this issue, make sure that when you run the [az aks create](/cli/azure/aks#az-aks-create) or [az aks update](/cli/azure/aks#az-aks-update) command in [Azure CLI](/cli/azure/install-azure-cli), the `--api-server-authorized-ip-ranges` parameter includes access for the local client computer the IP addresses or IP address ranges from which the portal is being browsed.

For more information, see [How to find my IP to include in--api-server-authorized-ip-ranges?](/azure/aks/api-server-authorized-ip-ranges#how-to-find-my-ip-to-include-in---api-server-authorized-ip-ranges).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
