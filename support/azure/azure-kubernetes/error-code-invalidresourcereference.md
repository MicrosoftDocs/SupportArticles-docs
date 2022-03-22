---
title: Troubleshoot the InvalidResourceReference error code
description: Learn how to troubleshoot the InvalidResourceReference error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 3/10/2022
author: DennisLee-DennisLee
ms.author: v-dele
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi
ms.service: container-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the InvalidResourceReference error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot the InvalidResourceReference error code

This article describes how to identify and resolve the `InvalidResourceReference` error, which might occur if you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to create the cluster, you receive the following error message:

> Code="InvalidResourceReference"
>
> Message="Resource /subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/MyResourceGroup/providers/Microsoft.Network/virtualNetworks/vnet-otcom/subnets/Subnet-AKS referenced by resource /subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/MC_MyResourceGroup_MyCluster-AKS_JAPANEAST/providers/Microsoft.Compute/virtualMachineScaleSets/aks-nodepool1-13686447-vmss was not found. Please make sure that the referenced resource exists, and that both resources are in the same region."
>
> Details=[]

## Cause

There's a mismatch between resources in different regions. In the example above, the virtual network and the virtual machine scale set aren't in the same region. With the resources being in different regions, it's impossible to create the scale set instance.

## Solution

Review the resources to make sure they're in the same region. In this example, either modify the region that the AKS cluster is being built in, or create a new virtual network in the same region.

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)
