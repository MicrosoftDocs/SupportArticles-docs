---
title: Can't view resources in Kubernetes resource viewer on Azure portal
description: Troubleshoot why you can't view resources in the Kubernetes resource viewer on the Azure portal for a cluster configured with API server-authorized IP ranges.
ms.date: 06/08/2022
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the inability to view resources in the Kubernetes resource viewer on the Azure portal so that I can use authorized IP address ranges to access my Azure Kubernetes Service (AKS) cluster configured with an API server.
---
# Can't view resources in Kubernetes resource viewer in Azure portal

This article discusses how to resolve a scenario in which you can't use the Azure portal to view resources in the Kubernetes resource viewer.

## Symptoms

You aren't able to view resources in the [Kubernetes resource viewer](/azure/aks/kubernetes-portal) on the [Azure portal](https://portal.azure.com).

## Cause

You configured your Microsoft Azure Kubernetes Service (AKS) cluster to access the cluster API server by using authorized IP address ranges that your computer can't access.

## Solution

Make sure that when you run the [az aks create](/cli/azure/aks#az-aks-create) or [az aks update](/cli/azure/aks#az-aks-update) command in [Azure CLI](/cli/azure/install-azure-cli), the `--api-server-authorized-ip-ranges` parameter includes access for the local client computer to the IP addresses or IP address ranges from which the portal is being browsed.

## More information

- [How to find my IP to include in --api-server-authorized-ip-ranges?](/azure/aks/api-server-authorized-ip-ranges#how-to-find-my-ip-to-include-in---api-server-authorized-ip-ranges)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
