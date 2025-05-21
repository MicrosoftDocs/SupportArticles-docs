---
title: Troubleshoot Network Isolated AKS Clusters
description: Learn how to troubleshoot network isolated cluster issues on Azure Kubernetes Service (AKS).
ms.service: azure-kubernetes-service
ms.date: 04/15/2025
ms.reviewer: doveychase, yuewu2, v-weizhu
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot problems that involve the network isolated cluster so that I can successfully use this feature on Azure Kubernetes Service (AKS).
ms.custom: sap:Extensions, Policies and Add-Ons
---
# Troubleshoot network isolated Azure Kubernetes Service (AKS) cluster issues

This article discusses how to troubleshoot issues in [network isolated Azure Kubernetes Service (AKS) clusters](/azure/aks/concepts-network-isolated).

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool. You can install kubectl by running the [Azure CLI](/cli/azure/install-azure-cli) command [az aks install-cli](/cli/azure/aks#az-aks-install-cli).

## Network isolated cluster support

The network isolated cluster follows a similar support model to other [AKS add-ons](/azure/aks/integrations). When using a network isolated cluster with Azure Container Registry (ACR), you have two options:

- Bring Your Own (BYO) ACR
- AKS-managed ACR

If you choose BYO ACR, you're responsible for configuring your ACR and its associated resources properly.

## Issue 1: Cluster image pull fails due to network isolation

Network isolated clusters use ACR cache rules for image pulls. If an image pull fails due to network isolation, follow these steps:

- For BYO ACR:

    Verify that the private ACR resources are configured, including the cache rule and private endpoints. For more information about how to configure them, see steps 3 and 4 under the [Deploy a network isolated cluster with bring your own ACR](/azure/aks/network-isolated?pivots=byo-acr#deploy-a-network-isolated-cluster-with-bring-your-own-acr) section.
- For AKS-managed ACR:

  - By default, only Microsoft Container Registry (MCR) images are supported. If the image pull failure occurs with MCR images, check if the associated ACR and private endpoint resource named with the keyword `bootstrap` exist. If they don't exist, reconcile the cluster.
  - If the image pull failure occurs with images from other registries, create extra cache rules in the private ACR for those images.
  
## Issue 2: Cluster image pull fails after updating an existing cluster to a network isolated cluster or updating the private ACR resource ID

The failure is an intended behavior. To resolve this issue, reimage the node to update the kubelet configuration in Container Service Extension (CSE) following the update actions in [Update your ACR ID](/azure/aks/network-isolated?pivots=byo-acr#update-your-acr-id).

## Issue 3: ACR or associated cache rules, private endpoints, or private DNS zones are deleted

If the cache rule is deleted from the managed ACR accidentally, the mitigation is to delete the ACR and then reconcile the cluster. If the ACR itself, the associated private endpoints, or the associated private DNS zones are deleted accidentally, the mitigation is just to reconcile the cluster.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
