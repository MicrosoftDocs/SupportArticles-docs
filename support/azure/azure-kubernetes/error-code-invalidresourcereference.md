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

This article discusses how to identify and resolve the `InvalidResourceReference` errors that may occur when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster, or when you update it.

## Symptom 1

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


## Symptom 2

When you try to update an AKS cluster, you receive the following error message:

> Code="InvalidResourceReference"
> Message="Resource
> /subscriptions/*\<subscription-id-guid>*/resourceGroups/MC_MyResourceGroup/providers/Microsoft.Network/loadBalancers/kubernetes/frontendIPConfigurations/a050f0cc3817a457c9538fe3df7acdb0 referenced by resource /subscriptions/*\<subscription-id-guid>*/resourceGroups/MC_MyResourceGroup/providers/Microsoft.Network/loadBalancers/kubernetes/**loadBalancingRules/a050f0cc3817a457c9538fe3df7acdb0-TCP-80 was not found.** Please make sure that the referenced resource exists, and that both resources are in the same region."
> Message="Resource  
>
> Details=[]

## Cause

This might occur if the default aksOutboundRule on the load balancer has been manually modified. This most commonly happens when that outbound IP was updated without using the --load-balancer-outbound-ips flag when updating the cluster.

## Solution

Re-run the failed command with the --load-balancer-outbound-ips flag, passing in the resource ID of the public IP as a value.

## More information

- [Update the cluster with your own outbound public IP](../azure/aks/load-balancer-standard#update-the-cluster-with-your-own-outbound-public-ip)



[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
