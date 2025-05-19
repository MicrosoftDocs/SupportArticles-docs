---
title: Troubleshoot ServiceCidrOverlapExistingSubnetsCidr Error Code
description: Learn how to resolve the ServiceCidrOverlapExistingSubnetsCidr error that occurs when you try to upgrade an Azure Kubernetes Service (AKS) cluster.
ms.date: 11/15/2023
author: jotavar
ms.author: jotavar
editor: v-jsitser
ms.reviewer: cssakscic, v-leedennis
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to troubleshoot a ServiceCidrOverlapExistingSubnetsCidr error so that I can upgrade the cluster successfully.
---

# Troubleshoot the ServiceCidrOverlapExistingSubnetsCidr error during an AKS cluster upgrade

This article discusses how to identify and resolve the "ServiceCidrOverlapExistingSubnetsCidr" error that might occur when you try to [upgrade a Microsoft Azure Kubernetes Service (AKS) cluster](/azure/aks/upgrade-aks-cluster).

## Symptoms

An AKS cluster upgrade operation fails and displays the following error message:

> (ServiceCidrOverlapExistingSubnetsCidr) The specified service CIDR \<service-cidr-1> is conflicted with an existing subnet CIDR \<subnet-cidr-2>  
> Code: ServiceCidrOverlapExistingSubnetsCidr  
> Message: The specified service CIDR \<service-cidr-1> is conflicted with an existing subnet CIDR \<subnet-cidr-2>  
> Target: networkProfile.serviceCIDR

## Cause

The service address range of a cluster is the set of virtual IP addresses that Kubernetes assigns to internal services in the cluster. This range is defined upon initial cluster creation. The range shouldn't overlap with the cluster's virtual network or any other network that can be routed from the cluster. For more information, see [Deployment parameters](/azure/aks/azure-cni-overview#deployment-parameters).

Before AKS starts an upgrade operation, it checks the cluster's virtual network for any existing subnet Classless Inter-Domain Routing (CIDR) address spaces that overlap with the cluster's service CIDR. If any such subnet overlap is found, the operation generates the "ServiceCidrOverlapExistingSubnetsCidr" error.

To resolve this issue, use one of the following solutions.

## Solution 1: Remove the overlapping subnet

> [!NOTE]  
> Use this solution if no resources are attached to the subnet.

1. Delete the subnet. To do this, follow the steps that are described in [Delete a subnet](/azure/virtual-network/virtual-network-manage-subnet#delete-a-subnet).
2. Retry the AKS cluster upgrade operation.

## Solution 2: Adjust the overlapping subnet address range

> [!NOTE]  
> Use this solution if it's acceptable to change the subnet's address range.

1. Change the subnet's address range. To do this, follow the steps that are described in [Change subnet settings](/azure/virtual-network/virtual-network-manage-subnet#change-subnet-settings).
2. Retry the AKS cluster upgrade operation.

## Solution 3: Redeploy the cluster with a different service CIDR

> [!NOTE]  
> Use this solution if it's not acceptable or not possible to remove the overlapping subnet or adjust its configuration. You can't change the cluster's service CIDR after cluster creation.

Review the [deployment parameters](/azure/aks/azure-cni-overview#deployment-parameters) and redeploy your cluster by using a different service CIDR.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
