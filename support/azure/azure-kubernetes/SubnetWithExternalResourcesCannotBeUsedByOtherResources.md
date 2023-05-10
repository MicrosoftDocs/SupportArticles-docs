---
title: SubnetWithExternalResourcesCannotBeUsedByOtherResources
description: Provides solutions to an error that occurs when you create, upgrade or scale a Microsoft Azure Kubernetes Service cluster.
ms.date: 05/10/2023
author: axelg
ms.author: axelg
ms.reviewer: chiragpa, eddie
ms.service: azure-kubernetes-service
---
# Failed to create or upgrade or scale Azure Kubernetes Service cluster due to "Subnet with external resources cannot be used by other resources"

This article provides solutions to the "Subnet with external resources cannot be used by other resources" error that occurs when you create, upgrade or scale a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

You receive following error message while trying to perform a Create or Update operation on an AKS cluster:

> Code: SubnetWithExternalResourcesCannotBeUsedByOtherResources

> Sample error message: Message="Subnet /subscriptions/<subid>/resourceGroups/<resource group name>/providers/<provider and resource name> referenced by /subscriptions/<subid>/resourceGroups/<resource group name>/providers/<provider and resource name> cannot be used because it contains external resources. The external resources in this subnet are (<service name>, /subscriptions/<subid>/resourceGroups/<resource group name>/providers/<provider and resource name> ). You need to delete these external resources before deploying into this subnet."

  
## Cause 
  
The error message "Subnet with external resources cannot be used by other resources" is related to the configuration of subnets in Azure. It means that you are trying to use a subnet that already has external resources associated with it for another resource, which is not allowed.
According to the Azure documentation, a subnet that has external resources associated with it cannot be used by other resources. 

To resolve this issue, use one of the following solutions.

## Solution : Create a new subnet

If you need to use the subnet for another resource, you must create a new subnet and associate it with the new resource or delete the external reference including service link associate, delegation etc. You can find more information about this error message and how to resolve it in the [Azure documentation](https://learn.microsoft.com/azure/virtual-network/virtual-network-manage-subnet)
 

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
