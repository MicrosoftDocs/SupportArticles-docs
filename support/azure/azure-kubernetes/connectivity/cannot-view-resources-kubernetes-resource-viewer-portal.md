---
title: Can't view resources in Kubernetes resource viewer on Azure portal
description: Troubleshoot why you can't view resources in the Kubernetes resource viewer in the Azure portal for a cluster configured with API server-authorized IP ranges.
ms.date: 04/14/2025
ms.reviewer: edneto, chiragpa, nickoman, jaewonpark, v-leedennis
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the inability to view resources in the Kubernetes resource viewer in the Azure portal so that I can use authorized IP address ranges to access my AKS cluster that's configured with an API server.
ms.custom: sap:Connectivity
---
# Can't view resources in Kubernetes resource viewer in Azure portal

This article discusses how to resolve an issue that prevents you from using the Azure portal to view resources in the Kubernetes resource viewer.

## Symptoms

When you try to view resources in the [Kubernetes resource viewer](/azure/aks/kubernetes-portal) in the [Azure portal](https://portal.azure.com), you receive the following error message:

> `Unable to reach the API server '<server-url>' or API is too busy to response. Check your network setting`.

:::image type="content" source="media/cannot-view-resources-kubernetes-resource-viewer-portal/network-error.png" alt-text="Screenshot of workloads in the AKS resource." lightbox="media/cannot-view-resources-kubernetes-resource-viewer-portal/network-error.png":::

## Cause 1: You configured authorized IP ranges

You configured your Microsoft Azure Kubernetes Service (AKS) cluster to access the cluster API server by using authorized IP address ranges that your computer can't access.

### Solution

When you run the [az aks create](/cli/azure/aks#az-aks-create) or [az aks update](/cli/azure/aks#az-aks-update) command in [Azure CLI](/cli/azure/install-azure-cli), make sure that the `--api-server-authorized-ip-ranges` parameter includes access for the local client computer to the IP addresses or IP address ranges from which the portal is being browsed.

## Cause 2: AKS is a private cluster

Your AKS is created as a private cluster, and you're accessing the Azure portal from a network that can't communicate with the subnet to which your AKS is connected.

### Solution

This behavior is expected. To view the AKS resources in the Azure portal, you must access the Azure portal from a client that's located on a network that has connectivity to the AKS subnet. Then, you can view all AKS-related resources in the Azure portal.

## More information

- [How to find my IP to include in --api-server-authorized-ip-ranges?](/azure/aks/api-server-authorized-ip-ranges#how-to-find-my-ip-to-include-in---api-server-authorized-ip-ranges)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
