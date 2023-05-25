---
title: AKS cluster error code SubnetWithExternalResourcesCannotBeUsedByOtherResources
description: Provides solutions to an error that occurs when you create, upgrade, or scale a Microsoft Azure Kubernetes Service cluster.
ms.date: 05/25/2023
author: axelgMS
ms.author: axelg
ms.reviewer: chiragpa, eddie
ms.service: azure-kubernetes-service
---
# Troubleshoot the SubnetWithExternalResourcesCannotBeUsedByOtherResources error code

This article provides solutions to the "SubnetWithExternalResourcesCannotBeUsedByOtherResources" error code that occurs when you create, update, or scale a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When attempting to create an AKS cluster or perform an "update" or "scale" operation on an existing AKS cluster, you may encounter the following error message:

> Code: SubnetWithExternalResourcesCannotBeUsedByOtherResources  
> Error Message: Subnet \<URI of subnet1> referenced by \<URI of the AKS resource referencing the subnet1> cannot be used because it contains external resources. The external resources in this subnet are \<URI of the external reference used by subnet1>. You need to delete these external resources before deploying into this subnet.

## Cause

This error is related to the configuration of subnets. It means that you're trying to use a subnet that already has external resources associated with it for another resource. However, a subnet that has external resources associated with it isn't allowed to be used by other resources. For more information, see [Effect of subnet delegation on your subnet](/azure/virtual-network/subnet-delegation-overview#effect-of-subnet-delegation-on-your-subnet).

## Solution
  
If you need to use the subnet for another resource, use one of the following methods:

- Create a new subnet and associate it with the new resource.
- Delete the external references, including service association links, subnet delegations, and so on.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
