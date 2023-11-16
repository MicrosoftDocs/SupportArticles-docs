---
title: Troubleshoot the InvalidResourceReference error code
description: Learn how to troubleshoot the InvalidResourceReference error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 10/07/2023
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, v-weizhu
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-create-operations
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the InvalidResourceReference error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot the InvalidResourceReference error code

This article discusses how to identify and resolve the `InvalidResourceReference` error that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to create an AKS cluster, you receive the following error message:

> Code="InvalidResourceReference"
>
> Message="Resource  
> **/subscriptions/*\<subscription-id-guid>*/resourceGroups/MyResourceGroup/providers/Microsoft.Network/virtualNetworks/vnet-otcom/subnets/Subnet-AKS**  
> referenced by resource  
> **/subscriptions/*\<subscription-id-guid>*/resourceGroups/MC_MyResourceGroup_MyCluster-AKS_JAPANEAST/providers/Microsoft.Compute/virtualMachineScaleSets/aks-nodepool-vmss**  
> was not found. Please make sure that the referenced resource exists, and that both resources are in the same region."
>
> Details=[]

## Cause

A mismatch exists between resources in different regions. In the example in the "Symptoms" section, the virtual network and the virtual machine scale set aren't in the same region. Because the resources are in different regions, it's impossible to create the scale set instance.

## Solution

Review the resources to make sure that they're in the same region. In this example, either modify the region that the AKS cluster is being built in, or create a new virtual network in the same region.

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
