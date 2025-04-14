---
title: Troubleshoot network isolated AKS clusters
description: Learn how to troubleshoot network isolated cluster issues in Azure Kubernetes Service (AKS).
ms.service: azure-kubernetes-service
ms.date: 04/14/2025
ms.reviewer: doveychase, yuewu2, v-weizhu
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot problems that involve the network isolated cluster so that I can successfully use this feature on Azure Kubernetes Service (AKS).
ms.custom: sap:Extensions, Policies and Add-Ons
---
# Troubleshoot network isolated Azure Kubernetes Service (AKS) clusters issues

This article discusses how to troubleshoot issues on [network isolated Azure Kubernetes Service (AKS) clusters](/azure/aks/concepts-network-isolated).

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool. To install kubectl by using the [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Network isolated cluster support

The network isolated cluster follows a similar support model to other [AKS add-ons](/azure/aks/integrations). There are two options available for the private Azure Container Registry (ACR) with network isolated clusters. If you're using Bring your own (BYO) ACR, you're responsible for properly configuring your ACR and associated resources.

## Issue 1: Cluster image pull fails due to network isolation

Network isolated clusters use ACR cache rules for image pull. When an image pull faiure occurs due to network isolation:

- If you're using Bring your own (BYO) ACR, check your private ACR resources, including the cache rule and private endpoints, to verify they're configured using recommendations outlined in the documentation.
- If you're using AKS-managed ACR, only Microsoft Container Registry (MCR) images are supported by default. If the image pull failure occurs on images from other registries, go to the private ACR to create extra cache rules for those images. If the image pull failure occurs on MCR images，proceed to check if the associated ACR and private endpoint resource named with keyword `bootstrap` exist. If they don't exist, reconcile the cluster.

## Issue 2: Cluster image pull fails after updating the existed cluster to network isolated cluster or updating the private ACR resource ID

The failure is an intended behavior. You need to reimage the node to update the kubelet configuration in Container Service Extension (CSE) following the update actions mentioned.

## Issue 3: ACR or associated cache rule, private endpoint or private DNS zone are deleted

If the cache rule is deleted from the managed ACR accidentally, the mitigation is to delete the ACR and then reconcile the cluster. If the ACR itself, associated private endpoint, or associated private DNS zone is deleted by accident, the mitigation is just to reconcile the cluster.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]