---
title: CreateOrUpdateVirtualNetworkLinkFailed error code
description: Learn to resolve CreateOrUpdateVirtualNetworkLinkFailed errors that occur when you try to update or upgrade an Azure Kubernetes Service (AKS) cluster.
ms.date: 02/27/2024
author: axelgMS
ms.author: axelg
editor: 
ms.reviewer: chiragpa, jpalma, v-leedennis, v-weizhu
ms.service: azure-kubernetes-service
ms.subservice: common-issues
---
# Troubleshoot the "CreateOrUpdateVirtualNetworkLinkFailed" error code

This article discusses how to troubleshoot and resolve the "CreateOrUpdateVirtualNetworkLinkFailed" error code that occurs when you try to update or upgrade a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli)

## Symptoms

An AKS cluster update or upgrade operation fails and returns the following error message:

> **Code: CreateOrUpdateVirtualNetworkLinkFailed**  - SubCode: BadRequest
> 
> Message: Reconcile private dns failed
> 
> Details: Create or update virtual network link failed. Subscription: \<SubscriptionID>; resource group: \<RGName>; private dns zone: \<GUID>.privatelink.\<region>.azmk8s.io; virtual network link: \<VNET_Link>.
> 
> Message: A virtual network cannot be linked to multiple zones with overlapping namespaces. You tried to link virtual network with '\<GUID>.privatelink.\<region>.azmk8s.io' and '\<GUID>.privatelink.\<region>.azmk8s.io' zones.


## Cause

This error happens if you disassociated the original AKS cluster's private DNS zone - and you linked a private DNS zone that has the **same name** as the original one, but that other zone is located in a different Resource Group or different SubscriptionID.

That is why you see the same private DNS zone name **\<GUID>.privatelink.\<region>.azmk8s.io** in the error message. The first one is the new zone in the new Resource Group / SubscriptionID while the second one is the original one created with the AKS cluster.


## Solution

The solution here is to remove the link between the AKS Cluster's VNET and the private DNS zone created in the wrong SubscriptionID. Once this is done, you can execute the following operation and the cluster should be in a Running ProvisioningState again. 

```azurecli
az aks update  -n <myAKSCluster> -g <myResourceGroup>
```



[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
