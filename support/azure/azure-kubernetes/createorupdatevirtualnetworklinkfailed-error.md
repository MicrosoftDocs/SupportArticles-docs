---
title: CreateOrUpdateVirtualNetworkLinkFailed error code 
description: Provides a solution to the CreateOrUpdateVirtualNetworkLinkFailed error that occurs when you try to update or upgrade an Azure Kubernetes Service (AKS) cluster.
ms.date: 03/13/2024
ms.reviewer: axelg, chiragpa, jpalma, v-weizhu
ms.service: azure-kubernetes-service
ms.subservice: common-issues
---
# "CreateOrUpdateVirtualNetworkLinkFailed" error when updating or upgrading an AKS cluster

This article provides a solution to the "CreateOrUpdateVirtualNetworkLinkFailed" error code that occurs when you try to update or upgrade a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

[Azure CLI](/cli/azure/install-azure-cli)

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

This error happens in this scenario:

- You disassociate the original private Domain Name System (DNS) zone of the AKS cluster.
- You link a private DNS zone that has the same name as the original zone but is located in a different resource group or subscription.

That's why you see the same private DNS zone name "\<GUID>.privatelink.\<region>.azmk8s.io" in the error message. The first is the new zone in the new resource group or subscription, while the second is the original zone created with the AKS cluster.


## Solution

To resolve this issue, follow these steps:

1. Remove the link between the AKS cluster's virtual network (VNET) and the private DNS zone created in the wrong resource group or subscription.
1. Update the cluster by running the following command:

    ```azurecli
    az aks update  -n <myAKSCluster> -g <myResourceGroup>
    ```

    The command output should show the cluster's `ProvisioningState` as `Running`. 

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
