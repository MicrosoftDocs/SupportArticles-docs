---
title: Troubleshoot the network isolated Azure Kubernetes Service (AKS) cluster
description: Learn how to troubleshoot the network isolated cluster to the Azure Kubernetes Service (AKS).
ms.service: azure-kubernetes-service
ms.date: 04/09/2025
editor: charleswool
ms.reviewer: chasedmicrosoft
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot problems that involve the network isolated cluster so that I can successfully use this feature on Azure Kubernetes Service (AKS).
ms.custom: sap:Extensions, Policies and Add-Ons
---

# Troubleshoot the network isolated Azure Kubernetes Service (AKS) cluster

This article discusses how to troubleshoot the [network isolated cluster][network-isolated-cluster] to the Microsoft Azure Kubernetes Service (AKS). 

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool. To install kubectl by using the [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Network isolated cluster support

The network isolated cluster follows a similar support model to other [AKS add-ons](/azure/aks/integrations). There are two options available for the private Azure Container Registry (ACR) with network isolated clusters. If you're bringing your own ACR, then you're responsible for properly configuring your ACR and associated resources.

## Known issues

### Cluster image pulls failed
Network isolated clusters use ACR cache rules for image pull, when there is an image pull fail error due to network isolation:
- If you're using Bring your own (BYO) ACR, check your private ACR resources, including the cache rule and private endpoints to verify they're configured using recommendations outlined in the documentation.
- If you're using AKS Managed ACR, only MCR images are supported by default. If the image pull failure is on images from other registries, then you need go to the private ACR to create extra cache rules for those images. If the image pull failure is on MCR images， proceed to check if the associated ACR and private endpoint resource named with keyword `bootstrap` exists. If it doesn't exist, reconcile the cluster.

### Cluster image pull fails after updating the existed cluster to network isolated cluster or updating the private ACR resource ID
The error is an intended behavior. You need to reimage the node to update the kubelet configuration in CSE (Container Service Extension) following the update actions mentioned.

### ACR or associated cache rule, private endpoint and private DNS zone are deleted accidentally
If the cache rule is deleted from the managed ACR accidentally, the mitigation is to delete the ACR and then reconcile the cluster. If the ACR itself or private endpoint or private DNS zone is deleted by accident, the mitigation is just to reconcile the cluster.



[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[network-isolated-cluster]: /azure/aks/concepts-network-isolated